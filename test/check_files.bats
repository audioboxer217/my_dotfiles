#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'
load "${HOME}/.bash_functions"

link_check() {
  local -r filename="$1"
  run ls -F "${HOME}/${filename}"
  assert_line "${HOME}/${filename}@"
}

@test "Ansible Config link" {
  link_check .ansible.cfg
}

@test "Bash Aliases link" {
  link_check .bash_aliases
}

@test "Bash Functions link" {
  link_check .bash_functions
}

@test "Bash Themes link" {
  link_check .bash_themes
}

@test "bashrc link" {
  link_check .bashrc
}

@test "Git Configlink" {
  link_check .gitconfig
}

@test "Global Git Ignore link" {
  link_check .gitignore_global
}

@test "Presidio Git Configlink" {
  link_check presidio.gitconfig
}

@test "Technologent Git Config link" {
  link_check technologent.gitconfig
}

@test "SSH Config link" {
  link_check .ssh/config
}

@test "Task Warrior Config link" {
  link_check .taskrc
}

@test "Tmux Config link" {
  link_check .tmux
}

@test "Vim Config link" {
  link_check .vim
}
