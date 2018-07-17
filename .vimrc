" vim:set ts=2 sts=2 sw=2 expandtab:
" Minimal vim config to preserve sanity.
" by Aurélien Noce <aurelien.noce@imagine-app.fr>

" sensible defaults
set encoding=utf-8
set nocompatible
set novisualbell
set backspace=indent,eol,start
set shell=bash
set wildmode=longest,list,full

" Allow multiple edition on a file
set nobackup
set noswapfile
set hidden

" Colors
syntax on
colorscheme desert

" Indent & plugins enabled
filetype plugin indent on
set autoindent
set tabstop=2 softtabstop=0 shiftwidth=2 " defaults
set expandtab smarttab

"
" Mappgins
"

let mapleader=","

" <leader><leader> => previous buffer
nnoremap <leader><leader> <C-^>
" %% expands to current directory
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" <leader>e => open current directory
map <leader>e :e %%<CR>
" <leader>i => open w/ prefix for fuzzy search
map <leader>i :e **/*
set wildmenu
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*
" <C-hjkl> => move among windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" splits s=horizontal / v = vertical / d = close
nnoremap <leader>s <C-w>s
nnoremap <leader>v <C-w>v
nnoremap <leader>d <C-w>c


