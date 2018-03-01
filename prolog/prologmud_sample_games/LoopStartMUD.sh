#!/bin/bash

. setup_env.sh

# other options can be --www --irc --nonet --all 

result=1
while [[ $result -ne 666 ]] && [[ $result -ne 9 ]] && [[ $result -ne 137 ]]; do
  echo press ctrl-c to stop
  sleep 3
  cls                         # app_argv
  $LOGICMOO_WS/bin/swipl --world --repl --www --nokb --cyc --sigma --irc --swish --elfinder --all -l run_mud_server.pl
  result=$?
  tput setaf 2 && echo -en "Done ${result} " && tput sgr0 && echo ""
done


