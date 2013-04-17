# Refer .bashrc
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

#-------------------
# Path
#-------------------

PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#-------------------
# virtualenv and rvm
#-------------------

[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
rvm use 1.9.3

#-------------------
# Misc
#-------------------

#-------------------
# A bunch of useful tools
#-------------------

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

export LESSOPEN="| $(brew --prefix)/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

