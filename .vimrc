set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rdnetto/YCM-Generator'
Plugin 'unblevable/quick-scope'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-commentary'
Plugin 'a.vim'
Plugin 'junegunn/vim-easy-align'
"Plugin 'tpope/vim-rails'
"Plugin 'vim-ruby/vim-ruby'
Plugin 'guns/vim-clojure-static'
Plugin 'airblade/vim-gitgutter'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-fugitive'
Plugin 'mxw/vim-jsx'

call vundle#end()            " required
filetype plugin indent on    " required

set hidden
set number
syntax enable
let g:rehash256 = 1
colorscheme molokai
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set ttyfast
set lazyredraw
set mouse=a
let mapleader=","
set ttymouse=xterm2

nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set hlsearch
set backspace=indent,eol,start

let g:ycm_seed_identifiers_with_syntax = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:ycm_confirm_extra_conf = 0
let g:syntastic_javascript_jslint_args = "--edition latest --indent 2"
