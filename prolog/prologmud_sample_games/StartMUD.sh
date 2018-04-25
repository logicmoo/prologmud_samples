#!/bin/bash

SOURCED=0
if [ -n "$ZSH_EVAL_CONTEXT" ]; then 
    [[ $ZSH_EVAL_CONTEXT =~ :file$ ]] && SOURCED=1
elif [ -n "$KSH_VERSION" ]; then
    [[ "$(cd $(dirname -- $0) && pwd -P)/$(basename -- $0)" != "$(cd $(dirname -- ${.sh.file}) && pwd -P)/$(basename -- ${.sh.file})" ]] && SOURCED=1
elif [ -n "$BASH_VERSION" ]; then
    [[ $0 != "$BASH_SOURCE" ]] && SOURCED=1
elif grep -q dash /proc/$$/cmdline; then
    case $0 in *dash*) SOURCED=1 ;; esac
fi

fg
fg
fg

if [[ "$SOURCED"=="1" ]] ; then
    echo "The script was sourced."
else
    echo "The script WAS NOT sourced."
fi

# #( mkdir -p /tmp/tempDir/ ; cp -a tempDir/?* /tmp/tempDir/?* ;  cd  /tmp/tempDir/ ; ln  -s * -r /home/prologmud_server/lib/swipl/pack/prologmud_samples/prolog/prologmud_sample_games/ )

#cls ; killall -9 swipl perl ; killall -9 swipl perl ;  swipl --irc --world --repl -g "[run_mud_server]" -s run_clio.pl
#cls ; killall -9 swipl-prologmud perl ; killall -9 swipl perl ;  swipl -l run.pl -l run_mud_server.pl --irc --world --clio

export OLDPWD="`pwd`"
export NEWPWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#export SWIPL=/usr/local/lib/swipl-7.1.11/bin/x86_64-linux/swipl

export LD_LIBRARY_PATH=/usr/lib/jvm/java-8-oracle/jre/lib/amd64/server/

cp $LOGICMOO_WS/packs_xtra/golorp/?*.txt $NEWPWD/
rsync -avh $LOGICMOO_WS/packs_usr/prologmud_samples/prolog/prologmud_sample_games/tempDir /tmp/
chmod a+w -R /tmp/tempDir
chmod a+w -R /tmp/tempDir/?*
chmod a+w -R /tmp/tempDir/?*/ 

( cd $LOGICMOO_WS/packs_sys/eggdrop/conf/ ; eggdrop )

if [[ -z "${LOGICMOO_BASE_PORT}" ]]; then
  LOGICMOO_BASE_PORT=3000
fi

#export RL_PREFIX='rlwrap -a -A -r -c -N -r'
export USE_NET=1
export USE_KB=0
export KBFILE=""


for i in "$@" ; do
   if [[ $i == "--nonet" ]] ; then export  USE_NET=0; fi
   if [[ $i == "-x" ]] ; then export USE_KB=0; fi     
   if [[ $i == "--prc" ]] ; then export USE_KB=1; fi
   if [[ $i == "--nocyc" ]] ; then export USE_KB=0; fi
done

if [ $USE_KB == 1 ]; then

   export KBFILE='-x kb7166.prc'

   if [ ! -f ./kb7166.prc ]; then
      if [ ! -f ./kb7166.zip ]; then
      echo download https://www.dropbox.com/s/0dc1ec7ehse8vve/kb7166.zip?dl=1
         wget -O ./kb7166.zip -N https://www.dropbox.com/s/0dc1ec7ehse8vve/kb7166.zip?dl=1
      fi
      unzip -o ./kb7166.zip
   fi
   if [ ! -f ./kb7166.prc ]; then
      echo cant find $(pwd)/kb7166.prc
      export KBFILE=""
   fi
else
   export KBFILE=""
fi


. setup_env.sh

echo LOGICMOO_WS=$LOGICMOO_WS
echo LOGICMOO_BASE_PORT=$LOGICMOO_BASE_PORT

export SWIPL="$LOGICMOO_WS/bin/swipl-prologmud -G18G -L18G -T18G"
export CMDARGS="-l run_mud_server.pl --all --world --pdt --repl --lisp --lispsock --sumo --planner --cliop --sigma --www --irc --swish --docs --plweb --elfinder"
#CMDARGS=+"--tinykb --fullkb --rcyc --logtalk --nlu"

unset DISPLAY

nvm use 8.0.0
nvm use --delete-prefix v8.0.0 --silent
node --version

function start_redirect_old {
      local PORT100=$((100+$1))
      lsof -t -i:$PORT100 | xargs --no-run-if-empty kill -9
     local PORT=$((0+$1))
     local HIST=history_$1
     local COMP=completion_$1
     touch $HIST
     touch $COMP
     echo nohup node app.js -p $PORT100 -c rlwrap -a -A -r -c -N -r --file=$COMP --history-filename=$HIST -s 1000 telnet localhost $PORT
     nohup node app.js -p $PORT100 -c rlwrap -a -A -r -c -N -r --file=$COMP --history-filename=$HIST -s 1000 telnet localhost $PORT &
     # nohup node app.js -p $PORT100 -c ./myloginsession $PORT &
}

function start_redirect_ttyd {
   local PORT100=$((100+$1))
   lsof -t -i:$PORT100 | xargs --no-run-if-empty kill -9
     local PORT=$((0+$1))
     local HIST=history_$1
     local COMP=completion_$1
     touch $HIST
     touch $COMP
     local START_REDIR="nohup ttyd -r 100 -p ${PORT100} rlwrap -a -A -r -c -N -r --file=${COMP} --history-filename=${HIST} -s 1000 telnet localhost ${PORT}"
     $START_REDIR &
}      

function start_redirect {
   local PORT=$((0+$1))
   local PORT100=$((100 + $1))
   lsof -t -i:$PORT100 | xargs --no-run-if-empty kill -9
   nohup websocket_redir.sh butterfly $PORT $PORT100 &
}

     

function kill_redirect {
     lsof -t -i:$((100+$1)) | xargs --no-run-if-empty echo USE_NET=1 kill -9
     lsof -t -i:$((100+$1)) | xargs --no-run-if-empty kill -9
}




if [ $# -eq 0 ] 
 then
    # //root
     if [[ $(id -u) == 0 ]]; then
        export RUNFILE="${RL_PREFIX} ${SWIPL} ${KBFILE} ${CMDARGS} --nonet --repl --noworld"
        export USE_NET=0
     else
        export RUNFILE="${RL_PREFIX} ${SWIPL} ${KBFILE} ${CMDARGS}" 
     fi
 else
   # //other
    export RUNFILE="${RL_PREFIX} ${SWIPL} ${*}"
fi

cls_putty() {
 	clear
   reset
   echo -en '\033]50;ClearScrollback\a'
   echo -en "\ec\e[3J"
   printf "\ec" #. This can also be 
   printf "\033c" #or 
   printf "\x1bc"  
   # putting everything together
   echo -en "\e[H\e[J\e[3J"
   printf '\033[3J'
   reset -w
}

[[ -z "$LOGTALKHOME" ]] && export LOGTALKHOME=/usr/share/logtalk


[[ -z "$LOGTALKUSER" ]] && export LOGTALKUSER=$LOGTALKHOME

export COMMAND_LAST=8
export RAN_ALREADY=0
export MY_PID=$$
export MY_PTTY=$(tty)



list_descendants ()
{

  local children=$(ps -o pid= --ppid $1)
  for pid in $children
  do
    list_descendants "$pid"
  done

  echo "$children"
} 

#export WHOLE="gdb -x gdbinit -return-child-result -ex \"set pagination off\" -ex run -ex quit --args ${RUNFILE}"
export WHOLE="gdb -x gdbinit -return-child-result -ex \"set pagination off\" --args ${RUNFILE}"
export WHOLE="${RUNFILE}"

if [[ $UID == 0 ]]; then
  export WHOLE="sudo -u prologmud_server ${WHOLE}"
fi


while [[ RAN_ALREADY -ne 1 ]] && [[ $COMMAND_LAST -ne 666 ]] && [[ $COMMAND_LAST -ne 9 ]] && [[ $COMMAND_LAST -ne 1 ]] && [[ $COMMAND_LAST -ne 137 ]];
do
     echo "You should rarely see this";    
  
      
   if [[ $COMMAND_LAST -ne 4 ]]; then
      echo cls_putty
   fi
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "~~~~~~~~~~~~~KILL PREV~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo kill -9 $(list_descendants $MY_PID)
    kill -9 $(list_descendants $MY_PID)
    #swipl forks xterm making it not die until the xterm it launched is dead
    killall --user $USER -9 xterm #perl
     if [[ "$USE_NET" == "1" ]]; then
       lsof -t -i:$LOGICMOO_BASE_PORT | xargs --no-run-if-empty kill -9
       kill_redirect $(($LOGICMOO_BASE_PORT+0))
       kill_redirect $(($LOGICMOO_BASE_PORT+1))
       kill_redirect $(($LOGICMOO_BASE_PORT+2))
       kill_redirect $(($LOGICMOO_BASE_PORT+3))
       kill_redirect $(($LOGICMOO_BASE_PORT+23))
       kill_redirect $(($LOGICMOO_BASE_PORT+25))
       kill_redirect $(($LOGICMOO_BASE_PORT+301))
     fi

     echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
     echo "~~~~~~~~~~~~~LEFT PREV~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
     echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
         for i in $(fuser $MY_PTTY); do     ps -o pid= -o command= -p $i; done
     echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

     if [[ "$RAN_ALREADY" == "1" ]]; then
      echo "restarting... ";
      echo "Hit CTRL+C ${BASH_SOURCE[0]} 2 secs ";
      sleep 1
      echo "Hit CTRL+C ${BASH_SOURCE[0]} 1 secs ";
      sleep 1
     fi

   # RAN_ALREADY=1


    
wasdir=""

    if [[ "$USE_NET" == "1" ]]; then

         wasdir=$(dirname -- $0)
         cd $LOGICMOO_WS/packs_web/wetty
         start_redirect $(($LOGICMOO_BASE_PORT+0))
         start_redirect $(($LOGICMOO_BASE_PORT+1))
         start_redirect $(($LOGICMOO_BASE_PORT+2))
         start_redirect $(($LOGICMOO_BASE_PORT+3))
         start_redirect $(($LOGICMOO_BASE_PORT+23))
         start_redirect $(($LOGICMOO_BASE_PORT+25))
         start_redirect $(($LOGICMOO_BASE_PORT+301))
         cd $wasdir
     fi
          
     
     echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
     echo "~~~~~~~~~~~~~CURRENT-P~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        for i in $(fuser $MY_PTTY); do     ps -o pid= -o command= -p $i; done
     echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
     echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
     echo DISPLAY=$DISPLAY
     echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH
     echo LOGTALKHOME=$LOGTALKHOME
     echo LOGTALKUSER=$LOGTALKUSER
     echo LOGICMOO_WS=$LOGICMOO_WS
     echo LOGICMOO_BASE_PORT=$LOGICMOO_BASE_PORT
     echo "~~Run~~"
     echo $WHOLE
     echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
     echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
     echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

      
     ( cd $NEWPWD && $WHOLE
      COMMAND_LAST=$?
      echo ""
      echo "~~~~~~~~~~~~~~~~~~~~~~~"
      echo "~~~~ EXIT CODE ${COMMAND_LAST} ~~~~"
      echo "~~~~~~~~~~~~~~~~~~~~~~~"
       if [[ "$USE_NET" == "1" ]]; then
         lsof -t -i:$LOGICMOO_BASE_PORT | xargs --no-run-if-empty kill -9
         kill_redirect $(($LOGICMOO_BASE_PORT+0))
         kill_redirect $(($LOGICMOO_BASE_PORT+1))
         kill_redirect $(($LOGICMOO_BASE_PORT+2))
         kill_redirect $(($LOGICMOO_BASE_PORT+3))
         kill_redirect $(($LOGICMOO_BASE_PORT+23))
         kill_redirect $(($LOGICMOO_BASE_PORT+25))
         kill_redirect $(($LOGICMOO_BASE_PORT+301))
       fi

      reset -c -Q -w -I -w
      sleep 2
      if [[ "$COMMAND_LAST" == "4" ]]; then
         cls
      fi
     )
done

return $COMMAND_LAST 2> /dev/null || exit $COMMAND_LAST




