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

alias ls='ls -hG'         # add colors for filetype recognition
alias l="ls -l"
alias ll='ls -Al'          # show hidden files
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -alG | more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias lh='ls -a | egrep "^\."'

#-------------------
# Path
#-------------------

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/python:\
Applications/Postgres.app/Contents/MacOS/bin:/usr/local/share/npm/bin:$PATH

#-------------------
# Prompt
#-------------------

PS1="\[\033[1;32m\]\w\[\033[0m \[\033[0m\]\[\033[1;36m\](\h)\
\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[\033[0m\]\n > "
PS2=":>"

#-------------------
# virtualenv and rvm
#-------------------

#export VIRTUAL_ENV_DISABLE_PROMPT=true
. /usr/local/share/python/virtualenvwrapper.sh

#might not need this for a fresh re-install
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:\
/Library/Python/2.7/site-packages:${PYTHONPATH}
workon 27

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
rvm use 1.9.2

#-------------------
# Misc
#-------------------

# Refer .bashrc
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

#-------------------
# A bunch of useful tools
#-------------------

alias ipythonconsole="ipython qtconsole --pylab=inline&"
alias ipythonnotebook="ipython notebook --pylab inline&"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

