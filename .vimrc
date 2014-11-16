
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Neobundl
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimproc.vim', '', 'default'
call neobundle#config('vimproc.vim', {
\ 'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin'  : 'make -f make_cygwin.mak',
\     'mac'     : 'make -f make_mac.mak',
\     'unix'    : 'make -f make_unix.mak',
\    },
\ })
NeoBundle 'bling/vim-airline'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'hewes/unite-gtags'
call neobundle#end()

filetype plugin indent on
NeoBundleCheck

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

" these configurations should be changed depending on coding rules
set tabstop=4
set shiftwidth=4
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
" switch-case indent 0
set cinoptions=:0

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
autocmd FileType c,cpp inoremap <buffer> <expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn') ? '<bs>= ' : search('\(*\<bar>!\)\%#', 'bcn') ? '= ' : smartchr#loop(' = ', ' == ', '=')
"autocmd FileType c,cpp inoremap <buffer> <expr> = smartchr#loop(' = ', '=', ' == ')
autocmd FileType c,cpp inoremap <buffer> <expr> + smartchr#loop(' + ', '++', '+')
autocmd FileType c,cpp inoremap <buffer> <expr> - smartchr#loop(' - ', '--', '-')
autocmd FileType c,cpp inoremap <buffer> <expr> / smartchr#loop(' / ', '// ', '/')
autocmd FileType c,cpp inoremap <buffer> <expr> % smartchr#loop(' % ', '%')
autocmd FileType c,cpp inoremap <buffer> <expr> & smartchr#loop('&', ' & ', ' && ')
autocmd FileType c,cpp inoremap <buffer> <expr> ? smartchr#loop('? ', '?')
autocmd FileType c,cpp inoremap <buffer> <expr> : smartchr#loop(': ', '::', ':')
autocmd FileType c,cpp inoremap <buffer> <expr> , smartchr#loop(', ', ',')
autocmd FileType c,cpp inoremap <buffer> <expr> . smartchr#loop('.', '->', '...')
autocmd FileType c,cpp inoremap <buffer> <expr> > search('^#include <.*\%#', 'bcn') ? '>' : smartchr#loop('>', ' > ', ' >> ', ' >= ')
autocmd FileType c,cpp inoremap <buffer> <expr> < search('^#include\%#', 'bcn') ? ' <' : smartchr#loop('<', ' < ', ' << ', ' <= ')
autocmd FileType c,cpp inoremap <buffer> <expr> " search('^#include\%#', 'bcn') ? ' "' : '"'
autocmd FileType c,cpp inoremap <buffer> <expr> ( search('\<\if\%#', 'bcn') ? ' (' : '('

" for neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neacomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'


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

nmap ,f :<C-u>Unite grep::-iRn:<C-r><C-w><CR><CR>

nmap <C-]> :<C-u>Unite gtags/context<CR>
nmap <F3> :<C-u>Unite file_mru<CR>
nmap <F4> :<C-u>Unite file<CR>
nmap <F5> :<C-u>Unite buffer<CR>

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
imap <silent><C-l> <Plug>(neosnippet_expand_or_jump)
smap <silent><C-l> <Plug>(neosnippet_expand_or_jump)

" unite
" nnoremap <silent> ,us :<C-u>UniteVersions status:!<CR>
" nnoremap <silent> ,ul :<C-u>UniteVersions log:%<CR>
nnoremap <silent> ,uf :<C-u>Unite file<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
au FileType unite nnoremap <silent><buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent><buffer> <ESC><ESC> <ESC>:q<CR>

" nerdcommenter
"nmap ,c<Space> <Leader>c<Space>
"vmap ,c<Space> <Leader>c<Space>

" map ,z <Plug>(operator-camelize)
" map ,Z <Plug>(operator-decamelize)

" quickrun
" nnoremap <expt><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

