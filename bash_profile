# Refer .bashrc
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

export LESSOPEN="| $(brew --prefix)/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

