#! /bin/python

class bcolors :
	FAIL = '\033[91m'
	NORMAL = '\033[0m'
	BOLD = '\033[1m'

import sys

if len(sys.argv) != 2:
	sys.exit(2)

file = sys.argv[1]
with open(file) as f :
	lines = f.readlines()
l_no = 1
for l in lines :
	if "FIXME: Some code was deleted here." in l :
		sys.stdout.write(file + " : line " + str(l_no) + " needs to be modified\n")
		continue
	l_no = l_no + 1
