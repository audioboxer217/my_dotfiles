workflow "New workflow" {
  on = "push"
  resolves = ["run run_tests.sh"]
}

action "shellcheck" {
  uses = "ludeeus/action-shellcheck@0.1.0"
}

action "run setup_home.sh" {
  uses = "shinhwagk/remote-bash@master"
  env = {
    REMOTE_BASH_URL = "https://raw.githubusercontent.com/audioboxer217/my_dotfiles/master/setup_home.sh"
  }
  needs = ["shellcheck"]
}

action "run run_tests.sh" {
  uses = "shinhwagk/remote-bash@master"
  env = {
    REMOTE_BASH_URL = "https://raw.githubusercontent.com/audioboxer217/my_dotfiles/master/run_tests.sh"
  }
  needs = ["run setup_home.sh"]
}
