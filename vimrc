"==============================================================================
" Plugins
"==============================================================================

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" General
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'

" Colors
Plugin 'godlygeek/csapprox'
Plugin 'chriskempson/base16-vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'vim-scripts/darkspectrum'
Plugin 'dsolstad/vim-wombat256i'

" Status
Plugin 'bling/vim-airline'

" Files and directories
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'

" Error checking
Plugin 'scrooloose/syntastic'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Formatting
Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'

" Movement
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Lokaltog/vim-easymotion'

call vundle#end()

"==============================================================================
" Environment Settings
"==============================================================================

" Set up colors for the current environment
set t_Co=256
if has('termtruecolor')
    let &t_8f="\033[38;2;%ld;%ld;%ldm"
    let &t_8b="\033[48;2;%ld;%ld;%ldm"
endif

" Set color scheme for the current environment
if has('gui_running')
    set background=dark
    colorscheme base16-monokai
elseif has('termtruecolor')
    set guicolors
    set background=dark
    colorscheme base16-monokai
else
    colorscheme hybrid
endif

set guifont=Meslo_LG_S_Regular_for_Powerline:h12

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

set nofoldenable                " Disable folding by default
set foldmethod=syntax           " But allow it to be enabled easily

set wildmode=longest,list       " Make completion mode acts like Bash

set showcmd                     " Show incomplete normal mode commands
set noshowmode                  " Hide current mode
set pastetoggle=<F12>           " Toggle paste mode

set directory^=~/.backup//      " Write swap files to ~/.backup

"==============================================================================
" Mappings
"==============================================================================

let mapleader=','

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
nnoremap <Leader>nt :NERDTreeTabsToggle<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>

" Easily open files from the same directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Disable bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"==============================================================================
" Plugin Settings
"==============================================================================

let g:nerdtree_tabs_open_on_gui_startup=0

let g:ctrlp_custom_ignore={
    \ 'dir': '\.git$\|vendor\|tmp\|Proxy\|Proxies',
    \ 'file': '',
    \ }

let g:ctrlp_prompt_mappings={
    \ 'AcceptSelection("e")': ['<C-t>'],
    \ 'AcceptSelection("t")': ['<CR>', '<2-LeftMouse>'],
    \ }

if !has('termtruecolor')
    let g:airline_powerline_fonts=1
    let g:airline_theme='tomorrow'
endif

let g:syntastic_mode_map={
    \ 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [],
    \ }
let g:syntastic_quiet_messages={ 'type': 'style' }
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='!'

"==============================================================================
" Auto Commands
"==============================================================================

" Show absolute line numbers in insert mode
autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber

" Highlight lines with more than 120 characters
autocmd BufWinEnter * let w:m3=matchadd('ErrorMsg', '\%>120v.\+', -1)

" Disable whitespace at the end of comments
autocmd FileType * setlocal formatoptions-=w

" Jump to the last cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Always start at the top of a commit message
autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

"==============================================================================
" Local Configurations
"==============================================================================

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
