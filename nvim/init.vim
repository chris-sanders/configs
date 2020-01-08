set nocompatible
filetype off

call plug#begin()
"Color scheme
" Plug 'cseelus/vim-colors-lucid'
" Plug 'ayu-theme/ayu-vim'
" Plug 'tyrannicaltoucan/vim-deep-space'
" Plug 'dracula/vim'
Plug 'NLKNguyen/papercolor-theme'

" Show git change status in gutter
Plug 'airblade/vim-gitgutter'

" Lightline status bar
Plug 'itchyny/lightline.vim'

" Vimwiki
Plug 'vimwiki/vimwiki', { 'branch': 'dev'}
Plug 'blindFS/vim-taskwarrior'
Plug 'majutsushi/tagbar'
Plug 'tbabej/taskwiki'
Plug 'michal-h21/vimwiki-sync'

" Python
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'python/black'

" Golang
Plug 'fatih/vim-go'

" Code syntax/cleanliness checking (ALE)
Plug 'dense-analysis/ale'

" Code Autocompletion
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

call plug#end()
" Done with plugins

" Per filetype options
filetype plugin indent on
filetype plugin on

au FileType python setl shiftwidth=4 colorcolumn=120 expandtab
au FileType yml    setl shiftwidth=2 expandtab

au BufRead *.md setlocal spell
au BufRead *.txt setlocal spell
au BufRead *.markdown setlocal spell

" GUI Options
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

" Colors
" Papercolor
set background=dark
colorscheme PaperColor
let g:lightline = { 'colorscheme': 'PaperColor' }
let g:PaperColor_Theme_Options = { 
  \   'language': { 
  \     'python': { 
  \       'highlight_builtins' : 1 
  \      } 
  \   }
  \ }
"
" dracula
" colorscheme dracula
"
" deep-space
" set background=dark
" set termguicolors
" colorscheme deep-space
" let g:lightline = {'colorscheme': 'deepspace'}
" 
" ayu
" set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
"
" lucid
" colorscheme lucid

" Text editing / indenting
set autoindent
set hlsearch
set ignorecase
set nowrap
set shiftwidth=4
set showmode
set wrapmargin=2

" Deoplete
let g:deoplete#enable_at_startup = 1

" ALE
let g:ale_open_list = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {
\    'python': [
\	'isort',
\	'black',
\	'trim_whitespace',
\	'add_blank_lines_for_python_control_statements',
\	'remove_trailing_lines',
\       'autopep8',
\    ],
\}

let g:ale_python_auto_pipenv = 1
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_python_black_executable = "/home/chris/.local/share/nvim/black/bin/black"

" VimWiki / TaskWiki
syntax on
let g:vimwiki_list = [
\	{'path': '~/Wiki/Home/', 'syntax': 'markdown', 'ext': '.md'},
\	{'path': '~/Wiki/Work/', 'syntax': 'markdown', 'ext': '.md'}
\]
let g:taskwiki_sort_orders={"U": "urgency-,due-"}

" Faster gutter updates for git
set updatetime=100

" Setup hybrid line numbers
set number
set relativenumber

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
