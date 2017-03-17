#!/bin/bash

command -v git >/dev/null 2>&1 || { echo >&2 "Require git but it's not installed.  Aborting."; exit 1; }
if ![ $UID != 0 ]; 
then
  echo "This script can only be run or configured by root."
fi

mkdir -p /opt
cd /opt
git clone --recursive  https://github.com/TeamSPoon/logicmoo_workspace 
cd PrologMUD
git pull
git fetch --recurse-submodules
git submodule init
% git submodule update
git submodule sync --recursive


( source ./preconfig.sh )


