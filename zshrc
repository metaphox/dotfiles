# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
source ~/dotfiles/zsh-git-prompt/zshrc.sh
ZSH_THEME="metaphox"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(ruby git jira brew)

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

alias ls='ls -h --color=auto'         # add colors for filetype recognition
alias l="ls -l"

# add colors for filetype recognition
if [[ $platform == 'linux' ]]; then
	alias ls='ls -h --color=auto'
else
	alias ls='ls -hG'
fi

alias ll='ls -Al'          # show hidden files
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -alG | more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias lh='ls -a | egrep "^\."'

alias ldir="ls -lad */"

PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#-------------------
# virtualenv and rvm
#-------------------

[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
rvm use 1.9.3

source ~/dotfiles/z/z.sh

