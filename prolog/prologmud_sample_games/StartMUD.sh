#!/bin/bash

. setup_env.sh

cls
# other options can be --www --irc --nonet --all 
$LOGICMOO_WS/bin/swipl --world --repl --www --irc --swish --elfinder --all  -l run_mud_server.pl $* || echo -n -e '\e[?0c'
tput setaf 2 && echo -en 'Done ' && tput sgr0 && echo ""
