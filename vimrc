"General
set nocompatible
filetype plugin indent on
set modelines=10
set backspace=2
set tabpagemax=100
set shellcmdflag=-ic

"Whitespace
set wrap
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab
set smarttab
set autoindent
set smartindent
set nojoinspaces

"Colors
syntax on
set t_Co=256
color darkspectrum

"Lines
set number
if exists('+colorcolumn')
    set colorcolumn=81
    au BufWinEnter * let w:m1=matchadd('ColorColumn', '\%<91v.\%>81v', -1)
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>90v.\+', -1)
else
    au BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%<82v.\%>81v', -1)
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>90v.\+', -1)
endif

"Searching
set hlsearch
set ignorecase
set smartcase

"Formatting
set list
set listchars=tab:>>
set listchars+=trail:·

"Miscellaneous
set autoread
set clipboard=unnamed
"Bad habits: set mouse=a
set wildmenu
set wildmode=longest,list

"
"Custom key mappings
"

let mapleader=","

"Prevent p from replacing the buffer (copy what was originally selected)
vnoremap p pgvy

"Clear current search highlighting
nnoremap <silent> <Leader>/ :noh<CR>

"Create a new tab
nnoremap <silent> <Leader>t :tabnew<CR>

"Move tabs left or right
nnoremap <silent> g{ :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> g} :execute 'silent! tabmove ' . tabpagenr()<CR>

"Easier shortcut for previous tab
nnoremap gr gT

"Relative line numbers in normal mode
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

"Make Home toggle between soft BOL and hard BOL
function! HomeKey()
    let pos = getpos('.')
    call search('^', 'bc')
    let bol = searchpos('\s*\S', 'cne')

    if pos[1] == bol[0] && pos[2] != bol[1]
        let pos[2] = bol[1]
        call setpos('.', pos)
    endif
endfunction
map <silent> <Home> :call HomeKey()<CR>

"Clipboard
nnoremap <Leader>y :w! ~/.clipboard<CR>
vnoremap <Leader>y :w! ~/.clipboard<CR>

"Enable spell check
nnoremap <Leader>s :setlocal spell spelllang=en_us<CR>

"Set paste mode (no reformatting)
nnoremap <Leader>v :set paste!<CR>

"Remove trailing spaces
nnoremap <Leader><Space> :%s/[ \t]+$//g<CR>

"Folding and unfolding
map <Leader>f :set foldmethod=indent<CR>zM
map <Leader>F :set foldmethod=manual<CR>zR

"Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>

"CtrlP
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$|vendor$|tmp$',
    \ 'file': ''
    \ }
