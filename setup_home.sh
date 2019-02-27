#!/bin/bash

username="$(whoami)"
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
os="$(uname -a | awk '{printf $1}')"
wtf_ver=0.5.0
tools_all="vim \
           tmux \
           ansible \
           htop"

tools_brew="bat \
            exa \
            prettyping \
            fzf \
            kube-ps1 \
            tfenv"

if [ $os == "Linux" ]; then
  apt-get install -y $tools_all

  #Manual install of bat
  bat_ver=0.10.0
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
  cd $HOME
  sudo -u $username git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  sudo -u $username $HOME/.fzf/install --all

  #Manual install of kube-ps1
  kube_ps1_ver=0.7.0
  wget https://github.com/jonmosco/kube-ps1/archive/v$kube_ps1_ver.tar.gz
  mkdir -p /usr/local/opt/kube-ps1/share
  tar -xzf v$kube_ps1_ver.tar.gz --strip-components=1 -C /usr/local/opt/kube-ps1/share/ kube-ps1-$kube_ps1_ver/kube-ps1.sh
  rm v$kube_ps1_ver.tar.gz

  #Manual install of wtf
  wget https://github.com/wtfutil/wtf/releases/download/$wtf_ver/wtf_$wtf_ver\_linux_386.tar.gz
  tar -xzf wtf_$wtf_ver\_linux_386.tar.gz --strip-components=1 -C /usr/local/bin/ wtf_$wtf_ver\_linux_386/wtf
  rm wtf_$wtf_ver\_linux_386.tar.gz

  #Manual install of tfenv
  sudo -u $username git clone https://github.com/kamatama41/tfenv.git $HOME/.tfenv
  ln -sf $HOME/.tfenv/bin/tfenv /usr/local/bin/tfenv
  ln -sf $HOME/.tfenv/bin/terraform /usr/local/bin/terraform

elif [ $os == "Darwin" ]; then
  brew install $tools_all $tools_brew

  #Manual install of wtf
  wget https://github.com/wtfutil/wtf/releases/download/$wtf_ver/wtf_$wtf_ver\_darwin_amd64.tar.gz
  tar -xzf wtf_$wtf_ver\_darwin_amd64.tar.gz --strip-components=1 -C /usr/local/bin/ wtf_$wtf_ver\_darwin_amd64/wtf
  rm wtf_$wtf_ver\_darwin_amd64.tar.gz

  #Enable completion and key-bindings for `fzf`
  $(brew --prefix)/opt/fzf/install --all

else
  echo "$os not supported"

fi

git submodule update --init --recursive

mv $HOME/.bashrc $HOME/.bashrc_old

ln -sf $dir/ansible.cfg $HOME/.ansible.cfg
ln -sf $dir/bashrc $HOME/.bashrc
ln -sf $dir/bash_aliases $HOME/.bash_aliases
ln -snf $dir/bash_themes $HOME/.bash_themes
ln -sf $dir/gitconfig $HOME/.gitconfig
ln -sf $dir/presidio.gitconfig $HOME/presidio.gitconfig
ln -sf $dir/technologent.gitconfig $HOME/technologent.gitconfig
ln -snf $dir/ssh $HOME/.ssh
ln -snf $dir/tmux/tmux $HOME/.tmux
ln -sf $dir/tmux/tmux.conf $HOME/.tmux.conf
ln -snf $dir/vim $HOME/.vim
ln -sf $dir/wtf_config.yml $HOME/.config/wtf/config.yml
ln -sf $dir/taskrc $HOME/.taskrc

mkdir -p $HOME/Projects/{presidio,technologent}

tfenv install 0.11.11 #latest
