#!/bin/bash

brew install vim tmux ansible tfenv

git submodule update --init --recursive

mv /Users/scott/.bashrc /Users/scott/.bashrc_old

ln -s /Users/scott/dotfiles/ansible.cfg /Users/scott/.ansible.cfg
ln -s /Users/scott/dotfiles/bashrc /Users/scott/.bashrc
ln -s /Users/scott/dotfiles/bash_aliases /Users/scott/.bash_aliases
ln -s /Users/scott/dotfiles/gitconfig /Users/scott/.gitconfig
ln -s /Users/scott/dotfiles/presidio.gitconfig /Users/scott/presidio.gitconfig
ln -s /Users/scott/dotfiles/ssh /Users/scott/.ssh
ln -s /Users/scott/dotfiles/technologent.gitconfig /Users/scott/technologent.gitconfig
ln -s /Users/scott/dotfiles/tmux/tmux /Users/scott/.tmux
ln -s /Users/scott/dotfiles/tmux/tmux.conf /Users/scott/.tmux.conf
ln -s /Users/scott/dotfiles/vim /Users/scott/.vim

tfenv install latest
