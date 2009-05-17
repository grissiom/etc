#!/bin/bash

set -e
echo "Doing this install will overwrite your exist local settings."
echo -n "Continue anyway?(y/N)"
read ans
if [[ ${ans} = 'n' || ${ans} = 'N' || ${ans} = '' ]]; then
	echo "User abort."
	exit 0
elif [[ ${ans} != 'y' && ${ans} != 'Y' ]]; then
	echo "Invalid answer"
	exit 1
fi

PWD=`pwd`

# Bash staff:
ln -fsT ${PWD}/bash_config/bash_profile ~/.bash_profile
ln -fsT ${PWD}/bash_config/profile.d ~/.profile.d
ln -fsT ${PWD}/bash_config/bashrc ~/.bashrc
ln -fsT ${PWD}/bash_config/bashrc.d ~/.bashrc.d
## Konsole seems not be a login shell. So link devtodo to bashrc.d to make use
## of it. Git only track profile.d/devtodo.sh.
#ln -fsT ${PWD}/bash_config/profile.d/devtodo.sh ${PWD}/bash_config/bashrc.d/devtodo.sh

# Vim staff:
ln -fsT ${PWD}/vim/vimrc ~/.vimrc
ln -fsT ${PWD}/vim ~/.vim

# X related
ln -fsT ${PWD}/xorg/Xmodmap ~/.Xmodmap
ln -fsT ${PWD}/xorg/xprofile ~/.xprofile

# Python stuff
ln -fsT ${PWD}/python/pythonrc ~/.pythonrc

# Other misc things:
ln -fsT ${PWD}/misc_sh/installkernel ~/bin/installkernel 
ln -fsT ${PWD}/misc_sh/pkgls ~/bin/pkgls
ln -fsT ${PWD}/misc_sh/pkgrep ~/bin/pkgrep
ln -fsT ${PWD}/gitconfig/gitconfig ~/.gitconfig
