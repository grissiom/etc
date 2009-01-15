#!/usr/bin/python

import re
from os import listdir, chdir, path, getcwd, makedirs, rmdir, remove
from os.path import isdir, isfile, abspath
from os.path import join as join_path
from shutil import move, copy2
from sys import argv, exit

class option_er(Exception):
	def __init__(self, value):
		self.value = value
	def __str__(self):
		return repr(self.value)

class SystemExit2(SystemExit):
	def __init__(self, message = 0, strerror = None):
		self.strerror = get_color('red') + strerror + get_color('default')
		SystemExit.__init__(self, message)

def dummy(*args):
	pass

# I hope this piece of code could be sweept out permanently after switched to Python3
def printf(*args):
	print ' '.join(map(str, args))

def get_color(cl):
	return colours.get(cl, '')

def movefiles(ftypes, destdir):
	test = re.compile("." + "(" + "|".join(ftypes) + ")" + "$", re.IGNORECASE)
	files = filter(test.search, listdir('.'))
	files = filter(isfile, files)
	if len(files) == 0:
		print_v('no file to be operate in ' + getcwd())
		return
	if isdir(destdir) is False:
		try:
			makedirs(destdir)
		except OSError, oserr:
			raise SystemExit2(3, 'Error when creating %s: %s' %
					(oserr.filename, oserr.strerror))
	for i in files:
		try:
			print(get_color('yellow') + OPER_FILE_MOD +' '+ i + ' to ' +
                              destdir)
			operate_file(i, join_path(destdir, i))
			print(get_color('green') + " ... Done\n" +
                              get_color('default'))
		except IOError, ioerr:
			remove(join_path(destdir, i))
			raise SystemExit2(3, 'Error when %s %s: %s\nRemoved file:%s' %
					(OPER_FILE_MOD, i, ioerr.strerror, i))
		except KeyboardInterrupt, keyinter:
			remove(join_path(destdir, i))
			print("Remove " + join_path(destdir, i))
			raise SystemExit2(1, 'User aborted.')

def main(ftypes, wdir, destdir):
	try:
		print_v('working in ' + wdir)
		chdir(wdir)
		if RECURSION:
			dirs = filter(isdir, listdir('.'))
			for i in dirs:
				main(ftypes, join_path(wdir, i), join_path(destdir, i))
		chdir(wdir)
		movefiles(ftypes, destdir)
		if KEEP and len(listdir(wdir)) == 0:
			rmdir(wdir)
			print_v('clean ' + wdir)
	except KeyboardInterrupt:
		raise SystemExit2(1, 'User aborted.')

# the main body
try:
	cwd = getcwd()
#----------- Begin the option parsing -----------#
	#parse -t
	try:
		ftypes = argv[argv.index('-t') + 1:]
	except:
		raise option_er('-t option missing')
	del argv[argv.index('-t'):]
	# parse destdir
	try:
		destdir = argv[1]
	except:
		raise option_er('destdir missing')
	del argv[1]
	del argv[0]
	if destdir in listdir('.'):
		print("you have already have %s. Anything have the same file name will be overwrite." % destdir)
	main_destdir = abspath(destdir)
	main_wd = cwd

	argv = list(''.join(argv))
	# parse -k
	if 'k' in argv:
		argv.remove('k')
		KEEP = True
	else:
		KEEP = False
	#parse -m
	if 'm' in argv:
		argv.remove('m')
		OPER_FILE_MOD = 'move'
		operate_file = move
	else:
		OPER_FILE_MOD = 'copy'
		operate_file = copy2
	#parse -v
	if 'v' in argv:
		argv.remove('v')
		print_v=printf
	else:
		print_v=dummy
	#paise -n
	if 'n' in argv:
		argv.remove('n')
		RECURSION = False
	else:
		RECURSION = True
	#paise -c
	if 'c' in argv:
		argv.remove('c')
		colours = {
            'none'       :    "",
            'default'    :    "\033[0m",
            'bold'       :    "\033[1m",
            'underline'  :    "\033[4m",
            'blink'      :    "\033[5m",
            'reverse'    :    "\033[7m",
            'concealed'  :    "\033[8m",

            'black'      :    "\033[30m",
            'red'        :    "\033[31m",
            'green'      :    "\033[32m",
            'yellow'     :    "\033[33m",
            'blue'       :    "\033[34m",
            'magenta'    :    "\033[35m",
            'cyan'       :    "\033[36m",
            'white'      :    "\033[37m",

            'on_black'   :    "\033[40m",
            'on_red'     :    "\033[41m",
            'on_green'   :    "\033[42m",
            'on_yellow'  :    "\033[43m",
            'on_blue'    :    "\033[44m",
            'on_magenta' :    "\033[45m",
            'on_cyan'    :    "\033[46m",
            'on_white'   :    "\033[47m",

            'beep'       :    "\007"
            }
	else:
		colours = {}
#----------- End the option parsing -----------#

	print_v('ftypes: ' + ftypes)
	print_v('destdir: ' + destdir)
	main(ftypes, main_wd, main_destdir)
	exit(0)
except SystemExit2, sysexit2:
	print(sysexit2.strerror)
except option_er, case:
	print(
'''Usage:sep <destdir> [Options] <-t file_type>

Any thing behand "-t" will treat as the file type you want to move. destdir
must goes before any options

Options:
-n:no recursion
-m:copy the file instead of copying the file
-k:keep the empty derctories.
-c:colorize output
-v:make the output being verbose
''')
	print(case)
	exit(2)

