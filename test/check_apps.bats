#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "bat" {
  run bat -h
  assert_success
}

@test "exa" {
  run exa
  assert_success
}

@test "prettyping" {
  run prettyping -h
  assert_success
}
