" annoying Windows shells don't support suspend
nn <C-Z> :echoerr "Sorry, suspending doesn't work on Windows"<CR>

for s:_dir in ['~/.vim', '~/.vim/.swp', '~/.vim/.backup']
  let s:dir = expand(s:_dir)
  if !isdirectory(s:dir)
    call mkdir(s:dir, 'p')
  endif
endfor

let g:mapleader      = ' '
let g:maplocalleader = ','

setg statusline=%#Function#%(%f%#Normal#\ %#Comment##%n\ %m\ %r\ %w%#Normal#%)%=%-22(%#Number#%y\ %l/%L\ %p%%%) thesaurus=~/.vim/thesaurus.dict dictionary=~/.vim/frequent.dict sw=2 ts=4 expandtab virtualedit=all autochdir autoread autowriteall backup breakat=\ .,:;!?' cmdwinheight=3 completeopt=menuone,longest fileignorecase diffopt+=vertical,iwhite gdefault hidden foldclose=all cpoptions=aABceFsW viewoptions=folds,options,curdir,cursor wildignorecase wildmenu wildoptions=tagfile winminwidth=20 winwidth=20 writebackup incsearch laststatus=2 magic maxmempattern=200000 nocompatible hlsearch ignorecase noshowcmd nostartofline pumheight=12 scrolloff=11 sessionoptions+=resize sessionoptions-=blank sessionoptions-=options shiftround shortmess=stTAIcoOWF showbreak=\ >> sidescroll=1 sidescrolloff=30 spellsuggest=best,12, splitbelow splitright switchbuf=usetab,newtab, tagcase=ignore tagcase=match taglength=20 tagrelative tagstack undolevels=9999 updatetime=200 path+=.. path+=* wildignore=*~,*#,#*,*.dat*,node_modules/*,*-lock.json,*.min.*,out,*.class,*.beam,*.hi,*.pdf,*.ppt,*.pptx,*.doc,*.docx,*.jpg,*.png,*.ipynb,*history,*cache,.git,.idea,.svn,.hg,*.mpg,*.mp3,*.mp4,*.epub,*.msi,*.exe,*.dll,*~ grepprg=rg.exe\ --vimgrep\ --max-depth\ 5\ --max-filesize\ 70K\ --color\ never\ --no-line-buffered\ --no-messages\ --threads\ 4\ --trim\ --smart-case\ --one-file-system directory^=$HOME/.vim/.swp backupdir^=$HOME/.vim/.backup 

aug AUCMDS
  au!
  au BufEnter            ??*                     try | sil! lch %:p:h | cat /\vE(472|344|13)/ | endtry
  au QuickFixCmdPost     c{ex,adde},grep{,a}*    exe 'bo cw '.((len(getqflist()[:10]) < 8) ? len(getqflist()) + 1 : "")
  au QuickFixCmdPost     l{ex,gr,grepa,gete,ad}* exe 'bo lw '.((len(getloclist(win_getid())[:10]) < 8) ? len(getloclist(win_getid())) + 1 : "")
  au QuickFixCmdPost     vim,lv,gr,lgr           try | sil! lch %:p:h | catch /\vE(472|344|13)/ | endtry
  au CursorHold,BufEnter ~/*                     sil! checkt
  au syntax              * if &completefunc == '' | setl completefunc=syntaxcomplete#Complete | endif
aug END

if has('nvim')
  "so ~\_gvimrc
  setg shada=!,'20,<50,s10,h,:50,f10 inccommand=nosplit clipboard= mouse=a runtimepath^=~\.vim runtimepath+=~\.vim\after runtimepath-=~\AppData\Local\nvim runtimepath-=~\AppData\Local\nvim\after runtimepath-=~\AppData\Local\nvim\site
  let &packpath = &runtimepath
else
  filetype plugin on
  syntax on
endif


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if has('nvim') && empty($TMUX)
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  au TermOpen * star
  tno <Esc> <C-\><C-n>
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if has("termguicolors")
    set termguicolors
  endif
endif


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
      \ 'sql',
      \ 'css',
      \ 'html',
      \ 'sh',
      \ 'javascript',
      \ 'typescript',
      \ ]

call plug#begin('~/.vim/plugged')

let g:omni_syntax_minimum_length = 2

let g:UltiSnipsSnippetDirectories = [$HOME.'\.vim\snips']

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

let g:UltiSnipsExpandTrigger = '<tab>'

Plug 'elixir-editors/vim-elixir'
Plug 'PProvost/vim-ps1'
Plug 'tpope/vim-fugitive'
Plug 'dkarter/bullets.vim', {'for': g:markup_langs + g:config_ftypes}

" Bullets:
let g:bullets_enabled_file_types      = g:markup_langs + g:config_ftypes + ['gitcommit']
let g:bullets_enable_in_empty_buffers = 1

Plug 'wellle/targets.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'reedes/vim-wordy', {'on': ['Wordy', 'WordyWordy'], 'for': g:markup_langs}
Plug 'joshdick/onedark.vim'
Plug 'colepeters/spacemacs-theme.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

if has('nvim') || has('patch8') | Plug 'w0rp/ale', {'on': ['ALEEnable', 'ALEEnableBuffer', 'ALEToggle', 'ALEToggleBuffer']} | el | Plug 'vim-syntastic/syntastic' | en

let g:ale_sign_error          = 'E'
let g:ale_sign_warning        = 'W'

" JavaScript:
" syntax
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" Netrw:
let g:netrw_banner            = 0
let g:netrw_browse_split      = 3
let g:netrw_hide              = 1
let g:netrw_list_hide         = join(map(split(&wildignore, ','), 'glob2regpat(v:val)'), '|')
"let g:netrw_list_hide         = '\v^[\._]|\.(beam|hi|pdf|class|lock)$|^tags$'

let g:netrw_liststyle         = 3
let g:netrw_mousemaps         = 0
let g:netrw_preview           = 1 
let g:netrw_scpport           = '-P 22' 
let g:netrw_sizestyle         = 'H'
let g:netrw_special_syntax    = 1
let g:netrw_sshport           = '-p 22'
let g:netrw_wiw               = &winminwidth

" XML:
" might be computationally demanding
" better beautify and use indent-based fold
let g:xml_syntax_folding      = 0 

" YAML:
let g:yaml_schema             = 'pyyaml'
let g:loaded_saner            = 1

" HTML:
let g:html_use_xhtml          = 0
let g:html_dynamic_folds      = 0
let g:html_no_foldcolumn      = 1 
let g:html_use_encoding       = 'UTF-8'
let g:html_font = [
      \ 'Roboto', 
      \ 'Sans Serif', 
      \ ]
let g:html_wrong_comments     = 1
let g:html_hover_unfold       = 1

call plug#end()

if has('nvim')
  "colo onedark
  colo spacemacs-theme
else 
  colo darkblue
endif

fu! s:register_ftype(patterns, filetype)
  exe 'au BufNewFile,BufReadpost '.join(a:patterns, ',').' if &filetype == "" | setl ft='.a:filetype.' | endif' 
endf

fu! s:force_ftype(patterns, filetype)
  exe 'au BufNewFile,BufRead '.join(a:patterns, ',').' setl ft='.a:filetype
endf

sil cal s:register_ftype([
      \ 'requrements.txt', 
      \ '.flake8', 
      \ '.gitstats', 
      \ '.mypyrc', 
      \ '.myclirc'
      \ ], 'cfg')
sil cal s:register_ftype(['.ideavimrc'], 'vim')
sil cal s:register_ftype(['*.gv'], 'dot')
sil cal s:register_ftype(['*{ignore,conf}*'], 'config')
sil cal s:register_ftype(['*.puml'], 'plantuml')
sil cal s:register_ftype(['.{markdown,html,es,style}lintrc', '.{babel,jsbeautify}rc' ,'*.lock', '.tsconfig'], 'json')
sil cal s:register_ftype(['*.{twig,nunj,njk,hbs}'], 'htmldjango')
sil cal s:register_ftype(['*.toml'], 'cfg')
sil cal s:register_ftype(['*.*css'], 'css')

sil cal s:force_ftype(['*.ctags'], 'ctags')
sil cal s:force_ftype(['*.ts'], 'typescript')

"vim:foldmethod=indent:
