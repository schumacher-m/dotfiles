set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'unblevable/quick-scope'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-commentary'
" Plugin 'airblade/vim-gitgutter'
Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'auto-pairs-gentle'
Plugin 'mileszs/ack.vim'
Plugin 'chrisbra/csv.vim'
Plugin 'quentindecock/vim-cucumber-align-pipes'
Plugin 'dbext.vim'
Plugin 'SQLUtilities'
Plugin 'Align'
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-speeddating'
Plugin 'majutsushi/tagbar'
Plugin 'taglist.vim'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'
Plugin 'lifepillar/vim-solarized8'
Plugin 'hdima/python-syntax'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'rhlobo/vim-super-retab'
Plugin 'posva/vim-vue'
Plugin 'digitaltoad/vim-pug'
call vundle#end()            " required
filetype plugin indent on    " required
let mapleader=","
set backupdir=$TMPDIR
set directory=$TMPDIR
set hidden
set number
set numberwidth=5
syntax enable
set background=dark
colorscheme solarized8
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set ttyfast
set lazyredraw
set mouse=a
set textwidth=80
set colorcolumn=+1

if !has('nvim')
  set ttymouse=xterm2
  set term=screen-256color
endif

nmap <leader>n :NERDTreeToggle<CR>
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
set hlsearch
set backspace=indent,eol,start
set hidden
let g:airline_powerline_fonts = 1
let NERDTreeHighlightCursorline=1
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
let g:airline_theme='solarized'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.jsx
autocmd FileType vue syntax sync fromstart

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" autocmd BufWritePost *.scala silent :EnTypeCheck
" nnoremap <localleader>t :EnTypeCheck<CR>
" au FileType scala nnoremap <localleader>df :EnDeclaration<CR>
" set synmaxcol=128
" syntax sync minlines=256
"autocmd VimEnter * Prosession ./
" augroup CursorLine
"   au!
"   au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"   au WinLeave * setlocal nocursorline
" augroup END

" augroup sourcesession
"   autocmd!
"   autocmd VimEnter * nested
"         \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
"         \   source Session.vim |
"         \ endif
" augroup END
