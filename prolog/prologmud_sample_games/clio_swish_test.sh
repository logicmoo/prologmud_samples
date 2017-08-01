#!/bin/bash

echo hope you did chroot /mnt/chroot/ bash --login
#cd /mnt/gggg/logicmoo_workspace/pack/prologmud_samples/prolog/prologmud_sample_games
#cd /mnt/gggg/logicmoo_workspace/pack/logicmoo_base/t/examples/fol
#export DISPLAY=:0.0

export DISPLAY=10.0.0.122:0.0
export HOME=/tmp/tempDir
export LOGTALKHOME=/home/prologmud_server/lib/swipl/pack/logtalk/logtalk-3.10.9
rsync -avh tempDir/ $HOME/
killall -9 swipl xterm # darn xpce xterms!
killall -9 perl # we forked the flash server and it holds SWIPL alive
killall -9 swipl # its ok since this is the prologmud_server user and not root
#swipl --irc --world --repl 
echo -t "[library(logtalk)],user:[remote_swish],user:[run_clio],user:[library(logicmoo_user)],user:[run_mud_server],prolog" # -f /dev/null
#swipl --irc --world --repl
swipl --irc --world --repl -g "logtalk:[library(logtalk)]" -l remote_swish.pl -t "[run_clio],user:[library(logicmoo_user)],user:[run_mud_server],prolog"



