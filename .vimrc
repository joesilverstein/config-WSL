" toggle paste mode by pressing <F2>
set pastetoggle=<F2>

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle:
" First need to run
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
Plugin 'gmarik/Vundle.vim'

" split layouts
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make auto-indentation work better
Plugin 'vim-scripts/indentpython.vim'

" Use UTF-8 encoding
set encoding=utf-8

" TabNine Autocompletion
Plugin 'zxqfl/tabnine-vim'

" Make code look pretty
"let python_highlight_all=1
syntax on

"" To use zenburn, need to add the following to ~/.bashrc
"" export=xterm-256color
" Also need to simply copy the file to colors/ subdirectory under
" Vim configuration folder (e.g. ~/.vim/colors or C:\vim\colors).
"Plugin 'jnurmine/Zenburn' " color scheme for terminal mode

" File tree
"Plugin 'scrooloose/nerdtree'

" File tree tabs
"Plugin 'jistr/vim-nerdtree-tabs'

" Hide .pyc files
"let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Search for almost anything from VIM by pressing ^Ctrl+P
"Plugin 'kien/ctrlp.vim'

" Turn on line numbering
set nu

" Git integration
"Plugin 'tpope/vim-fugitive'

" Access system clipboard (not sure if works in Ubuntu)
"set clipboard=unnamed

" Wrap at 72 chars for comments.
set formatoptions=cq textwidth=72 foldignore= wildignore+=*.py[co]

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
let g:ale_linters = {
\   'javascript': ['standard'],
\   'python': ['flake8', 'pylint'],
\}
let g:ale_fixers = {
\   'javascript': ['standard'],
\   'python': ['autopep8'],}

" lint and fix on save, but not before save.
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" Show filename in fancy status bar at bottom
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='angr'
" Special vim-airline configuration for WSL
" https://github.com/vim-airline/vim-airline
let g:airline_powerline_fonts = 1
" Incompatible powerline symbols for Iosevka font
" https://github.com/vim-airline/vim-airline/wiki/FAQ
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = " "
" https://github.com/vim-airline/vim-airline/issues/1397
let g:airline_symbols.whitespace = " "
" display full path of file
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

" All Plugins must be added before the following line
call vundle#end()

filetype plugin indent on

" Set color scheme to zenburn
" (needs to be at bottom for some reason)
"set t_Co=256
"let g:zenburn_high_Contrast=1 " enable high contrast mode
"colors zenburn
" High-contrast highlighting in visual mode.
" Has to come after 'colors zenburn'
hi Visual ctermfg=White ctermbg=LightCyan cterm=bold
hi Search cterm=NONE ctermfg=grey ctermbg=LightGreen

" Shortcut to add breakpoint in python
ab bp import ipdb; ipdb.set_trace()

" Shortcut to add embedded ipython session (to get full benefits of
" ipython)
ab em from IPython import embed; embed()

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

" Clear highlighting on pressing ESC
nnoremap <esc> :noh<return><esc>

" Fill-in boilerplate to replace exact selected text when pressing
" CTRL-R in visual mode.
vnoremap <C-r> "hy:%s/\<<C-r>h\>//gc<left><left><left>

" Prevent x and X keys from overwriting the register in normal mode
nnoremap x "_x
nnoremap X "_X

" transparent background
hi Normal guibg=NONE ctermbg=NONE

" Disable the preview window, since it gets annoying
set completeopt-=preview
