# Enable colors
autoload -U colors
colors

ZSH=~/.oh-my-zsh
# Use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment following line if you want red dots to be displayed while waiting
# for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git brew osx)

source $ZSH/oh-my-zsh.sh

# Search forward in the history for a line beginning with the current line up to the cursor.
# This leaves the cursor in its original position.
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# edit current command in editor by pressing v in cmd mode
# the following function are supplied by vi-mode plugin already
#bindkey -v
#autoload -U edit-command-line
#zle -N edit-command-line
#bindkey -M vicmd v edit-command-line

#turn off auto correction. l3aRn t0 5p3l1, you dumb.
unsetopt correct_all


# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf via local installation
if [ -e ~/.fzf ]; then
  _append_to_path ~/.fzf/bin
  source ~/.fzf/shell/key-bindings.zsh
  source ~/.fzf/shell/completion.zsh
fi

PROMPT='%{$reset_color%}%(1j.[%j] .)%{$fg[yellow]%}%(!.#.❯)%{$reset_color%} '

local return_code="%(?..%{$fg[yellow]%}%?↵%{$reset_color%})"

#local ruby_version="%{$fg[magenta]%}$(rvm current)%{$reset_color%}"

# $(vi_mode_prompt_info) requires vi-mode plugin
#RPROMPT='%{$reset_color%}$(vi_mode_prompt_info) ${return_code} %{$reset_color%}%D{%H:%M:%S} \
#%{$fg[blue]%}%n%{$reset_color%}[%{$fg[yellow/]%}%m%{$reset_color%}] \
#(%{$fg[cyan]%}$(basename ${VIRTUAL_ENV:-"sys"})%{$reset_color%})'

RPROMPT='%{$reset_color%}${return_code} %D{%H:%M:%S} \
%{$fg[blue]%}%n%{$reset_color%}[%{$fg[yellow/]%}%m%{$reset_color%}] \
(%{$fg[cyan]%}$(basename ${CONDA_DEFAULT_ENV:-"root"})%{$reset_color%})'

#zle -N zle-line-init
#zle -N zle-line-finish
#zle -N zle-keymap-select

#----- end of zsh specific part

source ~/dotfiles/inc/envs
source ~/dotfiles/inc/functions
source ~/dotfiles/inc/alias
