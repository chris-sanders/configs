set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" NOTE: You need to have checked out Vundle to this path
" Source is https://github.com/VundleVim/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin onHub repo
" Plugin 'tpope/vim-five'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" plugin not hosted onHub
" Plugin :/.wincent.com/command-t'
" repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" NERDTree is a great directory tree pane
" for navigating around multi-file projects
" within vim
Plugin 'scrooloose/nerdtree'

" Multi-VCS integration for running VCS commands
" from within vim whilst working on a file
" Supported Git and BZR
Plugin 'juneedahamed/vc.vim'

" Helps NERDTree deal with tabs for opening
" files from the tree
Plugin 'jistr/vim-nerdtree-tabs'

" Puppet DSL support (you don't need this,
" I bootstrap my workstations with puppet)
Plugin 'rodjek/vim-puppet'

" Tab support plugin
Plugin 'godlygeek/tabular'

" Simply the best syntax highlighitng module
Plugin 'scrooloose/syntastic'

" Adds visual indentation guides
Plugin 'nathanaelkane/vim-indent-guides'

" Flake8 Python Plugin
Plugin 'nvie/vim-flake8'

" Good Git integration
Plugin 'tpope/vim-fugitive'

" PEP8 Indenting
Plugin 'Vimjas/vim-python-pep8-indent'

" YAML indenting
Plugin 'stephpy/vim-yaml'

" All the golang things
Plugin 'fatih/vim-go'

" monokai colorscheme
Plugin 'sickill/vim-monokai'

" For the below, you'll need to enter the checked out directory
" once it's been installed by Vundle, and run ./install.py --all.
" The readme details the deps you need to install under Ubuntu.
" Step by step: https://valloric.github.io/YouCompleteMe/#ubuntu-linux-x64
" Currently using ./install.py --clang-completer --gocode-completer
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

if has('gui_running') 
    set guifont=Roboto\ Mono\ for\ Powerline\ 12
endif

colorscheme monokai

let loaded_matchparen = 1

map <F10> z.
map <F11> z+
map <F12> :!!
map <F2> :w
map <F3> :x
map <F4> :q
map <F5> :rew
map <F6> :N
map <F7> :e#
map <F8> :n
map <F9> :make
map <F10> :SyntasticReset
map <F11> mzgg=G`z

set autoindent
set hlsearch
set ignorecase
set nowrap
set shiftwidth=4
set showmode
set wrapmargin=2
set textwidth=80

au FileType python setl shiftwidth=4 expandtab
au FileType php    setl shiftwidth=4 expandtab
au FileType pp     setl shiftwidth=4 expandtab
au FileType yml    setl shiftwidth=4 expandtab

let g:syntastic_enable_signs=0
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_python_flake8_exe = '/usr/bin/python3 -m flake8'
let g:syntastic_python_pylint_exec = '/usr/bin/pylint3'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'vim' : ['re![_a-zA-Z]+[_\w]*\.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

nmap <C-n> :lnext<CR>
nmap <C-p> :lprev<CR>

syntax on
set t_Co=256

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

au BufRead *.md setlocal spell
au BufRead *.markdown setlocal spell
