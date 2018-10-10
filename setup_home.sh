#!/bin/bash

apt-get install -y vim tmux

git submodule update --init --recursive

mv /home/scott/.bashrc /home/scott/.bashrc_old

ln -s /home/scott/dotfiles/ansible.cfg /home/scott/.ansible.cfg
ln -s /home/scott/dotfiles/bashrc /home/scott/.bashrc
ln -s /home/scott/dotfiles/gitconfig /home/scott/.gitconfig
ln -s /home/scott/dotfiles/presidio.gitconfig /home/scott/presidio.gitconfig
ln -s /home/scott/dotfiles/ssh /home/scott/.ssh
ln -s /home/scott/dotfiles/technologent.gitconfig /home/scott/technologent.gitconfig
ln -s /home/scott/dotfiles/tfenv /home/scott/.tfenv
ln -s /home/scott/dotfiles/tmux/tmux /home/scott/.tmux
ln -s /home/scott/dotfiles/tmux/tmux.conf /home/scott/.tmux.comf
ln -s /home/scott/dotfiles/vim /home/scott/.vim

ln -s /home/scott/.tfenv/bin/tfenv /usr/local/bin/tfenv
tfenv install latest

ln -s /home/scott/.tfenv/bin/terraform /usr/local/bin/terraform