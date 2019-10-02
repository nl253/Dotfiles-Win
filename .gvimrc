setg guioptions-=TmlLbRrg guioptions+=iphMa

for i in filter(['no_buffers_menu', 'did_install_default_menus', 'did_install_syntax_menu'], '!exists("g:".v:val)')
	exec 'let g:'.i.' = 1'
endfor

" if has("gui_gtk2") || has("gui_gtk3")
	" setg guifont=Courier\ New\ 11
" elseif has("gui_photon")
	" setg guifont=Courier\ New:s11
" elseif has("gui_kde")
	" setg guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
" elseif has("x11")
	" setg guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
" elseif has('win32')
	" " setg guifont=Consolas:h12
" endif
