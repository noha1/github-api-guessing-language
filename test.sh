#! /bin/bash
# @author: Noha hassaan 2018
# you need to install this to make this bash run
# user i used : stedolan
#################################################
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
#brew install jq
echo "Type username, followed by [ENTER]:"

read username
echo q=@$username
arr=( $(curl -G https://api.github.com/search/repositories  --data-urlencode 'q=@'$username  -H 'Accept: application/vnd.github.preview' | jq -r  --compact-output '.items[].language') )

#delete the null elements
delete=(null)
for target in "${delete[@]}"; do
  for i in "${!arr[@]}"; do
    if [[ ${arr[i]} = "${delete[0]}" ]]; then
      unset 'arr[i]'
    fi
  done
done

#file case: sort arr | uniq -c
#group by array and count the unique variables.

if [ ${#arr[@]} ==  0 ]
 then
  echo 'no languages found'
  exit 1
fi

echo  "Here is the list of languages used"
(IFS=$'\n'; sort <<< "${arr[*]}") | uniq -c



ECHO "Best guess for favourite programming lanugage is: ${arr[0]}"
