set relativenumber
set number

set ignorecase
set smartcase
set incsearch
if has ("syntax")
        syntax on
endif

let g:highlightedyank_highlight_duration = 1000

let mapleader = "\<Space>"

" Sometimes I like shift too much
command! W write
command! Q quit
command! Wq wq
command! WQ wq
command! Wa wall
command! WA wall
command! Wqa wqall
command! WQa wqall
command! WQA wqall

" Don't use Ex mode, use Q for formatting.
map Q <NOP>
nnoremap <Space> <NOP>
noremap <Left> <Nop>
noremap <Right> <Nop>

"" -- Custom mappings --
noremap <Leader>y \"+y
noremap <Leader>p \"+p
noremap <Leader>P \"+P
nnoremap k kzz
vnoremap k kzz
nnoremap j jzz
vnoremap j jzz
nmap <Up> k
vmap <Up> k
nmap <Down> j
vmap <Down> j
nnoremap { {zz
vnoremap { {zz
nnoremap } }zz
vnoremap } }zz
nnoremap n nzz
nnoremap N Nzz
nnoremap ; ;zz
nnoremap , ,zz
