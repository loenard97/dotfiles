" VIM CONFIG

" Partial credit to: https://builtin.com/software-engineering-perspectives/neovim-configuration
syntax on                       " syntax highlighting
filetype plugin on
filetype plugin indent on       " allow auto-indenting depending on file type
set number
set relativenumber
set nocompatible                " disable compatibility to old-time vi
set showmatch                   " show matching 
set ignorecase                  " case insensitive 
set mouse=v                     " middle-click paste with 
set hlsearch                    " highlight search 
set incsearch                   " incremental search
set tabstop=4                   " number of columns occupied by a tab 
set softtabstop=4               " see multiple spaces as tabstops so <BS> does the right thing
set expandtab                   " converts tabs to white space
set shiftwidth=4                " width for autoindents
set autoindent                  " indent a new line the same amount as the line just typed
set number                      " add line numbers
set wildmode=longest,list       " get bash-like tab completions
set mouse=a                     " enable mouse click
set clipboard=unnamedplus       " using system clipboard
set ttyfast                     " Speed up scrolling in Vim
set scrolloff=999               " keep cursor centered
set list                        " draw tabs as line
set listchars=tab:──
" set cc=80                     " set an 80 column border for good coding style
" set spell                     " enable spell check (may need to download language package)
" set cursorline                " highlight current cursorline
" set noswapfile                " disable creating swap file
" set backupdir=~/.cache/vim    " Directory to store backup files.

" Exit insert mode
:inoremap öö <Esc>
:vnoremap öö <Esc>

" Cursor settings
" 1 -> blinking block
" 2 -> solid block 
" 3 -> blinking underscore
" 4 -> solid underscore
" 5 -> blinking vertical bar
" 6 -> solid vertical bar
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
" :autocmd InsertEnter * set cursorline
" :autocmd InsertLeave * set nocursorline

" Move line or visually selected block - contorl+j/k
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" move split panes to left/bottom/top/right
" nnoremap <A-h> <C-W>H
" nnoremap <A-j> <C-W>J
" nnoremap <A-k> <C-W>K
" nnoremap <A-l> <C-W>L
" move between panes to left/bottom/top/right
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Autosave
augroup autosave
    autocmd!
    autocmd BufRead * if &filetype == "" | setlocal ft=text | endif
    autocmd FileType * autocmd TextChanged,InsertLeave <buffer> if &readonly == 0 | silent write | endif
augroup END
