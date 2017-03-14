#! /bin/python

class bcolors :
	FAIL = '\033[91m'
	NORMAL = '\033[0m'
	BOLD = '\033[1m'

import sys

if len(sys.argv) != 2:
	sys.exit(2)

file = sys.argv[1]
if (sys.argv[1])[len(sys.argv[1]) - 2] == 'c' :
	max = 50
elif (sys.argv[1])[len(sys.argv[1]) - 1] == 'c' :
	max = 25
with open(file) as f :
	lines = f.readlines()
l_no = 1
li = []
prev_line = ""
for l in lines :
	if '}' in l and len(li) > 0:
		if len(li) > 1 :
			li[len(li) - 2] = li[len(li) - 2] + li[len(li) - 1]
		if li[len(li) - 1] > max :
			sys.stderr.write(file + ": " + bcolors.FAIL + bcolors.BOLD + "ERROR" + bcolors.NORMAL + " : scope beginning at line " + str(l_no - li[len(li) - 1] - 1) + " is " + str(li[len(li) - 1]) + " lines long\n")
		li.pop(len(li) - 1)
	if (len(li) > 0) :
		li[len(li) - 1] = li[len(li) - 1] + 1
	if '{' in l and "class " not in prev_line :
		if len(li) > 1 :
			li[len(li) - 1] = li[len(li) - 1] + 1
		li.append(0)
	l_no = l_no + 1
	prev_line = l
