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
plugins=(git pip rvm django brew osx)

source $ZSH/oh-my-zsh.sh

#use vi key binding
bindkey -v
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
# Search forward in the history for a line beginning with the current line up to the cursor.
# This leaves the cursor in its original position.

#turn off auto correction. l3aRn t0 5p3l1, you dumb.
unsetopt correct_all


function running_jobs {
    local c=$(jobs | wc -l | tr -d "[:space:]")
    if [[ $c -ne "0" ]]; then
        echo "[%{$fg[red]%}$c%{$reset_color%}] "
    fi
}

PROMPT='$(running_jobs)%{$fg[green]%}%~%{$reset_color%} %{$fg_bold[yellow]%}%(!.#.>)%{$reset_color%} '

local return_code="%(?..%{$fg[red]%}%?↵%{$reset_color%})"

RPROMPT='%{$fg[yellow]%}${${KEYMAP/vicmd/[N]}/(main|viins)/}%{$reset_color%} \
${return_code} $(git_super_status) %{$reset_color%}%D{%H:%M:%S} \
%{$fg[green]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%} \
(%{$fg[blue]%}$(basename ${VIRTUAL_ENV:-"sys"})%{$reset_color%}|%{$fg[red]%}${rvm_ruby_string:-"sys"}%{$reset_color%})'

function zle-line-init zle-keymap-select {
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="{"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_SUFFIX="}±"
ZSH_THEME_GIT_PROMPT_SEPARATOR=""


#------------------------------
#----- end of zsh specific part
#------------------------------

source ~/dotfiles/inc/envs
source ~/dotfiles/inc/common
source ~/dotfiles/inc/functions
source ~/dotfiles/inc/alias


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
