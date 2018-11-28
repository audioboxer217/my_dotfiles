#!/bin/bash

brew install vim tmux ansible

git submodule update --init --recursive

mv /Users/scott/.bashrc /Users/scott/.bashrc_old

ln -s /Users/scott/dotfiles/ansible.cfg /Users/scott/.ansible.cfg
ln -s /Users/scott/dotfiles/bashrc /Users/scott/.bashrc
ln -s /Users/scott/dotfiles/gitconfig /Users/scott/.gitconfig
ln -s /Users/scott/dotfiles/presidio.gitconfig /Users/scott/presidio.gitconfig
ln -s /Users/scott/dotfiles/ssh /Users/scott/.ssh
ln -s /Users/scott/dotfiles/technologent.gitconfig /Users/scott/technologent.gitconfig
ln -s /Users/scott/dotfiles/tfenv /Users/scott/.tfenv
ln -s /Users/scott/dotfiles/tmux/tmux /Users/scott/.tmux
ln -s /Users/scott/dotfiles/tmux/tmux.conf /Users/scott/.tmux.conf
ln -s /Users/scott/dotfiles/vim /Users/scott/.vim

ln -s /Users/scott/.tfenv/bin/tfenv /usr/local/bin/tfenv
tfenv install latest

ln -s /Users/scott/.tfenv/bin/terraform /usr/local/bin/terraform
