setg rtp-=~/.vim
exe 'setg rtp-='.expand('~/.vim')
setg rtp^=~/.vim

setg rtp-=~/.vim/after
exe 'setg rtp-='.expand('~/.vim/after')
setg rtp+=~/.vim/after

so ~/.vimrc
