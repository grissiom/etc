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
ln -fsT ${PWD}/bash_config/bashrc.d ~/.bashrc.d

# Vim staff:
ln -fsT ${PWD}/vim/vimrc ~/.vimrc
ln -fsT ${PWD}/vim ~/.vim

# Other misc things:
ln -fsT ${PWD}/misc_sh/installkernel ~/bin/installkernel 
ln -fsT ${PWD}/gitconfig/gitconfig ~/.gitconfig
