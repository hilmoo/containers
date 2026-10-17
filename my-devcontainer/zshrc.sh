#!/usr/bin/env bash
set -e

add_to_zshrc() {
  touch ~/.zshrc
  grep -qxF "$1" ~/.zshrc || echo "$1" >> ~/.zshrc
}

add_to_zshrc 'eval "$(devbox global shellenv)"'
add_to_zshrc 'eval "$(task --completion zsh)"'
add_to_zshrc 'eval "$(direnv hook zsh)"'