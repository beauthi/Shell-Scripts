#! /bin/sh

one=0
two=0
three=0
zero=0

mkdir zero
mkdir one
mkdir two
mkdir three

for file in $(ls *.tig); do
  ../../tc $file
  a=$?
  if [ $a -eq 0 ]; then
    zero=$(($zero+1))
    mv $file "no_error_$zero.tig"
    mv "no_error_$zero.tig" zero
  fi
  if [ $a -eq 1 ]; then
    one=$(($one+1))
    mv $file "misc_error_$one.tig"
    mv "misc_error_$one.tig" one
  fi
  if [ $a -eq 2 ]; then
    two=$(($two+1))
    mv $file "scan_error_$two.tig"
    mv "scan_error_$two.tig" two
  fi
  if [ $a -eq 3 ]; then
    three=$(($three+1))
    mv $file "parse_error_$three.tig"
    mv "parse_error_$three.tig" three
  fi
done
