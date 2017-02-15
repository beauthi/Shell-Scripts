#! /bin/sh

GREEN="\033[92m"
GRAY="\033[90m"
RED="\033[91m"
ENDC="\033[0m"
BLUE="\033[34m"

if [ $# -ne 1 ]; then
  echo "$BLUE CODING STYLE CHECK $ENDC
        Usage : cs FILE
        Usage : cs FOLDER (recursively)"
  exit 1
fi

read_lines() {
  pos=1
  while IFS= read -r line
  do
    nb=${#line}
    if [ $nb -eq 80 ]; then
      echo -e $1 : $GRAY WARNING $ENDC line $pos is 80 columns long
    fi
    if [ $nb -gt 80 ]; then
      echo -e $1 : $RED ERROR $ENDC line $pos is $nb columns long
    fi
    pos=$(($pos+1))
  done < $1
}

recurse() {
 for i in "$1"/*;do
    if [ -d "$i" ];then
        recurse "$i"
    elif [ -f "$i" ]; then
      ext="${i##*.}"
      if [ "$ext" = "cc" ] || [ "$ext" = "c" ] || [ "$ext" = "hh" ] ||
      [ "$ext" = "h" ] || [ "$ext" = "hxx" ]; then
        read_lines $i
      fi
    fi
 done
}

if [ -d $1 ]; then
  recurse $1
else
  read_lines $1
fi
