#! /bin/sh

GREEN="\033[92m"
GRAY="\033[90m"
RED="\033[91m"
ENDC="\033[0m"
BLUE="\033[34m"
BOLD="\033[1m"

if [ $# -ne 0 ]; then
  echo -e "$BOLD $GREEN TODO generator $ENDC
        Usage : todo-gen"
  exit 1
fi

recurse() {
 for i in "$1"/*;do
    if [ -d "$i" ];then
        recurse "$i"
    elif [ -f "$i" ]; then
      ext="${i##*.}"
      if [ "$ext" = "cc" ] || [ "$ext" = "c" ] || [ "$ext" = "hh" ] ||
      [ "$ext" = "h" ] || [ "$ext" = "hxx" ]; then
		python todo-generator.py $i
      fi
    fi
 done
}

echo "TODO automatically generated" > TODO_generated
echo "" >> TODO_generated
echo "FIXMEs" >> TODO_generated
echo "" >> TODO_generated
recurse "." >> TODO_generated
