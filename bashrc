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

alias l="ls -l"
alias ls='ls -hG'         # add colors for filetype recognition
alias ll='ls -Al'          # show hidden files
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -alG | more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias lh='ls -a | egrep "^\."'

#-------------------
# Prompt
#-------------------

PS1="\[\033[1;32m\]\w\[\033[0m \[\033[0m\]\[\033[1;36m\](\h)\
\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[\033[0m\]\n > "
# PS1="\`powerline-prompt\`>"
PS2=":> "


export LANG=en_US.UTF-8

