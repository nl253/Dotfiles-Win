# ~/.profile sourced by all login shells

export NODE_REPL_HISTORY=$HOME/.config/node/.history
export UV_THREADPOOL_SIZE=4
# export BASH_ENV=$HOME/.config/bash/.bashrc
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export EMAIL='Norbert.Logiewa@searchflow.co.uk'

# Don't check mail when opening terminal.
unset -v MAILCHECK

# $EDITOR
for i in nvim vim vi; do
  if [ -x /usr/bin/$i ]; then
    export EDITOR=/usr/bin/$i && break
    eval "alias vim='$i'"
  fi
done

# $PAGER
if [ -x /usr/bin/less ]; then
  export LESS='--RAW-CONTROL-CHARS --IGNORE-CASE --QUIET --HILITE-SEARCH --long-prompt'
  if [ -x $(command which pygmentize 2>/dev/null) ]; then
    export LESSOPEN='| pygmentize %s'
  fi
  export PAGER=less
fi

#export HISTIGNORE="&:[ ]*:pwd:exit:cd:ls:bg:fg:history:clear:jobs:git*:ls*:dirs *:vim*:nvim*:ghci*:date:ranger:alias:dirs:popd:mutt:bash*:shopt:set:env:enable:"
#export HISTTIMEFORMAT='%c'
export FIGNORE='~:.o:.swp:history:.class:cache:.pyc:.aux:.toc:.fls:.lock:.tmp:tags:.log:.hi:.so:.beam:tags:.iml:.lock:.bak:.idx:.pack'
export HH_CONFIG=hicolor # get more colors
export HISTCONTROL=ignoreboth:erasedups
# export HISTFILE="$HOME/.config/sh/.history"
export HISTSIZE=20000
export HISTFILESIZE=$HISTSIZE
export SAVEHIST=$HISTSIZE
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
