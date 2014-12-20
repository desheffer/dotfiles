"==============================================================================
" Plugins
"==============================================================================

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'godlygeek/csapprox'
Plugin 'vim-scripts/darkspectrum'
Plugin 'w0ng/vim-hybrid'
Plugin 'morhetz/gruvbox'

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'scrooloose/nerdtree'

Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

Plugin 'tpope/vim-eunuch'

call vundle#end()

"==============================================================================
" Environment Settings
"==============================================================================

set t_Co=256
silent! colorscheme hybrid

set clipboard=unnamed           " Use the system clipboard

set ignorecase                  " Default to case insensitive searches
set smartcase                   " Unless uppercase letters are present
set hlsearch                    " Highlight searches
set incsearch                   " Search while typing

set wrap                        " Wrap lines
set scrolloff=3                 " Pad the cursor with 3 lines
set scrolljump=5                " Scroll by 5 lines
set number                      " Show line numbers
set relativenumber              " Relative to the current line
silent! set colorcolumn=80      " Draw right margin at 80 characters

set list                        " Enable hidden characters
set listchars=tab:▷·            " Show tab characters
set listchars+=trail:·          " Show trailing spaces

set foldenable!                 " Disable folding by default
set foldmethod=syntax           " But allow it to be enabled easily

set wildmode=longest,list       " Make completion mode acts like Bash

set showcmd                     " Show incomplete normal mode commands
set pastetoggle=<F12>           " Toggle paste mode

set directory^=~/.backup//      " Write swap files to ~/.backup

"==============================================================================
" Mappings
"==============================================================================

let mapleader=","

" Prevent p from replacing the buffer (copy what was originally selected)
vnoremap p pgvy

" Make Y yank to end of line
nnoremap Y y$

" Preserve selection on indent
vnoremap < <gv
vnoremap > >gv

" Clear current search highlighting
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Create a new tab
nnoremap <silent> <Leader>t :tabnew<CR>

" Move tabs left or right
nnoremap <silent> g{ :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> g} :execute 'silent! tabmove ' . tabpagenr()<CR>

" Easier shortcut for previous tab
nnoremap gr gT

" Yank to cross-server clipboard
nnoremap <Leader>y :w! ~/.clipboard<CR>
vnoremap <Leader>y :w! ~/.clipboard<CR>

" Enable spell check
nnoremap <Leader>s :setlocal spell spelllang=en_us<CR>

" Remove trailing spaces
nnoremap <Leader><Space> :%s/[ \t]*$//g<CR>:nohlsearch<CR>

" Align certain characters
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>

" Toggle NERD Tree
nnoremap <Leader>n :NERDTreeFocus<CR>

" Disable bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"==============================================================================
" Plugin Settings
"==============================================================================

let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|vendor\|tmp\|Proxy\|Proxies',
    \ 'file': '',
    \ }

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<C-t>'],
    \ 'AcceptSelection("t")': ['<CR>', '<2-LeftMouse>'],
    \ }

"==============================================================================
" Auto Commands
"==============================================================================

" Show absolute line numbers in insert mode
autocmd InsertEnter * :set relativenumber!
autocmd InsertLeave * :set relativenumber

" Highlight lines with more than 120 characters
autocmd BufWinEnter * let w:m3=matchadd('ErrorMsg', '\%>120v.\+', -1)

" Disable whitespace at the end of comments
autocmd FileType * setlocal formatoptions-=w

" Always start at the top of a commit message
autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Make the line number margin slightly darker
" autocmd VimEnter * highlight LineNr ctermbg=233 guibg=#121212
" autocmd VimEnter * highlight CursorLineNr ctermbg=233 guibg=#121212

"==============================================================================
" Local Configurations
"==============================================================================

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
