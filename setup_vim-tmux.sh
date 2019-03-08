#!/bin/bash

apt-get install -y vim tmux
git submodule update --init --recursive

ln -snf $(pwd)/tmux/tmux $HOME/.tmux
ln -sf $(pwd)/tmux/tmux.conf $HOME/.tmux.conf
ln -snf $(pwd)/vim $HOME/.vim

echo 'source <(kubectl completion bash)' >> $HOME/.bashrc
source $HOME/.bashrc
