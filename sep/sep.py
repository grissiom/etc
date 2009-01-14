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
		self.strerror = strerror
		SystemExit.__init__(self, message)

def dummy(*args):
	pass

def check(arg, func):
	if arg:
		return func
	else:
		return dummy

def printf(*args):
	print ' '.join(map(str, args))

def movefiles(ftypes, destdir):
	test = re.compile("." + "(" + "|".join(ftypes) + ")" + "$", re.IGNORECASE)
	files = filter(test.search, listdir('.'))
	files = filter(isfile, files)
	if len(files) == 0:
		check(VERBOSE, printf)('no file to be operate in', getcwd())
		return
	if isdir(destdir) is False:
		try:
			makedirs(destdir)
		except OSError, oserr:
			raise SystemExit2(3, 'Error when creating %s: %s' %
					(oserr.filename, oserr.strerror))
	for i in files:
		try:
			print(OPER_FILE_MOD +' '+ i + ' to ' + destdir)
			operate_file(i, join_path(destdir, i))
			print(" ... Done\n")
		except IOError, ioerr:
			remove(join_path(destdir, i))
			raise SystemExit2(3, 'Error when %s %s: %s\nRemoved file:%s' %
					(OPER_FILE_MOD, i, ioerr.strerror, i))
		except KeyboardInterrupt, keyinter:
			print("Remove " + join_path(destdir, i))
			raise SystemExit2(1, 'User aborted.')

def main(ftypes, wdir, destdir):
	check(VERBOSE, printf)('working in', wdir)
	chdir(wdir)
	dirs = filter(isdir, listdir('.'))
	if RECURSION:
		for i in dirs:
			main(ftypes, join_path(wdir, i), join_path(destdir, i))
	chdir(wdir)
	movefiles(ftypes, destdir)
	if KEEP == True and len(listdir(wdir)) == 0:
		rmdir(wdir)
		check(VERBOSE, printf)('clean', wdir)

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
		operate_file = copy
	#parse -v
	if 'v' in argv:
		argv.remove('v')
		VERBOSE = True
	else:
		VERBOSE = False
	# parse -r
	if 'r' in argv:
		argv.remove('r')
		if isdir(destdir):
			main_wd, main_destdir = abspath(destdir), cwd
		else:
			raise(option_er('you have no %s' % destdir))
	else:
		if destdir in listdir('.'):
			print("you have already have %s" % destdir)
		main_destdir = abspath(destdir)
		main_wd = cwd
	#paise -n
	if 'n' in argv:
		argv.remove('n')
		RECURSION = False
	else:
		RECURSION = True
#----------- End the option parsing -----------#

	check(VERBOSE, printf)('ftypes:', ftypes)
	check(VERBOSE, printf)('destdir:', destdir)
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
-r:do the reverse work, i.e, extract the files from destdir to cwd.
-n:no recursion
-m:copy the file instead of copying the file
-k:keep the empty derctories.
-v:make the output being verbose
''')
	print(case)
	exit(2)

