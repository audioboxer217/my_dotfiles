#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
os="$(uname -a | awk '{printf $1}')"
tools_all="vim \
           tmux \
           ansible \
           htop"

tools_brew="bat \
            exa \
            prettyping \
            fzf \
            wtf \
            tfenv"

if [ $os == "Linux" ]; then
  home_loc='/home/scott'
  apt-get install -y $tools_all

  #Manual install of bat
  bat_ver=0.9.0
  wget https://github.com/sharkdp/bat/releases/download/v$bat_ver/bat_$bat_ver\_amd64.deb
  dpkg -i bat_$bat_ver\_amd64.deb
  rm bat_$bat_ver\_amd64.deb

  #Manual install of exa
  exa_ver=0.8.0
  wget https://github.com/ogham/exa/releases/download/v$exa_ver/exa-linux-x86_64-$exa_ver.zip
  unzip -p  exa-linux-x86_64-0.8.0.zip exa-linux-x86_64 > /usr/local/bin/exa
  chmod +x /usr/local/bin/exa
  rm exa-linux-x86_64-$exa_ver.zip
  curl -L https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.bash -o /etc/bash_completion.d/exa

  #Manual install of prettyping
  prettyping_ver=1.0.1
  wget https://github.com/denilsonsa/prettyping/archive/v$prettyping_ver.zip
  unzip -p v1.0.1.zip prettyping-$prettyping_ver/prettyping > /usr/local/bin/prettyping
  chmod +x /usr/local/bin/prettyping
  rm v$prettyping_ver.zip

  #Manual install of fzf
  cd $home_loc
  sudo -u scott git clone --depth 1 https://github.com/junegunn/fzf.git $home_loc/.fzf
  sudo -u scott $home_loc/.fzf/install --all

  #Manual install of wtf
  wtf_ver=0.4.0
  wget https://github.com/wtfutil/wtf/releases/download/$wtf_ver/wtf_$wtf_ver\_linux_386.tar.gz
  tar -xzf wtf_$wtf_ver\_linux_386.tar.gz --strip-components=1 -C /usr/local/bin/ wtf_$wtf_ver\_linux_386/wtf
  rm wtf_$wtf_ver\_linux_386.tar.gz

  #Manual install of tfenv
  sudo -u scott git clone https://github.com/kamatama41/tfenv.git $home_loc/.tfenv
  ln -sf $home_loc/.tfenv/bin/tfenv /usr/local/bin/tfenv
  ln -sf $home_loc/.tfenv/bin/terraform /usr/local/bin/terraform

elif [ $os == "Darwin" ]; then
  home_loc='/Users/scott'
  brew install $tools_all $tools_brew

  #Enable completion and key-bindings for `fzf`
  $(brew --prefix)/opt/fzf/install --all

else
  echo "$os not supported"

fi

git submodule update --init --recursive

mv $home_loc/.bashrc $home_loc/.bashrc_old

ln -sf $dir/ansible.cfg $home_loc/.ansible.cfg
ln -sf $dir/bashrc $home_loc/.bashrc
ln -sf $dir/bash_aliases $home_loc/.bash_aliases
ln -sf $dir/gitconfig $home_loc/.gitconfig
ln -sf $dir/presidio.gitconfig $home_loc/presidio.gitconfig
ln -sf $dir/technologent.gitconfig $home_loc/technologent.gitconfig
ln -snf $dir/ssh $home_loc/.ssh
ln -snf $dir/tmux/tmux $home_loc/.tmux
ln -sf $dir/tmux/tmux.conf $home_loc/.tmux.conf
ln -snf $dir/vim $home_loc/.vim
ln -sf $dir/wtf_config.yml $home_loc/.config/wtf/config.yml
ln -sf $dir/taskrc $home_loc/.taskrc

mkdir -p $home_loc/Projects/{presidio,technologent}

tfenv install 0.11.11 #latest
