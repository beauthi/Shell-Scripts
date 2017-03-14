#! /bin/sh

# idea : check for spaces after a "for", "if", or "while"
# idea : check for spaces at the end of lines

alias lines="python ~/afs/Shell-Scripts/lines_number.py"
alias fw="python ~/afs/Shell-Scripts/cs-for-while.py"
alias spaces="python ~/afs/Shell-Scripts/cs-ending-spaces.py"

GREEN="\033[92m"
GRAY="\033[90m"
RED="\033[91m"
ENDC="\033[0m"
BLUE="\033[34m"
BOLD="\033[1m"
  
echo -e "$BOLD $GREEN CODING STYLE CHECK $ENDC"

if [ $# -ne 1 ]; then
  echo -e "\tUsage : cs FILE
        Usage : cs FOLDER (recursively)"
  exit 1
fi

read_lines() {
  pos=1
  while IFS= read -r line
  do
    nb=${#line}
    if [ $nb -eq 80 ]; then
      echo -e $1 : $BOLD $GRAY WARNING $ENDC line $pos is 80 columns long
    fi
    if [ $nb -gt 80 ]; then
      echo -e $1 : $BOLD $RED ERROR $ENDC line $pos is $nb columns long
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
		    spaces $i
		    fw $i
		    lines $i
      fi
    fi
 done
}

if [ -d $1 ]; then
  recurse $1
else
  read_lines $1
  spaces $1
  fw $1
  lines $1
fi
