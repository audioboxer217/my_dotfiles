workflow "Basic Tests" {
  on = "push"
  resolves = [
    "build",
    "shellcheck"
  ]
}

action "build" {
  uses = "actions/docker/cli@master"
  args = "build -t dotfiles_test ."
}

action "shellcheck" {
  uses = "ludeeus/action-shellcheck@0.1.0"
}
