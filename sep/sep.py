#!/usr/bin/python

import re
from os import listdir, chdir, path, getcwd, makedirs, rmdir
from os.path import isdir, isfile, abspath
from os.path import join as join_path
from shutil import move
from sys import argv, exit
#import Exception

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

def clrdir(dr):
	rmdir(dr)
	print 'clean', dr

def movefiles(ftypes, destdir):
	test = re.compile("." + "(" + "|".join(ftypes) + ")" + "$", re.IGNORECASE)
	files = filter(test.search, listdir('.'))
	files = filter(isfile, files)
	if len(files) == 0:
		print 'no file to be operate in', getcwd()
		return
	if isdir(destdir) is False:
		makedirs(destdir)
	for i in files:
		try:
			move(i, join_path(destdir, i))
			print 'copying', i, 'to', destdir
		except:
			print 'oops 1'

def main(ftypes, wdir, destdir):
	print 'working in', wdir
	chdir(wdir)
	dirs = filter(isdir, listdir('.'))
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
	# praise destdir
	try:
		destdir = argv[1]
	except:
		raise option_er('destdir missing')
	del argv[1]
	del argv[0]

	argv = list(''.join(argv))
	# praise -k
	if 'k' in argv:
		argv.remove('k')
		KEEP = False
	else:
		KEEP = True
	# praise -r
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

	print 'ftypes:', ftypes
	print 'destdir:', destdir
	main(ftypes, main_wd, main_destdir)
	exit(0)
except SystemExit:
	pass
except option_er, case:
	print 'Usage:sep destdir -k/-r/-t file_type'
	print 'Any thing behand "-t" will treat as the file type you want to move.'
	print 'destdir must goes before any options'
	print '"-r" option will do the reverse work, i.e, extract the files from destdir to cwd.'
	print '"-k" option will keep the empty derctories.'
	print ''
	print case
	exit(1)

