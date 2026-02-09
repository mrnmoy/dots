#!/bin/bash
set -e

echo ''

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

branch=""
cmd_prefix=""
repo="https://github.com/not-scripter/dotfiles.git"

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

while getopts "b:" opt; do
  case $opt in
    b)
      branch="$OPTARG"
      ;;
    *)
      echo "Usage: $0 [-b branch-name] repo"
      exit 1
      ;;
  esac
done

if [ -d "dotfiles" ]; then
  info "Dotfiles already exists. Skipping clone."
else
  if [ -n "$branch" ]; then
    git clone -b "$branch" "$repo"
  else
    git clone "$repo"
  fi
fi
# source ~/dotfiles/install/scripts/animations.sh


  sudo pacman -S git curl wget zsh ripgrep tmux entr pass nodejs npm neovim fzf zoxide waybar hyprpaper pavucontrol

  sudo yay -S wlogout

  sudo pacman -S fuse3 libncurses5-dev libncursesw5-dev
  #NOTE: Oh-My-Posh
  if command -v oh-my-posh &> /dev/null
  then
    info "oh-my-posh is already installed. skipping"
  else
    curl -s https://ohmyposh.dev/install.sh | bash -s
  fi
  #NOTE: arduino-cli
  if command -v arduino-cli &> /dev/null
  then
    info "arduino-cli is already installed. skipping"
  else
    curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
  fi
  install_eas_cli
  #NOTE: Zoxide
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  #NOTE: Ruby
  apt install ruby-dev && gem install public_suffix -v 5.1.1 && gem install colorls
  #NOTE: Fonts
  echo -e '$DOTFILES/fonts/=$HOME/.local/share/fonts' > ~/dotfiles/fonts/links.prop
  fc-cache -fv

  chsh -s /usr/bin/zsh

  echo 'export PATH=$PATH:/home/notscripter/.local/bin' >> ../zsh/rc.zsh

  info "Bootstrapping..."
  bash ~/dotfiles/install/scripts/bootstrap.sh

# BLA::start_loading_animation "${BLA_modern_metro[@]}"


source ~/.zshrc
# BLA::stop_loading_animation

# exit 0
# trap "echo 'Exiting script'; exit 1" INT
echo ''
echo ''
success 'All installed! Shamno Varunah'
