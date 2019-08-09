workflow "New workflow" {
  on = "push"
  resolves = [
    "run run_tests.sh",
    "shellcheck"
  ]
}

action "build" {
  uses = "actions/docker/cli@master"
  args = "build -t dotfiles_test ."
}

action "run run_tests.sh" {
  uses = "actions/docker/cli@master"
  args = "run -it --rm dotfiles_test ./run_tests.sh"
  needs = ["build"]
}

action "shellcheck" {
  uses = "ludeeus/action-shellcheck@0.1.0"
}
