( cd ../../..
 export d=`date +%Y-%m-%d-%H:%M:%S` ; git submodule foreach 'git commit -am "Autocommit ${d}" && git push || : ' ; git commit -am "Autocommit ${d}" && git push
)
#git --git-dir=./games/.git --work-tree=./games pull
#git pull
#% hg pull
#% hg commit -m "$*"
#git --git-dir=games/.git --work-tree=games commit
#git --git-dir=games/.git --work-tree=games push
#git commit -a -m "$*"
#git push
#% hg push

