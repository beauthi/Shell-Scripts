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
found = 0;
for l in lines :
	if 'for(' in l :
		found = 1
		sys.stderr.write(file + " : " + bcolors.FAIL + bcolors.BOLD + "  ERROR" + bcolors.NORMAL  + "  'for' in line " + str(l_no) + " is not followed by a space : 'for('\n")
	if 'while(' in l :
		found = 1
		sys.stderr.write(file + " : " + bcolors.FAIL + bcolors.BOLD + "  ERROR" + bcolors.NORMAL  + "  'while' in line " + str(l_no) + " is not followed by a space : 'while('\n")
	if 'if(' in l :
		found = 1
		sys.stderr.write(file + " : " + bcolors.FAIL + bcolors.BOLD + "  ERROR" + bcolors.NORMAL  + "  'if' in line " + str(l_no) + " is not followed by a space : 'if('\n")
	l_no = l_no + 1

sys.exit(found)
