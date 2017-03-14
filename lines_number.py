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
	ptr = "* "
	max = 50
elif (sys.argv[1])[len(sys.argv[1]) - 1] == 'c' :
	ptr = " *"
	max = 25
with open(file) as f :
	lines = f.readlines()
l_no = 1
li = []
scopes = []
prev_line = ""
for l in lines :
	if '}' in l and len(li) > 0:
		if len(li) > 1 :
			li[len(li) - 2] = li[len(li) - 2] + li[len(li) - 1] - 1
		if li[len(li) - 1] + 1 > max and "class " not in scopes[len(scopes) - 1] and \
			("void " in scopes[len(scopes) - 1] or "int " in scopes[len(scopes) - 1] or "char" + ptr in scopes[len(scopes) - 1] \
			 or "char " in scopes[len(scopes) - 1] or "void" + ptr in scopes[len(scopes) - 1] or "int* " in scopes[len(scopes) - 1] \
			 or "long " in scopes[len(scopes) - 1] or "long" + ptr in scopes[len(scopes) - 1] or "double " in scopes[len(scopes) - 1] \
			 or "double" + ptr in scopes[len(scopes) - 1] or "bool " in scopes[len(scopes) - 1] or "bool" + ptr in scopes[len(scopes) - 1]) \
			 and "for (" not in scopes[len(scopes) - 1] and "if (" not in scopes[len(scopes) - 1] \
			 and "while (" not in scopes[len(scopes) - 1] :
			sys.stderr.write(file + ": " + bcolors.FAIL + bcolors.BOLD + "ERROR" + bcolors.NORMAL + " : function " + bcolors.BOLD + scopes[len(scopes) - 1][:-1] + bcolors.NORMAL + " beginning at line " + str(l_no - li[len(li) - 1] - 3) + " is " + str(li[len(li) - 1] + 1) + " lines long\n")
		li.pop(len(li) - 1)
		scopes.pop(len(scopes) - 1)
	if (len(li) > 0) :
		li[len(li) - 1] = li[len(li) - 1] + 1
	if '{' in l :
		if len(li) > 1 :
			li[len(li) - 1] = li[len(li) - 1] + 1
		li.append(0)
		scopes.append(prev_line)
	l_no = l_no + 1
	prev_line = l
