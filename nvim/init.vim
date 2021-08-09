"set nocompatible
"filetype off

call plug#begin()
" Color
Plug 'NLKNguyen/papercolor-theme'

" Show git change status in gutter
Plug 'airblade/vim-gitgutter'
"
" Lightline status bar
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

" Table mode
Plug 'dhruvasagar/vim-table-mode'

" Code browser
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Local vimrc
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'

" Ultisnips
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()
" Done with plugins

" Mark .md files as markdown for highlighting
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

"au BufRead *.md setlocal spell
"au BufRead *.txt setlocal spell
"au BufRead *.markdown setlocal spell

" GUI Options
":set guioptions-=m  "remove menu bar
":set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

" Papercolor
set background=dark
colorscheme PaperColor
"let g:PaperColor_Theme_Options = { 
"  \   'language': { 
"  \     'python': { 
"  \       'highlight_builtins' : 1 
"  \      } 
"  \   }
"  \ }
" coc status in lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Coc
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tsserver', 'coc-sh', 'coc-yaml']
" Confirm selection on CR
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Nerdtree
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

"zk
command! -nargs=0 ZkIndex :call CocAction("runCommand", "zk.index", expand("%:p"))
command! -nargs=? ZkNew :exec "edit ".CocAction("runCommand", "zk.new", expand("%:p"), <args>).path

nnoremap <leader>zi :ZkIndex<CR>
nnoremap <leader>zn :ZkNew {"title": input("Title: ")}<CR>
nnoremap <leader>zj :ZkNew {"dir": "journal/daily"}<CR>

"xmap <silent> <leader>zn :'<,'> lua vim.lsp.buf.range_code_action()<CR>
"xmap <silent> <leader>zn <cmd>'<,'> lua vim.lsp.buf.range_code_action()<CR>
vmap <leader>zn <Plug>(coc-codeaction-selected)
"xnoremap <leader>zn <Plug>(coc-codeaction-selected)<CR>
nnoremap <silent> K :call CocAction('doHover')<CR>

" Use system python when in venv
" let g:python3_host_prog="/usr/bin/python3"
" let g:python_host_prog=0

" Loca vimrc
call lh#local_vimrc#munge('whitelist', $HOME.'/Wiki/Eberron')

" Faster gutter updates for git
set updatetime=100

" Setup hybrid line numbers
set number
set relativenumber

" Hotkeys
map <F4> :NERDTreeToggle<CR>
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"map <F5> :ALEFix<CR>
"map <F6> <Plug>(ale_toggle_buffer)
"map <F7> <Plug>(ale_reset_buffer)
"nmap <F8> :TagbarToggle<CR>
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)


" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
