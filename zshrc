# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

#need to source this before loading my theme
source ~/dotfiles/zsh-git-prompt/zshrc.sh

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment following line if you want red dots to be displayed while waiting
# for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(ruby git rvm jira brew osx gem mosh vagrant)

source $ZSH/oh-my-zsh.sh

#use vi key binding
bindkey -v

#turn off auto correction. l3aRn t0 5p3l1, you dumb.
unsetopt correct_all

PROMPT='%{$fg[grey]%}%D{%H:%M:%S} %{$fg[yellow]%}%~ \
$fg[$NCOLOR]%(!.#.>)%{$reset_color%}'

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
RPROMPT='%{$fg[red]%}${${KEYMAP/vicmd/[N]}/(main|viins)/ }%{$reset_color%} \
${return_code} $(git_super_status) \
%{$fg[green]%}%n%{$reset_color%}@$my_orange%m%{$reset_color%}%'

function zle-line-init zle-keymap-select {
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]±["
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075]]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=""


#------------------------------
#----- end of zsh specific part
#------------------------------

source dotfiles/envs
source dotfiles/common
source dotfiles/alias
source dotfiles/functions

