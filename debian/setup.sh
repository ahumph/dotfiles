#!/bin/bash
mv ~/.bashrc ~/old_bashrc
mv ~/.vimrc ~/old_vimrc
cp .bashrc ~/.bashrc
cp .vimrc ~/.vimrc
cp .git-completion.bash ~/.git-completion.bash

mkdir -p ~/.vim/after/syntax
cp c.vim ~/.vim/after/syntax

mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim
cd -
