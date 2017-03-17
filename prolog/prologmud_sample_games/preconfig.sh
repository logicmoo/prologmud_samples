#!/bin/bash
export OLDPWD="`pwd`"
export NEWPWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"   
export APTGET="sudo apt-get -o Acquire::ForceIPv4=true "

$APTGET install python-software-properties

if which swipl >/dev/null; then
   echo swi-prolog exists 
else
   sudo apt-add-repository -y ppa:swi-prolog/stable
   $APTGET update
   $APTGET install swi-prolog
fi

sudo add-apt-repository -y ppa:webupd8team/java
$APTGET update
$APTGET install oracle-java8-installer

echo select java 8
sudo update-alternatives --config java

cd /opt/logicmoo_workspace/
git pull

# 3,625 inferences, 6.003 CPU in 6.014 seconds (100% CPU, 604 Lips)
# 1,828,987,011 inferences, 316.932 CPU in 319.418 seconds (99% CPU, 5770916 Lips)
echo "Compiling a 1gb file this might take about 5 minutes after this it will only take 6 seconds to load"
swipl -g "time(load_files(['pack/pldata_larkc/prolog/el_holds/el_assertions'],[qcompile(auto),if_needed(true)])),halt."
swipl -g "time(load_files(['pack/logicmoo_nlu/prolog/pldata/nldata_talk_db_pdat'],[qcompile(auto),if_needed(true)])),halt."
swipl -g "time(load_files(['pack/logicmoo_nlu/prolog/pldata/nldata_freq_pdat'],[qcompile(auto),if_needed(true)])),halt."
swipl -g "time(load_files(['pack/logicmoo_nlu/prolog/pldata/nldata_BRN_WSJ_LEXICON'],[qcompile(auto),if_needed(true)])),halt."
swipl -g "time(load_files(['pack/logicmoo_nlu/prolog/pldata/nldata_colloc_pdat'],[qcompile(auto),if_needed(true)])),halt."
swipl -g "time(load_files(['pack/logicmoo_nlu/prolog/pldata/nldata_cycl_pos0'],[qcompile(auto),if_needed(true)])),halt."
#swipl -g "time(qcompile('pack/logicmoo_base/prolog/logicmoo/plarkc/logicmoo_i_cyc_kb_tinykb')),halt."
swipl -g "time(load_files(['pack/logicmoo_base/prolog/logicmoo/plarkc/logicmoo_i_cyc_kb_tinykb'],[qcompile(auto),if_needed(true)])),halt."

if [!-f $STANFORD_JAR]; then 
    echo "Downloading $STANFORD_JAR ...";
    wget http://prologmoo.com/downloads/stanford-corenlp3.5.2-ALL.jar -O $STANFORD_JAR
fi

# safe to run more than once
sudo adduser --gecos "PrologMUD User" --disabled-login --disabled-password prologmud

mkdir -p /opt/logicmoo_workspace/pack/prologmud/runtime/cache
chmod 777 /opt/logicmoo_workspace/pack/prologmud/runtime/cache
chmod 777 /opt/logicmoo_workspace/pack/prologmud/runtime

echo "to start the MUD type: ./startMUDServer.sh"


