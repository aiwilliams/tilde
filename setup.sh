#!/bin/bash

ln -Ffsv $PWD/lib $HOME/lib
ln -Ffsv $PWD/.vim $HOME/.vim
ln -Ffsv $PWD/.vimrc $HOME/.vimrc
ln -Ffsv $PWD/.gvimrc $HOME/.gvimrc
git submodule update --init
