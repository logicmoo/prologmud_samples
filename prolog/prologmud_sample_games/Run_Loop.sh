w
#!/bin/bash
#cls ; swipl -T18G -L18G -T18G -s externals/MUD_ScriptEngines/snark/snark_in_prolog.pl
export OLDPWD="`pwd`"
#export NEWPWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#export SWIPL=/usr/local/lib/swipl-7.1.11/bin/x86_64-linux/swipl
#export RUNFILE="run_debug.pl"

#export RL_PREFIX='rlwrap -a -A -r -c -N -r'
export KILLNET=1

for i in "$@" ; do
    if [[ $i == "--nonet" ]] ; then
       export  KILLNET=0
        break
    fi
done

if [ $# -eq 0 ] 
 then
  #  export RUNFILE="${RL_PREFIX} swipl -g consult(init_mud_server) -t prolog"
  if [[ $(id -u) == 0 ]]; then
     export RUNFILE="${RL_PREFIX} swipl -f run_mud_server.pl --nonet --repl --noworld"
     export KILLNET=0
  else
     export RUNFILE="${RL_PREFIX} swipl -f run_mud_server.pl --irc --world"
  fi
#swipl -l init_mud_server.pl"
 else
    export RUNFILE="${RL_PREFIX} swipl -f run_mud_server.pl ${*}"
fi

    export WHOLE="gdb -x gdbinit -return-child-result -ex \"set pagination off\" -ex run -ex quit --args ${RUNFILE}"
	
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
      echo "You should not see this ever";      
      cls_putty      
      cd $OLDPWD
      #swipl forks xterm making it not die until the xterm it launched is dead
      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      #killall -9 xterm perl
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
      $WHOLE
      export COMMAND_LAST=$?
      cd $OLDPWD
      reset -c -Q -w -I -w
      echo ""
      echo "~~~~~~~~~~~~~~~~~~~~~~~"
      echo "~~~~ EXIT CODE ${COMMAND_LAST} ~~~~"
      echo "~~~~~~~~~~~~~~~~~~~~~~~"
      #echo "Hit CTRL+C ${BASH_SOURCE[0]} 4 secs ";
      #sleep 1
      #echo "Hit CTRL+C ${BASH_SOURCE[0]} 3 secs ";
      #sleep 1 
      #echo "Hit CTRL+C ${BASH_SOURCE[0]} 2 secs ";
      #sleep 1
      echo "Hit CTRL+C ${BASH_SOURCE[0]} 1 secs ";
      sleep 1
done

