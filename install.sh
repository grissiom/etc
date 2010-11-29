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

# Your local executable stuff
mkdir -p ~/bin

# Vim staff:
ln -fsT ${PWD}/vimfiles/vimrc ~/.vimrc
ln -fsT ${PWD}/vimfiles ~/.vim

# X related
ln -fsT ${PWD}/xorg/Xmodmap ~/.Xmodmap
ln -fsT ${PWD}/xorg/xprofile ~/.xprofile

# font conf
ln -fsT ${PWD}/fontconf/fonts.conf ~/.fonts.conf

# Python stuff
ln -fsT ${PWD}/python/pythonrc ~/.pythonrc

# global git configuration:
# if merge on .gitconfig failed, git will refuse to work.
# so just provide the copy them if absent.
if [ ! -r ~/.gitconfig -a ! -r ~/.gitignore ]; then
	cp ${PWD}/gitconfig/gitconfig ~/.gitconfig
	cp ${PWD}/gitconfig/gitignore ~/.gitignore
fi

# web
# don't forget to setup your web browsers ;)
ln -fsT ${PWD}/web/proxy.pac ~/proxy.pac

# misc
ln -fsT ${PWD}/misc/toprc ~/.toprc

echo "You may refer to use zsh as the login shell"
chsh
