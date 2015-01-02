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
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-sleuth'

" Colors
Plugin 'godlygeek/csapprox'
Plugin 'morhetz/gruvbox'
Plugin 'chriskempson/base16-vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'vim-scripts/darkspectrum'

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
    set guicolors
endif

set background=dark
colorscheme gruvbox
autocmd BufReadPost * highlight Comment cterm=none

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
" set pastetoggle=<F12>           " Toggle paste mode

set directory^=~/.backup//      " Write swap files to ~/.backup

"==============================================================================
" Mappings
"==============================================================================

let mapleader="\<Space>"

" Prevent p from replacing the buffer (copy what was originally selected)
vnoremap p pgvy

" Make Y yank to end of line
nnoremap Y y$

" Preserve selection on indent
vnoremap < <gv
vnoremap > >gv

" Create a new tab
nnoremap <Tab><Enter> :tabedit<Space>

" Move to previous and next tabs
nnoremap <silent> [<Tab> :tabprev<CR>
nnoremap <silent> ]<Tab> :tabnext<CR>

" Move tabs left or right
nnoremap <silent> g{ :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> g} :execute 'silent! tabmove ' . tabpagenr()<CR>

" Yank to shared clipboard
noremap <silent> gy :w! ~/.clipboard<CR>:echo 'Selection written to ~/.clipboard'<CR>

" Align certain characters
noremap <silent> g<Space>= :Tabularize /=<CR>
noremap <silent> g<Space>> :Tabularize /=><CR>
noremap <silent> g<Space>: :Tabularize /:<CR>

" Toggle NERD Tree
nnoremap <silent> <Leader>nt :NERDTreeTabsToggle<CR>
nnoremap <silent> <Leader>nf :NERDTreeFind<CR>

" Easily open files from the same directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Git grep
function! GgrepPrompt()
    let q = input('Ggrep: ')
    if q == ""
        return
    endif
    execute 'silent Ggrep' q | cwindow
endfunction
map cog :call GgrepPrompt()<CR>

" Remove trailing spaces
nnoremap <silent> <Leader><Space> :%s/[ \t]*$//g<CR>:nohlsearch<CR>

" Show helpful messages for keys that have been remapped
map ,t :echo ',t was remapped to TabEnter'<CR>
map gr :echo 'gr and gt were remapped to [Tab and ]Tab'<CR>
map ,/ :echo ',/ was remapped to C-L'<CR>
map ,y :echo ',y was remapped to gy'<CR>
map ,s :echo ',s was remapped to cos'<CR>
map ,a= :echo ',a= was remapped to gSpace='<CR>
map ,a> :echo ',a> was remapped to gSpace>'<CR>
map ,a: :echo ',a: was remapped to gSpace:'<CR>

" Disable bad habits
noremap <silent> <Up> :echo 'Disabled!'<CR>
noremap <silent> <Down> :echo 'Disabled!'<CR>
noremap <silent> <Left> :echo 'Disabled!'<CR>
noremap <silent> <Right> :echo 'Disabled!'<CR>

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
endif

let g:syntastic_mode_map={
    \ 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [],
    \ }
let g:syntastic_always_populate_loc_list=1
let g:syntastic_quiet_messages={ 'type': 'style' }
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='!'

"==============================================================================
" Auto Commands
"==============================================================================

" Show absolute line numbers in insert mode
autocmd InsertEnter * set number norelativenumber
autocmd InsertLeave * set number relativenumber

" Highlight lines with more than 120 characters
autocmd BufWinEnter * let w:m3=matchadd('ErrorMsg', '\%>120v.\+', -1)

" Disable whitespace at the end of comments
autocmd FileType * setlocal formatoptions-=w

" Jump to the last cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Always start at the top of a commit message
autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

"==============================================================================
" Local Configurations
"==============================================================================

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
