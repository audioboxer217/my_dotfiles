#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

git submodule update --init --recursive

mv $HOME/.bashrc $HOME/.bashrc_old

ln -sf $dir/bashrc $HOME/.bashrc
ln -snf $dir/tmux/tmux $HOME/.tmux
ln -sf $dir/tmux/tmux.conf $HOME/.tmux.conf
ln -snf $dir/vim $HOME/.vim

source $HOME/.bashrc
