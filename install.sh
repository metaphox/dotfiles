#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link_file() {
  local source_path="$1"
  local target_path="$2"

  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    printf 'ok    %s -> %s\n' "$target_path" "$source_path"
    return 0
  fi

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    local backup_path="${target_path}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$target_path" "$backup_path"
    printf 'moved %s -> %s\n' "$target_path" "$backup_path"
  fi

  ln -s "$source_path" "$target_path"
  printf 'linked %s -> %s\n' "$target_path" "$source_path"
}

mkdir -p "${HOME}/.config/nvim"

link_file "${DOTFILES_DIR}/profile/bash_profile" "${HOME}/.bash_profile"
link_file "${DOTFILES_DIR}/profile/bashrc" "${HOME}/.bashrc"
link_file "${DOTFILES_DIR}/profile/zshrc" "${HOME}/.zshrc"
link_file "${DOTFILES_DIR}/profile/gitconfig" "${HOME}/.gitconfig"
link_file "${DOTFILES_DIR}/profile/tmux.conf" "${HOME}/.tmux.conf"
link_file "${DOTFILES_DIR}/config/nvim/init.lua" "${HOME}/.config/nvim/init.lua"

printf '\nDone.\n'
printf 'Optional local env file: %s\n' "${DOTFILES_DIR}/inc/envs.local"
