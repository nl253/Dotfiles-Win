" vim: nospell foldmethod=marker foldlevel=1 formatoptions=o
exe 'let $MYVIMRC = '.string(expand('<sfile>'))

let &packpath = &runtimepath

" Variables: (these need to be global)
let g:mapleader      = ' '
let g:maplocalleader = ','
let g:markup_langs   = ['markdown', 'tex', 'gitcommit', 'mail']

let g:config_ftypes  = [
            \ 'yaml',
            \ 'gitconfig',
            \ 'cfg',
            \ 'dosini',
            \ 'conf',
            \ 'json',
            \ 'config'
            \ ]

let g:prog_langs = [
            \ 'sh',
            \ 'javascript',
            \ 'python',
            \ 'typescript',
            \ ]

" Only source after the above vars have been set!
so ~/.vim/plugin/plugins.vim

if has('termguicolors') && $TERM !=? 'linux'
    setg termguicolors
    colo fabulous_dark
else
    colo delek
endif
