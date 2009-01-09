#!/bin/bash

set -e
echo "Doing this install will overwrite your exist local settings."
echo -n "Continue anyway?(y/N)"
read ans
if [[ ${ans} = 'n' || ${ans} = '' ]]; then
	echo "User abort."
	exit 0
elif [[ ${ans} != 'y' ]]; then
	echo "Invalid answer"
	exit 1
fi

PWD=`pwd`

# Bash staff:
ln -fsT ${PWD}/bash_config/bash_profile ~/.bash_profile
ln -fsT ${PWD}/bash_config/bashrc ~/.bashrc

# Vim staff:
ln -fsT ${PWD}/vim/vimrc ~/.vimrc
if [ ! -d ~/.vim ]; then
	mkdir ~/.vim
fi
ln -fsT ${PWD}/vim/ftplugin ~/.vim/ftplugin
ln -fsT ${PWD}/vim/plugin ~/.vim/plugin
ln -fsT ${PWD}/vim/syntax ~/.vim/syntax

# Other misc things:
ln -fsT ${PWD}/misc_sh/installkernel ~/bin/installkernel 

