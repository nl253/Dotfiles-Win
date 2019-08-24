# ~/.profile sourced by all login shells

export ENV=$HOME/.config/sh/init.sh
export NODE_REPL_HISTORY=$HOME/.config/node/.history
export ELINKS_CONFDIR=$HOME/.config/elinks
export UV_THREADPOOL_SIZE=4
# export BASH_ENV=$HOME/.config/bash/.bashrc
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export EMAIL='norbertlogiewa96@gmail.com'

# Don't check mail when opening terminal.
unset -v MAILCHECK

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

# FZF (keymap)
# ------------------------
#  enter   print to STDOUT
#  ctrl-d  scroll down
#  ctrl-u  scroll up
#  alt-e   edit with $EDITOR
#  alt-d   cd
#  alt-p   preview toggle
#  alt-l   open in  less`
export FZF_DEFAULT_COMMAND='command git ls-tree -r --name-only HEAD || command rg --files || command find . -path "*/\.*" -prune -o -type d -print -type f -print -o -type l -print | command sed s/^..//\ 2> /dev/null'
export FZF_DEFAULT_OPTS=" --filepath-word --history-size=10000 --history=$HOME/.config/fzf/.history --preview-window=right:hidden --tiebreak=end --no-mouse --multi --ansi --margin 3% --filepath-word --prompt=' >> ' --reverse --tiebreak=end,length"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind='ctrl-y:yank,alt-c:execute(cd {})' --bind='alt-b:backward-word,alt-f:forward-word' --bind='alt-v:half-page-up,ctrl-v:half-page-down,ctrl-d:half-page-down,ctrl-u:half-page-up,alt-p:toggle-preview,ctrl-n:down,ctrl-p:up'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind='alt-e:execute(\$EDITOR {})' --bind='alt-l:execute:(\$PAGER {})'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=hl:160,fg+:11,border:0,spinner:0,header:0,bg+:0,info:0"
