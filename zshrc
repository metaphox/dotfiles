source ~/dotfiles/inc/envs
source ~/dotfiles/inc/common
source ~/dotfiles/inc/functions
source ~/dotfiles/inc/alias

# Enable colors
autoload -U colors
colors

# Enable function substituion in prompt
setopt PROMPT_SUBST

# Use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment following line if you want red dots to be displayed while waiting
# for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
#plugins=(git brew osx)

#source $ZSH/oh-my-zsh.sh

#use vi key binding
bindkey -v
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
# Search forward in the history for a line beginning with the current line up to the cursor.
# This leaves the cursor in its original position.

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

local return_code="%(?..%{$fg[red]%}%?↵%{$reset_color%})"

#local ruby_version="%{$fg[magenta]%}$(rvm current)%{$reset_color%}"

RPROMPT='%{$fg[black]$bg[yellow]%}${${KEYMAP/vicmd/[N]}/(main|viins)/}%{$reset_color%} \
${return_code} %{$reset_color%}%D{%H:%M:%S} \
%{$fg[blue]%}%n%{$reset_color%}[%{$fg[yellow/]%}%m%{$reset_color%}] \
(%{$fg[cyan]%}$(basename ${VIRTUAL_ENV:-"sys"})%{$reset_color%})'

function zle-line-init zle-keymap-select {
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#----- end of zsh specific part

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

