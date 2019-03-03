" Instructions for installing VIM:
" https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
" When compiling vim from source, remember to name the package something
" other than 'vim' when running checkinstall to prevent conflicts with
" apt. For example,
" $ sudo checkinstall --pkgname vim-custom

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

" Check syntax on each save.
" Delete this if switching to ale.
Plugin 'vim-syntastic/syntastic'

" PEP 8 checking
"Plugin 'nvie/vim-flake8'

" Make code look pretty
let python_highlight_all=1
syntax on

"" To use zenburn, need to add the following to ~/.bashrc
"" export=xterm-256color
Plugin 'jnurmine/Zenburn' " color scheme for terminal mode

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

" Enables asynchronous linting/fixing
Plugin 'w0rp/ale'

" Set standard as only linter and fixer for JavaScript files
" Need to make sure standard is already installed globally using
" $ npm install standard --global
" For Python, need to pip install flake8 autopep8
let g:ale_linters = {
\   'javascript': ['standard'],
\   'python': ['flake8'],
\}
let g:ale_fixers = {
\   'javascript': ['standard'],
\   'python': ['autopep8'],}

" lint and fix on save, but not before save.
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" All Plugins must be added before the following line
call vundle#end()

filetype plugin indent on

" Set color scheme to zenburn
" (needs to be at bottom for some reason)
set t_Co=256
let g:zenburn_high_Contrast=1 " enable high contrast mode
colors zenburn
" High-contrast highlighting in visual mode.
" Has to come after 'colors zenburn'
hi Visual ctermfg=Black ctermbg=White cterm=bold

" Shortcut to add breakpoint
ab bp import ipdb; ipdb.set_trace()

" Use '//' to search for visually-selected text
vnoremap // y/<C-R>"<CR>

" disable audio bell
set belloff=all

" PEP 8 indentation
autocmd FileType python
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

" JavaScript, HTML, and CSS filetypes
autocmd FileType javascript,html,css
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |

" tab key enters spaces instead of tab character
set expandtab

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

