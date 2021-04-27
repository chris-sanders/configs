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
Plug 'maximbaz/lightline-ale'

" Vimwiki
Plug 'vimwiki/vimwiki', { 'branch': 'dev'}
Plug 'michal-h21/vimwiki-sync'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'

" Table mode
Plug 'dhruvasagar/vim-table-mode'

" Python
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'psf/black'

" Code browser
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'PhilRunninger/nerdtree-buffer-ops'

" Code commenting
Plug 'preservim/nerdcommenter'

" Automatic closing
Plug 'jiangmiao/auto-pairs'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Golang
" Plug 'fatih/vim-go'

" Code syntax/cleanliness checking (ALE)
Plug 'dense-analysis/ale'

" Code Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Tagbar
Plug 'preservim/tagbar'

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
let g:PaperColor_Theme_Options = { 
  \   'language': { 
  \     'python': { 
  \       'highlight_builtins' : 1 
  \      } 
  \   }
  \ }
" Lightline
let g:lightline = { 'colorscheme': 'PaperColor' }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]] }

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

" Nerdtree
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1
" let g:deoplete#auto_complete_delay = 300
call deoplete#custom#option('sources', {'_': ['ale']})
"
" ALE
let g:ale_open_list = 1
let g:ale_list_window_size = 5
let g:ale_linters = {'python': ['flake8', 'pyls']}
let g:ale_fixers = {
\    'python': [
\	'isort',
\	'black',
\    ],
\}

let g:ale_python_auto_pipenv = 1
" let g:ale_python_flake8_auto_pipenv = 1
let g:ale_python_black_executable = "/home/chris/.local/share/nvim/black/bin/black"
let g:black_virtualenv = "/home/chris/.local/share/nvim/black"

" Hotkeys
" nnoremap <C-t> :NERDTreeToggle<CR>
map <F4> :NERDTreeToggle<CR>
map <F5> :ALEFix<CR>
map <F6> <Plug>(ale_toggle_buffer)
map <F7> <Plug>(ale_reset_buffer)
nmap <F8> :TagbarToggle<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Zettel
let g:zettel_format = '%Y%m%d-%H%M%S'
" let g:zettel_options = [{"front_matter" : {"tags" : ""}, "template": "~/Wiki/Zettel/template/new_zettel.tpl"}]
let g:zettel_options = [{"disable_front_matter" : 1 , "template": "~/Wiki/Zettel/template/new_zettel.tpl"}]
nmap T <Plug>ZettelYankNameMap

" VimWiki / TaskWiki
syntax on
let g:vimwiki_list = [
\	{'path': '~/Wiki/Zettel/', 'syntax': 'markdown', 'ext': '.md', 'list_margin': 0, 'index': 'home', 'auto_tag':1},
\	{'path': '~/Wiki/Eberron/', 'syntax': 'markdown', 'ext': '.md', 'list_margin': 0, 'index': 'home', 'auto_tag':1},
\	{'path': '~/Wiki/Kingmaker/', 'syntax': 'markdown', 'ext': '.md', 'list_margin': 0, 'index': 'home'},
\	{'path': '~/Wiki/Home/', 'syntax': 'markdown', 'ext': '.md', 'list_margin': 0},
\	{'path': '~/Wiki/PrivateCloud/', 'syntax': 'markdown', 'ext': '.md', 'list_margin': 0, 'index': 'home'},
\	{'path': '~/Wiki/Work/', 'syntax': 'markdown', 'ext': '.md', 'list_margin': 0}
\]
" let g:taskwiki_sort_orders={"U": "urgency-,due-"}
let g:vimwiki_auto_chdir = 1
" Leave my other .md files alone
let g:vimwiki_global_ext=0
let g:vimwiki_hl_headers=1
" Use Table mode, built in tables blocks Ultisnips
let g:vimwiki_table_auto_fmt = 0
let g:vimwiki_key_mappings = {}
let g:vimwiki_key_mappings.table_mappings = 0

nnoremap <leader>gt :VimwikiRebuildTags!<cr>:VimwikiGenerateTagLinks<cr><c-l>
nnoremap <leader>bl :VimwikiBacklinks<cr>

" Tag search
" Not working currently
" let g:tagbar_type_vimwiki = {
"           \   'ctagstype':'markdown'
"           \ , 'kinds':['h:header']
"           \ , 'sro':'&&&'
"           \ , 'kind2scope':{'h':'header'}
"           \ , 'sort':0
"           \ , 'ctagsbin': '/home/chris/.config/nvim/VimwikiTags/vwtags.py'
"           \ , 'ctagsargs': 'default'
"           \ }

" Use system python when in venv
let g:python3_host_prog="/usr/bin/python3"
let g:python_host_prog=0

" Faster gutter updates for git
set updatetime=100

" Setup hybrid line numbers
set number
set relativenumber

" Don't auto-rename
" set allow-rename off

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
