"
" PLUGINS
"

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'CSApprox'
Plugin 'ctrlp.vim'
Plugin 'darkspectrum'
Plugin 'hybrid.vim'
Plugin 'jellybeans.vim'
Plugin 'EasyMotion'
call vundle#end()

"
" ENVIRONMENT
"

filetype plugin indent on

syntax on
set t_Co=256
silent! colorscheme darkspectrum

set clipboard=unnamed

set wrap
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab
set smarttab
set autoindent
set smartindent
set nojoinspaces
set backspace=indent,eol,start
set pastetoggle=<F12>

set number
set relativenumber
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set list
set listchars=tab:›\ ,trail:·,extends:#,nbsp:.
set foldmethod=indent
set foldenable!

set shellcmdflag=-ic
set wildmenu
set wildmode=longest,list
set autoread
set tabpagemax=100

if exists('+colorcolumn')
    set colorcolumn=81
    au BufWinEnter * let w:m1=matchadd('ColorColumn', '\%<91v.\%>81v', -1)
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>90v.\+', -1)
else
    au BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%<82v.\%>81v', -1)
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>90v.\+', -1)
endif

" Disable bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"
" FUNCTIONS
"

function! HomeKey()
    let pos = getpos('.')
    call search('^', 'bc')
    let bol = searchpos('\s*\S', 'cne')

    if pos[1] == bol[0] && pos[2] != bol[1]
        let pos[2] = bol[1]
        call setpos('.', pos)
    endif
endfunction

"
" MAPPINGS
"

let mapleader=","

" Prevent p from replacing the buffer (copy what was originally selected)
vnoremap p pgvy

" Move by displayed line
nnoremap j gj
nnoremap k gk

" Make Y yank to end of line
nnoremap Y y$

" Preserve selection on indent
vnoremap < <gv
vnoremap > >gv

" Clear current search highlighting
nnoremap <silent> <Leader>/ :noh<CR>

" Create a new tab
nnoremap <silent> <Leader>t :tabnew<CR>

" Move tabs left or right
nnoremap <silent> g{ :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> g} :execute 'silent! tabmove ' . tabpagenr()<CR>

" Easier shortcut for previous tab
nnoremap gr gT

" Relative line numbers in normal mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Make Home toggle between soft BOL and hard BOL
map <silent> <Home> :call HomeKey()<CR>

" Clipboard
nnoremap <Leader>y :w! ~/.clipboard<CR>
vnoremap <Leader>y :w! ~/.clipboard<CR>

" Enable spell check
nnoremap <Leader>s :setlocal spell spelllang=en_us<CR>

" Remove trailing spaces
nnoremap <Leader><Space> :%s/[ \t]*$//g<CR>:noh<CR>

" Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>

" CtrlP
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|vendor\|tmp\|Proxy\|Proxies',
    \ 'file': '',
    \ }
