#!/bin/zsh

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

# Bash staff:
ln -fsT ${PWD}/bash/bash_profile ~/.bash_profile
ln -fsT ${PWD}/bash/profile.d ~/.profile.d
ln -fsT ${PWD}/bash/bashrc ~/.bashrc
ln -fsT ${PWD}/bash/bashrc.d ~/.bashrc.d

# Zsh staff:
ln -fsT ${PWD}/zsh/zprofile ~/.zprofile
ln -fsT ${PWD}/zsh/zshrc ~/.zshrc

# misc shell script
mkdir -p ~/bin
ln -fsT ${PWD}/misc_sh ~/bin
# if you have scripts tracked in other repo, just link them here:
mkdir -p ~/lbin

# Vim staff:
ln -fsT ${PWD}/vim/vimrc ~/.vimrc
ln -fsT ${PWD}/vim ~/.vim

# X related
ln -fsT ${PWD}/xorg/Xmodmap ~/.Xmodmap
ln -fsT ${PWD}/xorg/xprofile ~/.xprofile

# font conf
ln -fsT ${PWD}/fontconf/fonts.conf ~/.fonts.conf

# Python stuff
ln -fsT ${PWD}/python/pythonrc ~/.pythonrc

# global git configuration:
ln -fsT ${PWD}/gitconfig/gitconfig ~/.gitconfig
