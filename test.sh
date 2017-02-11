#! /bin/sh

nb=0

for file in $(ls *.tig); do
  nb=$(($nb+1))
  mv $file "parse_error_$nb.tig"
done
