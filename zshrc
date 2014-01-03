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
plugins=(go ruby git pip rvm django brew osx gem mosh vagrant)

source $ZSH/oh-my-zsh.sh

#use vi key binding
bindkey -v

#turn off auto correction. l3aRn t0 5p3l1, you dumb.
unsetopt correct_all

VIRTUAL_ENV_DISABLE_PROMPT=1 #will show it myself

function running_jobs {
    local c=$(jobs | wc -l | tr -d "[:space:]")
    if [[ $c -ne "0" ]]; then
        echo "[%{$fg[red]%}$c%{$reset_color%}] "
    fi
}

function current_virtual_env {
    local cur=$(basename $VIRTUAL_ENV 2> /dev/null)
    if [[ -n $cur ]]; then
        cur=$(basename $cur)
    else
        cur='sys'
    fi
    echo $cur
}

PROMPT='$(running_jobs)%{$fg[green]%}%~%{$reset_color%} %{$fg_bold[yellow]%}%(!.#.>)%{$reset_color%} '

local return_code="%(?..%{$fg[red]%}%?↵%{$reset_color%})"

RPROMPT='%{$fg[yellow]%}${${KEYMAP/vicmd/[N]}/(main|viins)/}%{$reset_color%} \
${return_code} $(git_super_status) %{$reset_color%}%{$fg[blue]%}%D{%H:%M:%S}%{$reset_color%} \
%n@%{$fg[grey]%}%m%{$reset_color%} (%{$fg[green]%}$(current_virtual_env)%{$reset_color%})'

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
