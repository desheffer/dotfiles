"General
set nocompatible
filetype plugin indent on
set modelines=10
set backspace=2
set tabpagemax=100

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
set mouse=a
set wildmenu
set wildmode=longest,list

"
"Custom key mappings
"

let mapleader=","

"Tab usage
nnoremap <silent> ,t :tabnew<CR>
nnoremap <silent> g{ :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> g} :execute 'silent! tabmove ' . tabpagenr()<CR>

"Easier shortcut for previous tab
nnoremap gr gT

"Make Y yank act like D
nnoremap Y y$

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

"Open blank line beneath
nnoremap ,o o<Esc>S

"Enable spell check
nnoremap ,s :setlocal spell spelllang=en_us<CR>

"Set paste mode (no reformatting)
nnoremap ,v :set paste!<CR>

"Clear current search highlighting
nnoremap <silent> ,/ :let @/=""<CR>

"Build script
map ,, :w<CR>:!date<CR>:!./build<CR>:!./build/buildapp<CR><CR>

"Remove trailing spaces
nnoremap ,<Space> :%s/[ \t]+$//g<CR>

"Open file under cursor in new tab
nnoremap gf <c-w>gf

"Folding and unfolding
map ,f :set foldmethod=indent<CR>zM
map ,F :set foldmethod=manual<CR>zR

"Tabularize
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
vmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
