" ---------------------------------
"  General
" ---------------------------------

set nocompatible
set modeline
set showcmd
set autoread

filetype on
filetype indent on
filetype plugin on

set expandtab
set smarttab
set tabstop=4 shiftwidth=4

set cindent
set autoindent
set smartindent
set smartcase

set incsearch

set backspace=2
set grepprg=grep\ -nH\ $*

set noeb
set vb t_vb=

call pathogen#infect()

" ---------------------------------
"  Highlighting
" ---------------------------------

set list listchars=tab:»·,trail:·
set hlsearch

" ---------------------------------
"  Visuals
" ---------------------------------

set novisualbell
set noerrorbells

" ---------------------------------
"  User Interface
" ---------------------------------

set number
set mousehide
set background=dark

" ---------------------------------
"  Theme/Color
" ---------------------------------

syntax on
colorscheme slate
set t_Co=256
set term=xterm-256color

if has('gui_running')
  set guifont=DejaVu\ Sans\ Mono\ 18
endif

" ---------------------------------
"  Status Line
" ---------------------------------

set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" ---------------------------------
"  Open URL in Browser
" ---------------------------------

function! Browser ()
  let line = getline (".")
  let line = matchstr (line, "http[^   ]*")
  exec "!google-chrome ".line
endfunction
map <Leader>w :call Browser ()<CR>

" ---------------------------------
"  Autocmd
" ---------------------------------
" abbreviations for c programming
func LoadCAbbrevs()
  iabbr do do {<CR>} while ();<C-O>3h<C-O>
  iabbr for for (;;) {<CR>}<C-O>k<C-O>3l<C-O>
  iabbr switch switch () {<CR>}<C-O>k<C-O>6l<C-O>
  iabbr while while () {<CR>}<C-O>k<C-O>5l<C-O>
  iabbr if if () {<CR>}<C-O>k<C-O>2l<C-O>
  iabbr #d #define
  iabbr #i #include
endfunc
autocmd FileType c,cpp call LoadCAbbrevs()

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif

autocmd FileType python set nocindent shiftwidth=4 ts=4

" for Go
autocmd FileType go set nocindent shiftwidth=4 ts=4 noexpandtab
autocmd BufRead,BufNewFile *.go setfiletype go

" for Coffeescript
autocmd FileType coffeescript set nocindent shiftwidth=2 ts=2 noexpandtab
autocmd BufRead,BufNewFile *.coffee setfiletype coffeescript

" For django templates
autocmd BufRead,BufNewFile *.html setfiletype htmldjango

" Change to directory file is in without crippling commandline
autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /

augroup content
  autocmd BufNewFile *.py
     \ 0put = '#!/usr/bin/env python'  |
     \ 1put = '#-*- coding: utf-8 -*-' |
     \ $put = '' |
     \ norm gg19jf]
augroup END

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" ---------------------------------
"  Remaps and Replaces
" ---------------------------------

" For local replace
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>
" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" ---------------------------------
"  TODO list
" ---------------------------------

noremap <Leader>t :noautocmd vimgrep /TODO(nick)/j **/*.py<CR>:cw<CR>

" ---------------------------------
"  NERDTree
" ---------------------------------

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ---------------------------------
"  Highlight over 79cols
" ---------------------------------

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%80v.\+/

" ---------------------------------
" Disable Arrow keys (use hjkl!)
" ---------------------------------
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

"
" vim-flake8 settings
"
autocmd FileType python map <buffer> <Leader><F8> :call Flake8()<CR>
let g:flake8_max_line_length=200 " We don't have a max line length
