# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# git completion
if [ -f ~/.git-prompt.sh ]; then
  . ~/.git-prompt.sh
fi

export TERM=xterm-256color
export VISUAL=vim
export HISTCONTROL=ignoredups
export NODE_REPL_HISTORY_FILE=~/.node_history
export PS1="\[\033[41m\] ubuntu \[\033[49m\]\[\033[44m\] \W \[\033[49m\]\[\033[43m\]\[\033[30m\]\$(__git_ps1 \" %s \")\[\033[39m\]\[\033[49m\] "

alias ls='ls --color=auto'
alias ll='ls -lh --group-directories-first'
alias ..='cd ..'
alias publish='git push && git push --tags && npm publish'

setup_ssh () {
  eval $(ssh-agent)
  ssh-add ~/.ssh/id_rsa
}

