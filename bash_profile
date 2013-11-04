# Refer .bashrc
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi


export LESSOPEN="| $(brew --prefix)/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

#-------------------
# virtualenv and rvm
#-------------------

[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
rvm use 1.9.3
