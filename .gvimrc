setg guioptions-=TmlLbRrg guioptions+=iphMa

for i in filter(['no_buffers_menu', 'did_install_default_menus', 'did_install_syntax_menu'], '!exists("g:".v:val)')
	exec 'let g:'.i.' = 1'
endfor
