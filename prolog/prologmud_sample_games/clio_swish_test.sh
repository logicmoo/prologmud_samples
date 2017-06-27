#!/bin/bash

chroot /mnt/chroot/ bash --login
find: ‘/cp/’: No such file or directory
cd /mnt/dddd/workspace/phase02-jrtl/platform
cd /mnt/dddd/workspace/runtime
/mnt/dddd/workspace/phase02-jrtl/platform
cd /mnt/gggg/PrologMUD/pack/runtime
cd /mnt/gggg/logicmoo_workspace/pack/prologmud_samples/prolog/prologmud_sample_games
cd /mnt/gggg/logicmoo_workspace/pack/logicmoo_base/t/examples/fol
export DISPLAY=:0.0
mesg: ttyname failed: Success
root@ubuntu:/home/prologmud_server/lib/swipl/pack/prologmud_samples/prolog/prologmud_sample_games# export DISPLAY=10.0.0.122:0.0
root@ubuntu:/home/prologmud_server/lib/swipl/pack/prologmud_samples/prolog/prologmud_sample_games# export HOME=/tmp/tempDir
root@ubuntu:/home/prologmud_server/lib/swipl/pack/prologmud_samples/prolog/prologmud_sample_games# killall -9 swipl perl xterm ; cls ; killall -9 swipl ; export HOME=/tmp ; swipl --irc --world --repl -g "user:['/usr/share/logtalk/integration/logtalk_swi.pl']"  -l remote_swish.pl -t "user:[run_clio],user:[library(logicmoo_user)],prolog"


chroot /mnt/chroot/ bash --login -c cds ; killall -9 swipl perl xterm ; cls ; killall -9 swipl ; export HOME=/tmp ; swipl --irc --world --repl -g "['/usr/share/logtalk/integration/logtalk_swi.pl']"  -l remote_swish.pl -t "[run_clio],[library(logicmoo_user)],[run_mud_server],prolog"

#chroot /mnt/chroot/ bash --login -c cds ; killall -9 swipl perl xterm ; cls ; killall -9 swipl ; export HOME=/tmp ; swipl --irc --world --repl -g "['/usr/share/logtalk/integration/logtalk_swi.pl']"  -l remote_swish.pl -t "[run_clio],[run_mud_server],prolog"

#chroot /mnt/chroot/ bash --login -c cds ; killall -9 swipl perl xterm ; cls ; killall -9 swipl ; swipl -l run_clio.pl -l remote_swish.pl -l run_clio.pl -s /dev/null

