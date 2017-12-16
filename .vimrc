set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'rdnetto/YCM-Generator'
Plugin 'unblevable/quick-scope'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-commentary'
" Plugin 'a.vim'
" Plugin 'junegunn/vim-easy-align'
" Plugin 'tpope/vim-rails'
" Plugin 'vim-ruby/vim-ruby'
" Plugin 'guns/vim-clojure-static'
Plugin 'airblade/vim-gitgutter'
" Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-fugitive'
" Plugin 'mxw/vim-jsx'
" Plugin 'rust-lang/rust.vim'
" Plugin 'racer-rust/vim-racer'
" Plugin 'timonv/vim-cargo'
" Plugin 'ensime/ensime-vim'
"Plugin 'derekwyatt/vim-scala'
Plugin 'godlygeek/tabular'
Plugin 'auto-pairs-gentle'
Plugin 'mileszs/ack.vim'
" Plugin 'chrisbra/csv.vim'
"Plugin 'stanangeloff/php.vim'
"Plugin 'janko-m/vim-test'
Plugin 'quentindecock/vim-cucumber-align-pipes'
Plugin 'dbext.vim'
Plugin 'SQLUtilities'
Plugin 'Align'
" Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-speeddating'
Plugin 'majutsushi/tagbar'
Plugin 'taglist.vim'
Plugin 'tpope/vim-obsession'
call vundle#end()            " required
filetype plugin indent on    " required

set backupdir=$TMPDIR
set directory=$TMPDIR

set hidden
set number
syntax enable
let g:rehash256 = 1
colorscheme molokai
let g:solarized_termcolors=256
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set ttyfast
set lazyredraw
set mouse=a
let mapleader=","
set ttymouse=xterm2
set term=screen-256color

nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set hlsearch
set backspace=indent,eol,start
set hidden

let g:ycm_seed_identifiers_with_syntax = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:ycm_confirm_extra_conf = 0
let g:syntastic_javascript_jslint_args = "--edition latest --indent 2"
let g:ruby_path = system('echo $HOME/.rbenv/shims')
let g:racer_cmd = system('echo $HOME/.cargo/bin/racer')
let g:AutoPairsUseInsertedCount = 1
let g:scala_scaladoc_indent = 1
let g:airline_theme='molokai'

" autocmd BufWritePost *.scala silent :EnTypeCheck
" nnoremap <localleader>t :EnTypeCheck<CR>
" au FileType scala nnoremap <localleader>df :EnDeclaration<CR>

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

augroup sourcesession
  autocmd!
  autocmd VimEnter * nested
        \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
        \   source Session.vim |
        \ endif
augroup END
