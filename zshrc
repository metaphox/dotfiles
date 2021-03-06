setopt PROMPT_SUBST
# Enable colors
autoload -U colors && colors

# Use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment following line if you want red dots to be displayed while waiting
# for completion
COMPLETION_WAITING_DOTS="true"

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

PROMPT="${fg[green]}%~ %{$fg[yellow]%}
%(!.#.>)%{$reset_color%} "

local return_code="%(?..%{$fg[yellow]%}%?↵%{$reset_color%})"

RPROMPT="%{$reset_color%}${return_code} (%{$fg[cyan]%}$(basename ${VIRTUAL_ENV:-'root'})%{$reset_color%}) \
%{$fg[blue]%}%n%{$reset_color%}[%{$fg[yellow/]%}%m%{$reset_color%}] %D{%H:%M:%S}"

#----- end of zsh specific part

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
fi

source ~/.dotfiles/inc/envs
source ~/.dotfiles/inc/functions
source ~/.dotfiles/inc/alias

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

if [ -e /usr/local/bin/pyenv ]; then
    eval "$(pyenv init -)"
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

