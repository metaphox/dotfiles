# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

#need to source this before loading my theme
source ~/dotfiles/zsh-git-prompt/zshrc.sh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="metaphox"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates
# occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting
# for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(ruby git rvm jira brew osx gem mosh)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#
platform='linux'
case $OSTYPE in darwin*) platform='osx' ;; esac

#-------------------
# Personnal Aliases
#-------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias h='history'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'

alias du='du -kh'       # Makes a more readable output.


# add colors for filetype recognition
if [[ $platform == 'linux' ]]; then
	alias ls='ls -hp --color=auto'
else
	alias ls='ls -hGp'
fi

alias l="ls -l"
alias ll='ls -Al'          # show hidden files
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -alG | more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias lh='ls -a | egrep "^\."'

alias ldir="ls -lad */"

if [[ $platform == 'linux' ]]; then
    alias lpt="pstree -a | less"
else
    alias lpt="pstree | less"
fi

# Add RVM to PATH for scripting
PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH:$HOME/.rvm/bin

#-------------------
# virtualenv and rvm
#-------------------

[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc
source /usr/local/bin/virtualenvwrapper.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
rvm use 1.9.3

#-------------------
# misc
#-------------------

#z jump
source ~/dotfiles/z/z.sh

#less with syntax highlighting
export LESSOPEN="| $(brew --prefix)/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

export LANG=en_US.utf-8

#if you ever wonder why your [esc]b stuff doesn't work under my cli...
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



### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
