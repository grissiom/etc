#!/usr/bin/python

import re
from os import listdir, chdir, path, getcwd, makedirs
from os.path import isdir, isfile, abspath
from os.path import join as join_path
from shutil import move
from sys import argv, exit


#
# all of the path here is ads parh.
#

def movefiles(ftypes, destdir):
	test = re.compile("." + "(" +  "|".join(ftypes) + ")" +  "$", re.IGNORECASE)
	files = filter(test.search, listdir('.'))
	files = filter(isfile, files)
	if len(files) == 0:
		print 'no file to be operate.'
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
	movefiles(ftypes, destdir)
	for i in dirs:
#		try:
		main(ftypes, join_path(wdir, i), join_path(destdir, i))
#		except:
#			print 'oops 2'

try:
	destdir = argv[1]
	cwd = getcwd()
	ftypes = argv[argv.index('-t') + 1:]
	if '-r' in argv:
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
	print 'working in', getcwd()
	print 'ftypes:', ftypes
	print 'destdir:', destdir
	main(ftypes, main_wd, main_destdir)
	exit(0)
except SystemExit:
	pass
#except ValueError:
#	print 'Usage:sep destdir -t/-r file_type'
#	print ''
#	exit(1)
