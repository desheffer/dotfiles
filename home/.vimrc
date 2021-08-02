" Plugins {{{

set nocompatible
filetype off

call plug#begin()

Plug 'junegunn/vim-plug'

" General
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'enricobacis/paste.vim'
Plug 'junegunn/indentLine'
Plug 'terryma/vim-multiple-cursors'
Plug 'Lokaltog/vim-easymotion'
Plug 'bogado/file-line'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/ZoomWin'

" Appearance
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'

" Files
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-eunuch'

" Programming
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
Plug 'tomtom/tcomment_vim'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'godlygeek/tabular'
Plug 'PeterRincker/vim-argumentative'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

call plug#end()

" }}}
" General Settings {{{

set t_Co=256
set termguicolors
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
silent! colorscheme gruvbox

set clipboard=                  " Never use system clipboard.

set expandtab                   " Tab key inserts spaces.
set softtabstop=4               " Use 4 spaces for indentation.
set shiftwidth=4                " Use 4 spaces for indentation.
set nojoinspaces                " When joining lines, don't use double spaces.

set ignorecase                  " Default to case insensitive searches.
set smartcase                   " Unless uppercase letters are present.
set hlsearch                    " Highlight searches.
set incsearch                   " Search while typing.

set wrap                        " Wrap lines.
set scrolloff=3                 " Pad the cursor with 3 lines.
set scrolljump=5                " Scroll by 5 lines.
set number                      " Show line numbers.
set relativenumber              " Relative to the current line.
set colorcolumn=80              " Draw right margin at 80 characters.

set list                        " Enable hidden characters.
set listchars=tab:▷·            " Show tab characters.
set listchars+=trail:·          " Show trailing spaces.

set foldmethod=syntax           " Fold based on syntax highlighting items.

set wildmode=longest,list       " Make completion mode acts like Bash.

set splitbelow                  " New windows open below.
set splitright                  " New windows open right.

set showcmd                     " Show incomplete normal mode commands.
set noshowmode                  " Hide current mode.

set directory=~/.vim/swap//     " Where to write swap files.
set backupdir=~/.vim/backup     " Where to write backup files.

set undofile                    " Save undo history.
set undodir=~/.vim/undo         " Where to write undo history.

set visualbell t_vb=            " Be quiet.

" }}}
" Mappings {{{

let mapleader = '\'

" Disable ex mode.
nnoremap Q <Nop>

" Open and close tabs.
nnoremap <Tab><Enter> :tabedit<Space>
nnoremap <silent> <Tab>q ZQ<CR>

" Move to previous and next tabs.
nnoremap <silent> [<Tab> :tabprev<CR>
nnoremap <silent> ]<Tab> :tabnext<CR>

" Create window splits.
nnoremap <C-w>- :split<CR>
nnoremap <C-w>\| :vsplit<CR>

" Allow j and k to navigate wrapped lines.
nnoremap j gj
nnoremap k gk

" Make Y yank to end of line.
nnoremap Y y$

" Preserve selection on indent.
vnoremap < <gv
vnoremap > >gv

" Prevent p from replacing the buffer (copy what was originally selected).
vnoremap p pgvy

" Toggle fzf.
nnoremap <C-p> :call SmartFzfSearching()<CR>
nnoremap g<C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>l :BLines<CR>

" Toggle NERD Tree.
nnoremap <silent> <Leader>nt :NERDTreeTabsToggle<CR>
nnoremap <silent> <Leader>nf :NERDTreeFind<CR>

" Grep.
nnoremap <Leader>g :Ag!<Space>
nnoremap <silent> <Leader>a :Ag! <C-r><C-w><CR>
xnoremap <silent> <Leader>a y:Ag! <C-R>"<CR>

" Search for visually selected text.
vnoremap // y/<C-R>"<CR>

" Align delimiting characters.
vnoremap <silent> <Leader>a= :Tabularize /=<CR>
vnoremap <silent> <Leader>a> :Tabularize /=><CR>
vnoremap <silent> <Leader>a: :Tabularize /:<CR>

" Navigate merge conflicts.
nnoremap <silent> <Leader>mc /^(<<<<<<<\\|=======\\|>>>>>>>)<CR>

" Format JSON.
nnoremap <silent> <Leader>js :%!python -m json.tool<CR>

" Jump to definition.
nnoremap <Leader>d :call CocAction('jumpDefinition', 'tab drop')<CR>

" }}}
" Plugin Settings {{{

let g:airline_powerline_fonts = 1

let b:ale_fixers = ['trim_whitespace']
let g:ale_fix_on_save = 1

let g:coc_global_extensions = ["coc-git", "coc-go", "coc-html", "coc-java", "coc-json", "coc-omnisharp", "coc-phpls", "coc-pyright", "coc-rust-analyzer", "coc-sh", "coc-yaml"]

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_preview_window = ['up:60%', 'ctrl-o']

let g:gist_post_private = 1

let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

let g:nerdtree_tabs_open_on_gui_startup = 0

" }}}
" Functions {{{
function! s:get_git_root()
    if exists('*fugitive#repo')
        try
            return fugitive#repo().tree()
        catch
        endtry
    endif
    let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
    return v:shell_error ? '' : root
endfunction

function! SmartFzfSearching()
    let root = s:get_git_root()
    if empty(root)
        Files
    else
        GFiles
    endif
endfunction
" }}}
" Auto Commands {{{

augroup vimrc

" Clear existing commands in this group.
autocmd!

" Show absolute line numbers in insert mode.
autocmd InsertEnter * set number norelativenumber
autocmd InsertLeave * set number relativenumber

" Disable whitespace at the end of comments.
autocmd FileType * setlocal formatoptions-=w

" Jump to the last cursor position when opening a file.
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | exe "normal! g'\"" | endif

" Always start at the top of a commit message.
autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Automatically close quickfix window.
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix" | q | endif

augroup END

" }}}
" Local Configurations {{{

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" }}}
" vim: ft=vim foldlevel=0 foldmethod=marker
