export d=`date +%Y-%m-%d-%H:%M:%S` 


if [ $# -eq 0 ] 
 then
   export message="Autocommit ${d}"
 else
   export message="${*} ${d}"
fi



( cd ../../..
  git submodule foreach 'git commit -am "${message}" || git push || : ' ; git commit -am "${message}" && git push
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

