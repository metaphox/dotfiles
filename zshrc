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
plugins=(git brew osx vi-mode)

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

# https://github.com/sindresorhus/pure
# and yes, i am misusing it
source ~/dotfiles/pure/pure.zsh

function running_jobs {
    local c=$(jobs | wc -l | tr -d "[:space:]")
    if [[ $c -ne "0" ]]; then
        echo "[%{$fg[red]%}$c%{$reset_color%}] "
    fi
}

PROMPT='$(running_jobs)%{$fg_bold[yellow]%}%(!.#.❯)%{$reset_color%} '

local return_code="%(?..%{$fg[yellow]%}%?↵%{$reset_color%})"

#local ruby_version="%{$fg[magenta]%}$(rvm current)%{$reset_color%}"

#RPROMPT='%{$fg[black]$bg[yellow]%}${${KEYMAP/vicmd/[N]}/(main|viins)/}%{$reset_color%} \

# $(vi_mode_prompt_info) requires vi-mode plugin
RPROMPT='$(vi_mode_prompt_info) ${return_code} %{$reset_color%}%D{%H:%M:%S} \
%{$fg[blue]%}%n%{$reset_color%}[%{$fg[yellow/]%}%m%{$reset_color%}] \
(%{$fg[cyan]%}$(basename ${VIRTUAL_ENV:-"sys"})%{$reset_color%})'

function zle-line-init zle-keymap-select {
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#----- end of zsh specific part

source ~/dotfiles/inc/envs
source ~/dotfiles/inc/common
source ~/dotfiles/inc/functions
source ~/dotfiles/inc/alias

