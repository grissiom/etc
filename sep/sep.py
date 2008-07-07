#!/usr/bin/python

import re
from os import listdir, chdir, path, getcwd, makedirs, rmdir
from os.path import isdir, isfile, abspath
from os.path import join as join_path
from shutil import move, copy2
from sys import argv, exit

class option_er(Exception):
	def __init__(self, value):
		self.value = value
	def __str__(self):
		return repr(self.value)

def dummy(*args):
	pass

def check(arg, func):
	if arg:
		return func
	else:
		return dummy

def printf(*args):
	print ' '.join(map(str, args))

def clrdir(dr):
	rmdir(dr)
	check(VERBOSE, printf)('clean', dr)

def movefiles(ftypes, destdir):
	test = re.compile("." + "(" + "|".join(ftypes) + ")" + "$", re.IGNORECASE)
	files = filter(test.search, listdir('.'))
	files = filter(isfile, files)
	if len(files) == 0:
		check(VERBOSE, printf)('no file to be operate in', getcwd())
		return
	if isdir(destdir) is False:
		makedirs(destdir)
	for i in files:
		try:
			operate_file(i, join_path(destdir, i))
			check(VERBOSE, printf)('copying', i, 'to', destdir)
		except:
			print 'oops 1'

def main(ftypes, wdir, destdir):
	check(VERBOSE, printf)('working in', wdir)
	chdir(wdir)
	dirs = filter(isdir, listdir('.'))
	if RECURSION:
		for i in dirs:
			try:
				main(ftypes, join_path(wdir, i), join_path(destdir, i))
			except:
				print 'oops 2'
	chdir(wdir)
	movefiles(ftypes, destdir)
	if len(listdir(wdir)) == 0:
		check(KEEP, clrdir)(wdir)

# the main body
try:
	cwd = getcwd()

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
		KEEP = False
	else:
		KEEP = True
	#parse -c
	if 'c' in argv:
		argv.remove('c')
		operate_file = copy2
	else:
		operate_file = move
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
			print 'you have no', destdir
			exit(3)
	else:
		if destdir in listdir('.'):
			print 'you already have the destdir, abort work.'
			exit(2)
		main_destdir = abspath(destdir)
		main_wd = cwd
	#paise -n
	if 'n' in argv:
		argv.remove('n')
		RECURSION = False
	else:
		RECURSION = True

	check(VERBOSE, printf)('ftypes:', ftypes)
	check(VERBOSE, printf)('destdir:', destdir)
	main(ftypes, main_wd, main_destdir)
	exit(0)
except SystemExit:
	pass
except option_er, case:
	print 'Usage:sep destdir -k/-r/-t file_type'
	print 'Any thing behand "-t" will treat as the file type you want to move.'
	print 'destdir must goes before any options'
	print '-r:do the reverse work, i.e, extract the files from destdir to cwd.'
	print '-n:no recursion'
	print '-c:copy the file instead of moing the file'
	print '-k:keep the empty derctories.'
	print '-v:make the output being verbose'
	print ''
	print case
	exit(1)

