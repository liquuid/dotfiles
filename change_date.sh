git filter-branch --env-filter \
    'if [ $GIT_COMMIT = 58f45732ec12798d192e505f754d1344c1a48c83 ]
     then
         export GIT_COMMITTER_DATE="Fri Oct 23 01:01:01 2007 -0700"
     fi'
