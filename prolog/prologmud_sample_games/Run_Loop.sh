#!/bin/bash
#cls ; swipl -T18G -L18G -T18G -s externals/MUD_ScriptEngines/snark/snark_in_prolog.pl
export OLDPWD="`pwd`"
export NEWPWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#export SWIPL=/usr/local/lib/swipl-7.1.11/bin/x86_64-linux/swipl
#export RUNFILE="run_debug.pl"

#export RL_PREFIX='rlwrap -a -A -r -c -N -r'
export KILLNET=1
export USEKB=1
export KBFILE=""

kill -9 %1 %2 %3
kill -9 %1 %2 %3
kill -9 %1 %2 %3
kill -9 %1 %2 %3

for i in "$@" ; do
   if [[ $i == "--nonet" ]] ; then export  KILLNET=0; fi
   if [[ $i == "-x" ]] ; then export USEKB=0; fi     
   if [[ $i == "--nocyc" ]] ; then export USEKB=0; fi
   if [[ $i == "--cyc" ]] ; then export USEKB=1; fi
done

if [ $USEKB == 1 ]; then

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

export SWIPL='swipl -l run_mud_server.pl'


if [ $# -eq 0 ] 
 then
    # //root
     if [[ $(id -u) == 0 ]]; then
        export RUNFILE="${RL_PREFIX} ${SWIPL} ${KBFILE} --nonet --repl --noworld"
        export KILLNET=0
     else
        export RUNFILE="${RL_PREFIX} ${SWIPL} ${KBFILE} --irc --world"
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


while [ 1 ]
do
      export WHOLE="gdb -x gdbinit -return-child-result -ex \"set pagination off\" -ex run -ex quit --args ${RUNFILE}"

      echo "You should not see this ever";

      cls_putty

      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      
      #swipl forks xterm making it not die until the xterm it launched is dead
      killall --user $USER -9 rlwrap gdb

      if [[ "$KILLNET" == "1" ]]; then
          lsof -t -i:3020 -i:4000 -i:4010 | xargs --no-run-if-empty kill -9
      fi

      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      echo DISPLAY=$DISPLAY
      echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH
      echo LOGTALKHOME=$LOGTALKHOME
      echo LOGTALKUSER=$LOGTALKUSER
      echo $WHOLE
      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

      ( cd $NEWPWD && $WHOLE || export COMMAND_LAST=$? ; reset -c -Q -w -I -w )

      echo ""
      echo "~~~~~~~~~~~~~~~~~~~~~~~"
      echo "~~~~ EXIT CODE ${COMMAND_LAST} ~~~~"
      echo "~~~~~~~~~~~~~~~~~~~~~~~"
      echo "Hit CTRL+C ${BASH_SOURCE[0]} 2 secs ";
      sleep 1
      echo "Hit CTRL+C ${BASH_SOURCE[0]} 1 secs ";
      sleep 1
      echo "restarting... ";
done

