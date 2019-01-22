#!/bin/bash

os="$(uname -a | awk '{printf $1}')"
tools=" vim \
        tmux \
        ansible"

if [ $os == "Linux" ]; then
  home_loc='/home/scott'
  apt-get install -y $tools

  #Manual install of tfenv
  sudo -u scott git clone https://github.com/kamatama41/tfenv.git $home_loc/.tfenv
  ln -sf $home_loc/.tfenv/bin/tfenv /usr/local/bin/tfenv
  ln -sf $home_loc/.tfenv/bin/terraform /usr/local/bin/terraform
  
elif [ $os == "Darwin" ]; then
  home_loc='/Users/scott'
  brew install $tools tfenv

else
  echo "$os not supported"

fi

git submodule update --init --recursive

mv $home_loc/.bashrc $home_loc/.bashrc_old

ln -sf $(pwd)/ansible.cfg $home_loc/.ansible.cfg
ln -sf $(pwd)/bashrc $home_loc/.bashrc
ln -sf $(pwd)/bash_aliases $home_loc/.bash_aliases
ln -sf $(pwd)/gitconfig $home_loc/.gitconfig
ln -sf $(pwd)/presidio.gitconfig $home_loc/presidio.gitconfig
ln -sf $(pwd)/technologent.gitconfig $home_loc/technologent.gitconfig
ln -snf $(pwd)/ssh $home_loc/.ssh
ln -snf $(pwd)/tmux/tmux $home_loc/.tmux
ln -sf $(pwd)/tmux/tmux.conf $home_loc/.tmux.conf
ln -snf $(pwd)/vim $home_loc/.vim
ln -sf $(pwd)/wtf-config.yml $home_loc/.config/wtf/config.yml

mkdir -p $home_loc/Projects/{presidio,technologent}

tfenv install 0.11.11 #latest
