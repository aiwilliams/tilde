#!/bin/bash

ln -sv $PWD/lib/ $HOME/lib
ln -sv $PWD/.vim/ $HOME/.vim
ln -sv $PWD/.vimrc $HOME/.vimrc
ln -sv $PWD/.gvimrc $HOME/.gvimrc
git submodule update --init
