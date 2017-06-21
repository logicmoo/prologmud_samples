#!/bin/bash

chroot /mnt/chroot/ bash --login -c cds ; killall -9 swipl perl xterm ; cls ; killall -9 swipl ; export HOME=/tmp ; swipl --irc --world --repl -g "['/usr/share/logtalk/integration/logtalk_swi.pl']"  -l remote_swish.pl -t "[run_clio],[library(logicmoo_user)],[run_mud_server],prolog"

#chroot /mnt/chroot/ bash --login -c cds ; killall -9 swipl perl xterm ; cls ; killall -9 swipl ; export HOME=/tmp ; swipl --irc --world --repl -g "['/usr/share/logtalk/integration/logtalk_swi.pl']"  -l remote_swish.pl -t "[run_clio],[run_mud_server],prolog"

#chroot /mnt/chroot/ bash --login -c cds ; killall -9 swipl perl xterm ; cls ; killall -9 swipl ; swipl -l run_clio.pl -l remote_swish.pl -l run_clio.pl -s /dev/null

