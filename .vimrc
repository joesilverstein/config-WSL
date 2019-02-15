" Instructions for installing VIM:
" https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" toggle paste mode by pressing <F2>
set pastetoggle=<F2>

" split layouts
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Makes folding work better
Plugin 'tmhedberg/SimpylFold'

" See docstrings for folded code
let g:SimpylFold_docstring_preview=1

" PEP 8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Other filetypes
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Make auto-indentation work better
Plugin 'vim-scripts/indentpython.vim'

" Use UTF-8 encoding
set encoding=utf-8

" Enable auto-complete
" To get it to work, need to do the following:
" sudo apt purge python-openssl
" sudo apt install python-openssl
" sudo apt install build-essential cmake python3-dev
" cd ~/.vim/bundle/YouCompleteMe
" python3 install.py --clang-completer
Bundle 'Valloric/YouCompleteMe'

" Ensure that the auto-complete window goes away when done with it,
" and add shortcut for goto definition
" space-g will goto definition of whatever you're currently on
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Check syntax on each save
Plugin 'vim-syntastic/syntastic'

" PEP 8 checking
Plugin 'nvie/vim-flake8'

" Make code look pretty
let python_highlight_all=1
syntax on

"" To use zenburn, need to add the following to ~/.bashrc
"" export=xterm-256color
Plugin 'jnurmine/Zenburn' " color scheme for terminal mode
set t_Co=256
let g:zenburn_high_Contrast=1 " enable high contrast mode
" High-contrast highlighting in visual mode
hi Visual ctermfg=Black ctermbg=White cterm=bold

" File tree
Plugin 'scrooloose/nerdtree'

" File tree tabs
Plugin 'jistr/vim-nerdtree-tabs'

" Hide .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Search for almost anything from VIM by pressing ^Ctrl+P
Plugin 'kien/ctrlp.vim'

" Turn on line numbering
set nu

" Git integration
Plugin 'tpope/vim-fugitive'

" Status bar that displays current virtualenv, git branch,
" files being edited, etc.
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Access system clipboard (not sure if works in Ubuntu)
set clipboard=unnamed

" Wrap at 72 chars for comments.
set formatoptions=cq textwidth=72 foldignore= wildignore+=*.py[co]

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" change leader key to ','
let mapleader = ","

" allows commenting while in normal mode
Plugin 'scrooloose/nerdcommenter'

" Show tabs as characters (to get rid of them)
set list
set listchars=tab:>-

" All Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Set color scheme to zenburn
" (needs to be at bottom for some reason)
colors zenburn

" Shortcut to add breakpoint
ab bp import ipdb; ipdb.set_trace()
