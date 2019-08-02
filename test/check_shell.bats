#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "Check for ZSH" {
  run echo $SHELL
  assert_line "/bin/zsh"
}

@test "Check Oh-My-ZSH" {
  run echo $ZSH
  assert_line "${HOME}/.oh-my-zsh"
}
