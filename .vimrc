" based on http://qiita.com/kawaz/items/ee725f6214f91337b42b
if !&compatible
  set nocompatible
endif

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let s:toml_file = $XDG_CONFIG_HOME . '/nvim/dein.toml'
  let s:toml_lazy_file = $XDG_CONFIG_HOME . '/nvim/dein_lazy.toml'
  call dein#load_toml(s:toml_file,      {'lazy': 0})
  call dein#load_toml(s:toml_lazy_file, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if dein#check_install()
  call dein#install()
endif

" Vim options
syntax on
set nobackup
set hidden
set autoread
set encoding=utf-8
set ignorecase
set smartcase
set incsearch
set hlsearch
set backspace=indent,eol,start
set wrapscan
set wildmenu
set formatoptions+=mM
set showmatch
set number
set ruler
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<
set notitle
set nowrap
set laststatus=2
set cmdheight=2
set showcmd
set shortmess+=I
set guicursor=a:blinkon0
set autoindent
set diffopt=filler,vertical
set virtualedit+=block
set smarttab
set ambiwidth=double

set tabstop=2
set shiftwidth=2
set expandtab

" syntax hilighting for doxygen docs in c/c++/c# code
let g:load_doxygen_syntax = 1

if isdirectory($HOME.'/.vimtmp')
    set swapfile
    set directory=~/.vimtmp
    set undodir=~/.vimtmp
else
    set noswapfile
    set noundofile
endif

" open quickfix after make,grep,..
aug myquickfix
    au! myquickfix
    au QuickfixCmdPost make,grep,grepadd,vimgrep bo copen
    au QuickfixCmdPost l* bo lopen
aug END

" enable cursorline only on current window
aug myautocul
    au! myautocul
    au WinLeave * set nocul
    au WinEnter,BufRead * set cul
aug END

" move to last cursor position
aug myautolastcursor
    au! myautolastcursor
    au BufReadPost * if line("'\"") > 1 && line ("'\"") <= line ("$") | exe "normal! g`\"" | endif
aug END

" for smartchr
" autocmd FileType c,cpp inoremap <buffer> <expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn') ? '<bs>= ' : search('\(*\<bar>!\)\%#', 'bcn') ? '= ' : smartchr#loop(' = ', ' == ', '=')
" autocmd FileType c,cpp inoremap <buffer> <expr> = smartchr#loop(' = ', '=', ' == ')
" autocmd FileType c,cpp inoremap <buffer> <expr> + smartchr#loop(' + ', '++', '+')
" autocmd FileType c,cpp inoremap <buffer> <expr> - smartchr#loop(' - ', '--', '-')
" autocmd FileType c,cpp inoremap <buffer> <expr> / smartchr#loop(' / ', '// ', '/')
" autocmd FileType c,cpp inoremap <buffer> <expr> % smartchr#loop(' % ', '%')
" autocmd FileType c,cpp inoremap <buffer> <expr> & smartchr#loop('&', ' & ', ' && ')
" autocmd FileType c,cpp inoremap <buffer> <expr> ? smartchr#loop('? ', '?')
" autocmd FileType c,cpp inoremap <buffer> <expr> : smartchr#loop(': ', '::', ':')
" autocmd FileType c,cpp inoremap <buffer> <expr> , smartchr#loop(', ', ',')
" autocmd FileType c,cpp inoremap <buffer> <expr> . smartchr#loop('.', '->', '...')
" autocmd FileType c,cpp inoremap <buffer> <expr> > search('^#include <.*\%#', 'bcn') ? '>' : smartchr#loop('>', ' > ', ' >> ', ' >= ')
" autocmd FileType c,cpp inoremap <buffer> <expr> < search('^#include\%#', 'bcn') ? ' <' : smartchr#loop('<', ' < ', ' << ', ' <= ')
" autocmd FileType c,cpp inoremap <buffer> <expr> " search('^#include\%#', 'bcn') ? ' "' : '"'
" autocmd FileType c,cpp inoremap <buffer> <expr> ( search('\<\if\%#', 'bcn') ? ' (' : '('

" for quickrun
if !exists("g:quickrun_config")
  let g:quickrun_config = {}
endif

"\ 'runner' : 'vimproc',

let g:quickrun_config['_'] = {
\ 'runner/vimproc/updatetime' : 60,
\ 'outputter/buffer/split' : 'rightbelow 4sp',
\ 'outputter/buffer/close_on_empty' : 1,
\ 'outputter/error/error'   : 'quickfix',
\ 'outputter/error/success' : 'buffer',
\ 'outputter'               : 'error',
\}
nnoremap <expt><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

" let g:quickrun_config['syntax/rust'] = {
\ 'command' : 'rustc',
\ 'cmdopt' : '-Zparse-only',
\ 'exec' : '%c %o %s:p',
\ 'outputter' : 'quickfix',
\}

" for neocomplete
" let g:neocomplete#enable_at_startup = 1
" let g:neacomplete#enable_smart_case = 1
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" for racer
let g:racer_cmd = expand('$HOME/.cargo/bin/racer')

" Keybinds

" move center
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
" change window size
nmap <C-z> <C-W><
nmap <C-x> <C-W>>
" next buffer
nmap <C-h> :bN<CR>
" previous buffer
nmap <C-l> :bn<CR>
" reload config
nmap ,s :so ~/.vimrc<CR>
" edit config
nmap ,v :e ~/.vimrc<CR>

" disable highlight
nmap <ESC><ESC> :nohl<CR><ESC>
" move in quickfix
nmap <C-j> :cn<CR>
nmap <C-k> :cp<CR>
" close Quickfix
nmap <C-[> :ccl<CR>
" move in command mode
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
" \\ to savk
noremap <Leader><Leader> :up<CR>

" nmap ,f :<C-u>Unite grep::-iRn:<C-r><C-w><CR><CR>
" nmap <C-]> :<C-u>Unite gtags/context<CR>
" nmap <F3> :<C-u>Unite file_mru<CR>
" nmap <F4> :<C-u>Unite file<CR>
" nmap <F5> :<C-u>Unite buffer<CR>

" svn Diff
" nmap <F6> :VCSVimDiff<CR>
" close svn Diff
" nmap <F7> :winc l<CR>:bw<CR>:diffoff<CR>
" toggle tlist
"nmap <F8> :Unite outline -toggle<CR>
"nmap <F8> :TlistToggle<CR>
"
" nmap <F8> :tabclose<CR>

" neosnippet
" imap <C-k> <Plug>(neosnippet_expand_or_jump)
" smap <C-k> <Plug>(neosnippet_expand_or_jump)

" unite
" nnoremap <silent> ,us :<C-u>UniteVersions status:!<CR>
" nnoremap <silent> ,ul :<C-u>UniteVersions log:%<CR>
" nnoremap <silent> ,uf :<C-u>Unite file<CR>
" nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" autocmd FileType unite nnoremap <silent><buffer> <ESC><ESC> :q<CR>
" autocmd FileType unite inoremap <silent><buffer> <ESC><ESC> <ESC>:q<CR>

" nerdcommenter
"nmap ,c<Space> <Leader>c<Space>
"vmap ,c<Space> <Leader>c<Space>

" map ,z <Plug>(operator-camelize)
" map ,Z <Plug>(operator-decamelize)

autocmd FileType go autocmd BufWritePre <buffer> Fmt

" airline
let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticsStatuslineFlag()}
set statusline+=%*

let g:syntastic_rust_checkers = ['cargo']
let g:syntastic_always_populage_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_chech_on_open = 1
let g:syntastic_chech_on_wq = 0

colo gruvbox
