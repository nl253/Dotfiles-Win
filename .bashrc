# ~/.bashrc  executed by bash(1)

alias vim=nvim

if ((BASH_VERSINFO < 4)); then
  echo "[ERROR] your bash is outdated, install bash >= 4"
  return 0
fi

shopt -s xpg_echo globasciiranges histappend checkjobs checkwinsize \
  globstar extglob dotglob nocasematch nocaseglob cdspell dirspell \
  checkhash cdable_vars

PROMPT_COMMAND="history -a"

PS1=' >> '
export EDITOR=nvim
for i in ls diff grep; do
  eval "alias $i='$i --color=always'"
done

alias grep='command grep -E -I --color=auto'
if [[ -x ~/.cargo/bin/rg ]]; then
  alias rg='command rg --hidden --pretty --no-heading --threads $(grep -c ^processor /proc/cpuinfo) --context 1 --max-count 3 --no-search-zip'
fi

# this here is very format dependent - do not change
# dirs and files
ls_opts='--color=auto --group-directories-first'
if builtin dirs 1>/dev/null 2>/dev/null && [ -x ~/.cargo/bin/exa ]; then
  # replace all occurances of ' -I ' with '|' required by exa
  alias ls="command exa $ls_opts --git --git-ignore"
else
  alias ls="command ls $ls_opts"
fi
unset -v ls_opts

for file in completions; do
  [[ -f ~/.config/bash/$file.sh ]] && . ~/.config/bash/$file.sh
done

non_git_prompt='$(command basename $0):/$PWD :: '

# set ls colors
builtin eval $(command dircolors -b)
export PS1="${non_git_prompt}"

for var in git_basic_info non_git_prompt; do unset -v $var; done
# vim:sw=2:ts=4:expandtab:
