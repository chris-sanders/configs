set nocompatible
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

" Snippets
Plug 'honza/vim-snippets'

" Make gx work on mac?
Plug 'godlygeek/tabular'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()
" Done with plugins

" Use vim-pandoc-syntax with markdown files
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=pandoc
augroup END
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#syntax#conceal#urls = 1

au BufRead *.md setlocal nospell

" GUI Options
":set guioptions-=m  "remove menu bar
":set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

" Papercolor
set background=dark
let g:PaperColor_Theme_Options = { 
  \   'theme': { 
  \     'default.dark': {
  \	  'override': {
  \         'linenumber_fg' : ['#86B8A8', ''],
  \	  }
  \     } 
  \   }
  \ }
colorscheme PaperColor
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
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tsserver', 'coc-sh', 'coc-yaml', 'coc-snippets', 'coc-markdownlint', 'coc-marketplace', 'coc-spell-checker', 'coc-go']

" Confirm selection on CR
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Choose first auto-complete on TAB
inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Nerdtree
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
" nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

"zk
command! -nargs=0 ZkIndex :call CocAction("runCommand", "zk.index", expand("%:p"))
command! -nargs=? ZkNew :exec "edit ".CocAction("runCommand", "zk.new", expand("%:p"), <args>).path

nnoremap <leader>zi :ZkIndex<CR>
nnoremap <leader>zn :ZkNew {"title": input("Title: ")}<CR>
nnoremap <leader>zj :ZkNew {"dir": "journal/daily"}<CR>

" coc-markdownlint
let g:coc_filetype_map = { 'pandoc': 'markdown' }

" Code Actions
nmap <leader>al <Plug>(coc-codeaction-line)
nmap <CR> <Plug>(coc-definition)
vmap <CR> <Plug>(coc-codeaction-selected)
nnoremap <silent> K :call CocAction('doHover')<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Scroll floating windows
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
 vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
 vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Faster gutter updates for git
set updatetime=100

" Setup hybrid line numbers
set number
set relativenumber

" Hotkeys
map <F4> :NERDTreeToggle<CR>
map <F5> :call CocAction("runCommand", "markdownlint.fixAll")<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
