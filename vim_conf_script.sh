#!/bin/bash

mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/doc

echo "*************install vim-pathogen plugin*****************"
git clone git://github.com/tpope/vim-pathogen.git
if [ -f vim-pathgoen/autoload/pathogen.vim ]; then
	cp vim-pathgoen/autoload/pathogen.vim ~/.vim/autoload/
else
	echo "missing the pathogen.vim file."
	exit;
fi

if [ -f /etc/vim/vimrc ]; then
	echo "call pathogen#infect()" >> /etc/vim/vimrc
elif [ -f ~/.vimrc ]; then 
	echo "call pathogen#infect()" >> ~/.vimrc
fi

echo "*************install NERDTree plugin********************"
git clone git://github.com/scrooloose/nerdtree.git ~/.vim/bundle/
echo "*****open vim and type :NERDTree to make it work********"
