"
" PLUGINS
"

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'CSApprox'
Plugin 'darkspectrum'
Plugin 'hybrid.vim'
Plugin 'gruvbox'

Plugin 'ctrlp.vim'
Plugin 'EasyMotion'
Plugin 'commentary.vim'

call vundle#end()

"
" ENVIRONMENT
"

filetype plugin indent on

syntax on
set t_Co=256
silent! colorscheme hybrid

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

silent! set colorcolumn=81
au BufWinEnter * let w:m3=matchadd('ErrorMsg', '\%>120v.\+', -1)

" Disable bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

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
nnoremap <silent> <Leader>/ :noh<CR> " Old
nnoremap <silent> da/ :noh<CR>

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
    \ 'AcceptSelection("e")': ['<C-t>'],
    \ 'AcceptSelection("t")': ['<CR>', '<2-LeftMouse>'],
    \ }
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|vendor\|tmp\|Proxy\|Proxies',
    \ 'file': '',
    \ }
