export d=`date +%Y-%m-%d-%H:%M:%S` 


if [ $# -eq 0 ] 
 then
( cd ../../..
  git submodule foreach 'git status' ; git status
)
 else
   export message="${*} ${d}"
( cd ../../..
  git submodule foreach 'git commit -am "${message}" || git push || : ' ; git commit -am "${message}" || git push
)
fi



#git --git-dir=./games/.git --work-tree=./games pull
#git pull
#% hg pull
#% hg commit -m "$*"
#git --git-dir=games/.git --work-tree=games commit
#git --git-dir=games/.git --work-tree=games push
#git commit -a -m "$*"
#git push
#% hg push

