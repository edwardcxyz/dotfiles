let mapleader = ','

set nocompatible
set nobackup
set noswapfile
set pastetoggle=<F2> " Avoid cascading indents when pasting large amounts of text

nnoremap <F2> :set invpaste paste?<CR>

" Window split configuration
set winwidth=84
set winheight=55
set winminheight=5
set winheight=999
set switchbuf+=usetab,newtab " Open quickfix view files in new tab

" Undo
call system("mkdir -p $HOME/.vim/undo")
set hidden
set history=1000
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set undofile
set undolevels=1000
set undoreload=10000

" Search
set showmatch
set ignorecase
set smartcase
set incsearch

" Tabs and indentation
set nowrap
set tabstop=2
set expandtab
set backspace=indent,eol,start " Allow backspacing over everthing in insert mode
set autoindent
set copyindent
set shiftwidth=2
set shiftround
set smarttab

" Global clipboard
set clipboard^=unnamed,unnamedplus

set shell=/bin/bash

" UI Tweaks
set laststatus=2
set colorcolumn=90
set cursorline
set hlsearch
set statusline=%F%m%r%h%w
set statusline+=\ [%l,%v]
set enc=utf-8
set t_Co=256

set autoread
au FocusGained,BufEnter * checktime

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint', 'prettier']
let g:ale_fix_on_save = 0
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:vim_vue_plugin_load_full_syntax = 1
let g:vim_vue_plugin_use_stylus = 1
let g:vim_vue_plugin_highlight_vue_keyword = 1
let g:vim_vue_plugin_use_foldexpr = 0
let NERDTreeShowHidden = 1

call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'myusuf3/numbers.vim'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentline'
Plug 'jiangmiao/auto-pairs'

call plug#end()

function! InsertColon()
  let tag = GetVueTag()
	return tag == 'template' ? ':' : ': '
endfunction

function! OnChangeVueSubtype(subtype)
  echom 'Subtype is '.a:subtype
	if a:subtype == 'html'
	  setlocal commentstring=<!--%s-->
	  setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
	elseif a:subtype =~ 'css'
	  setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
	else
	  setlocal commentstring=//%s
	  setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
	endif
endfunction

nnoremap <C-p> :Files<CR>
nmap <leader>, :NERDTreeToggle<cr>
nmap <leader>f :NERDTreeFind<cr>
nmap <leader>w :w!<cr>no
nnoremap <Leader>v <c-v> " Remap ctrl+v for visual blockwise mode

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

" syntax enable
colorscheme darcula
" colorscheme dracula

