#!/bin/zsh

set -e
echo "Continuing with this installation will overwrite your exist local settings."
echo -n "Continue anyway?(y/N)"
read ans
if [[ ${ans} = 'n' || ${ans} = 'N' || ${ans} = '' ]]; then
	echo "User abort."
	exit 0
elif [[ ${ans} != 'y' && ${ans} != 'Y' ]]; then
	echo "Invalid answer"
	exit 1
fi

# common shell stuff
ln -fsT ${PWD}/shells/profile ~/.profile

# Bash staff:
ln -fsT ${PWD}/shells/bash/bash_profile ~/.bash_profile
ln -fsT ${PWD}/shells/bash/profile.d ~/.profile.d
ln -fsT ${PWD}/shells/bash/bashrc ~/.bashrc
ln -fsT ${PWD}/shells/bash/bashrc.d ~/.bashrc.d

# Zsh staff:
ln -fsT ${PWD}/shells/zsh/zprofile ~/.zprofile
ln -fsT ${PWD}/shells/zsh/zshrc ~/.zshrc

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

# web
# don't forget to setup your web browsers ;)
ln -fsT ${PWD}/web/proxy.pac ~/proxy.pac

echo "You may refer to use zsh as the login shell"
chsh
