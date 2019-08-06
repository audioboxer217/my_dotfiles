#!/bin/bash

username="$(whoami)"
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
os="$(uname -a | awk '{printf $1}')"
tools_apt="vim \
           tmux \
           ansible \
           htop \
           zsh \
           zsh-syntax-highlighting"

if [ $os == "Linux" ]; then
  sudo apt-get update && sudo apt-get install -y $tools_apt

  ### Manual Installations ###
  # keybase
  curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
  sudo dpkg -i keybase_amd64.deb
  sudo apt-get install -f

  # bat
  bat_ver=0.11.0
  wget https://github.com/sharkdp/bat/releases/download/v$bat_ver/bat_$bat_ver\_amd64.deb
  sudo dpkg -i bat_$bat_ver\_amd64.deb
  rm bat_$bat_ver\_amd64.deb

  # exa
  exa_ver=0.9.0
  wget https://github.com/ogham/exa/releases/download/v$exa_ver/exa-linux-x86_64-$exa_ver.zip
  unzip -p  exa-linux-x86_64-$exa_ver.zip exa-linux-x86_64 > exa
  sudo mv exa /usr/local/bin/exa
  sudo chmod +x /usr/local/bin/exa
  rm exa-linux-x86_64-$exa_ver.zip
  sudo curl -L https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.bash -o /etc/bash_completion.d/exa

  # prettyping
  prettyping_ver=1.0.1
  wget https://github.com/denilsonsa/prettyping/archive/v$prettyping_ver.zip
  unzip -p v$prettyping_ver.zip prettyping-$prettyping_ver/prettyping > prettyping
  sudo mv prettyping /usr/local/bin/prettyping
  sudo chmod +x /usr/local/bin/prettyping
  rm v$prettyping_ver.zip

  # fzf
  cd $HOME
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install --all

  # z
  sudo mkdir -p /usr/local/etc/profile.d
  sudo curl "https://raw.githubusercontent.com/rupa/z/master/{z.sh}" -o /usr/local/etc/profile.d/"#1"

  # kube-ps1
  kube_ps1_ver=0.7.0
  wget https://github.com/jonmosco/kube-ps1/archive/v$kube_ps1_ver.tar.gz
  sudo mkdir -p /usr/local/opt/kube-ps1/share
  sudo tar -xzf v$kube_ps1_ver.tar.gz --strip-components=1 -C /usr/local/opt/kube-ps1/share/ kube-ps1-$kube_ps1_ver/kube-ps1.sh
  rm v$kube_ps1_ver.tar.gz

  # tfenv
  git clone https://github.com/kamatama41/tfenv.git $HOME/.tfenv
  sudo ln -sf $HOME/.tfenv/bin/tfenv /usr/local/bin/tfenv
  sudo ln -sf $HOME/.tfenv/bin/terraform /usr/local/bin/terraform

elif [ $os == "Darwin" ]; then
  # install homebrew if it's missing
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew update && brew bundle install --file $dir/Brewfile

  #Enable completion and key-bindings for `fzf`
  $(brew --prefix)/opt/fzf/install --all

  if [ -d "$HOME/.iterm2"  ]; then
    echo "Setting iTerm preference folder"
    ln -sf $dir/iterm2.plist $HOME/.iterm2/com.googlecode.iterm2.plist
    defaults write com.googlecode.iterm2 PrefsCustomFolder "$HOME/.iterm2"
  fi

else
  echo "$os not supported"

fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O $HOME/oh-my-zsh_install.sh
  chmod +x $HOME/oh-my-zsh_install.sh
  $HOME/oh-my-zsh_install.sh --unattended
fi

### Oh-My-ZSH Plugins ###
# Powerlevel10k Theme
git clone https://github.com/romkatv/powerlevel10k.git ${HOME}/.oh-my-zsh/custom/themes/powerlevel10k
# iterm-touchbar
cd ${HOME}/.oh-my-zsh/custom/plugins
git clone https://github.com/iam4x/zsh-iterm-touchbar.git

git submodule update --init --recursive

mv $HOME/.bashrc $HOME/.bashrc_old

ln -sf $dir/ansible.cfg $HOME/.ansible.cfg
ln -sf $dir/bashrc $HOME/.bashrc
ln -sf $dir/zshrc $HOME/.zshrc
ln -sf $dir/bash_aliases $HOME/.bash_aliases
ln -sf $dir/bash_aliases $HOME/.oh-my-zsh/custom/aliases.zsh
ln -sf $dir/bash_functions $HOME/.bash_functions
ln -sf $dir/bash_functions $HOME/.oh-my-zsh/custom/functions.zsh
ln -snf $dir/bash_themes $HOME/.bash_themes
ln -snf $dir/scripts $HOME/scripts
ln -sf $dir/gitconfig $HOME/.gitconfig
ln -sf $dir/gitignore_global $HOME/.gitignore_global
ln -sf $dir/presidio.gitconfig $HOME/presidio.gitconfig
ln -sf $dir/technologent.gitconfig $HOME/technologent.gitconfig
if [ ! -d "$HOME/.ssh" ]; then mkdir -p $HOME/.ssh/config.d; fi
ln -sf $dir/ssh_config $HOME/.ssh/config
for confile in $(ls $dir/ssh); do
  ln -sf $dir/$confile $HOME/.ssh/config.d/$confile
done
ln -snf $dir/tmux/tmux $HOME/.tmux
ln -sf $dir/tmux/tmux.conf $HOME/.tmux.conf
ln -snf $dir/vim $HOME/.vim
ln -sf $dir/taskrc $HOME/.taskrc

mkdir -p $HOME/Projects/{presidio,technologent}

tfenv install latest

echo "Don't forget to:"
echo " - execute 'run_keybase'"
echo " - import gpg key (https://github.com/pstadler/keybase-gpg-github/blob/master/README.md)"
