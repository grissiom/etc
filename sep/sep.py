#!/bin/env python

import re
import os
from os import listdir, makedirs, rmdir, remove
from os.path import isdir, isfile, islink
joinp, splitp = os.path.join, os.path.split
from shutil import move, copy2
import sys

def exit_err(no, msg, stream=sys.stderr):
        sys.stdout.flush()
        stream.write('\n' + get_color('red') +
                         msg + get_color('default') + '\n')
        sys.exit(no)

def printf(arg, lv=0, stream=sys.stdout):
        if lv <= PRINT_LV:
                stream.write(arg)

def get_color(cl):
        return colours.get(cl, '')

# adapted from /usr/lib64/python2.6/os.py
def walk_dir(top, topdown=True, followlinks=False, ml=0, rl=0):
        '''walk like os.walk

        ml is the max recursion level. Recursion check is disabled if ml == 0.
        rl is the current recursion level. You don't need to set this variable
            at normal cases.'''
        if ml != 0 and rl >= ml:
                return
        try:
                names = listdir(top)
        except:
                pass

        dirs, nondirs = [], []
        for name in names:
                if isdir(joinp(top, name)):
                        dirs.append(name)
                else:
                        nondirs.append(name)

        if topdown:
                yield top, dirs, nondirs
        for name in dirs:
                path = joinp(top, name)
                if followlinks or not islink(path):
                        for x in walk_dir(path, topdown, followlinks, rl + 1):
                                yield x
        if not topdown:
                yield top, dirs, nondirs

def movefiles(file_name, destdir):
        if isdir(destdir) is False:
                try:
                        makedirs(destdir)
                except OSError, oserr:
                        exit_err(3, 'Error when creating %s: %s' %
                                        (oserr.filename, oserr.strerror))
        try:
                printf(get_color('yellow') + OPER_FILE_MOD
                      + ' ' + file_name + ' to '
                      + destdir + os.sep + ' ... ')
                # work around: shutil.move will fail if the dest file exits...
                if OPERATE_FILE == move:
                        if isfile(joinp(destdir, splitp(file_name)[1])):
                                remove(joinp(destdir, splitp(file_name)[1]))
                OPERATE_FILE(file_name, destdir)
                printf(get_color('green') + "Done\n" + get_color('default'))
        except IOError, ioerr:
                if isfile(joinp(destdir, splitp(file_name)[1])):
                        remove(joinp(destdir, splitp(file_name)[1]))
                exit_err(3, 'Error when %s %s: %s' %
                                (OPER_FILE_MOD, file_name, ioerr.strerror))
        except KeyboardInterrupt:
                if isfile(joinp(destdir, splitp(file_name)[1])):
                        remove(joinp(destdir, splitp(file_name)[1]))
                printf("Remove " + joinp(destdir, file_name) + '\n')
                exit_err(1, 'User aborted.')

def main(destdir):
        try:
                for root_dir, dirs, files in walk_dir('.', topdown=False, ml=RECURSION_LEVEL):
                        files = [ i for i in files if FILE_FILTER.search(i)]
                        if len(files) == 0:
                                printf('no file to be operate in ' + root_dir + '\n', 1)
                        for i in files:
                                movefiles(
                                   os.path.normpath(joinp(root_dir, i)),
                                   os.path.normpath(joinp(destdir, root_dir)))
                        if (not KEEP) and len(listdir(root_dir)) == 0 \
                           and root_dir != '.':
                                rmdir(root_dir)
                                printf('clean ' + root_dir + '\n')
        except KeyboardInterrupt:
                exit_err(1, 'User aborted.')

# the main body
#----------- Begin the option parsing -----------#
argv = sys.argv[1:]
opt_hlp, opt_err, tmp = [], [], []
for i in argv:
        if i[0] == '-':
                tmp.extend([k for k in i if k != '-'])
        else:
                tmp.append(i)
argv = tmp

try:
        ftypes = argv[-1]
        FILE_FILTER = re.compile(ftypes, re.IGNORECASE)
        del argv[-1]
except:
        opt_err.append('<pattern> missing')

opt_hlp.append('-n:recursion level(default is 100)\n')
try:
        RECURSION_LEVEL = int(argv[argv.index('-n') + 1])
        del argv[argv.index('-n') + 1]
        del argv[argv.index('-n')]
except:
        RECURSION_LEVEL = 100

opt_hlp.append('-k:keep the empty directories.\n')
KEEP = False
if 'k' in argv:
        argv.remove('k')
        KEEP = True

opt_hlp.append('-m:move the file instead of copying the file\n')
OPER_FILE_MOD = 'copy'
OPERATE_FILE = copy2
if 'm' in argv:
        argv.remove('m')
        OPER_FILE_MOD = 'move'
        OPERATE_FILE = move

opt_hlp.append('-v:make the output being verbose\n')
PRINT_LV = 0
if 'v' in argv:
        argv.remove('v')
        PRINT_LV = 1

opt_hlp.append('-c:colorize output\n')
colours = {}
if 'c' in argv:
        argv.remove('c')
        colours = {'default':"\033[0m",
                   'red'    :"\033[31m",
                   'green'  :"\033[32m",
                   'yellow' :"\033[33m",
                   'blue'   :"\033[34m",
                   }

try:
        destdir = argv[0]
        del argv[0]
except:
        opt_err.append('destdir missing')

if opt_err != []:
        printf('Usage:sep.py <destdir> [Options] <pattern>\n\
\n\
Find files according to pattern and copy/move them to destdir. destdir must\n\
goes before any options. pattern is python\'s regular expression. Only the\n\
last pattern would take effect.\n\
\n\
Options:\n' + '\t' + '\t'.join(opt_hlp)
+ get_color('red') + ', '.join(opt_err) + get_color('default') + '\n')
        sys.exit(2)
#----------- End the option parsing -----------#

printf('ftypes: ' + ftypes + '\n', 1)
printf('destdir: ' + destdir + '\n', 1)

main(destdir)
