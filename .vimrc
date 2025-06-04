" this one is not really maintained.

set nocompatible
let mapleader = "+"
let maplocalleader = "-"
" spelling off
set nospell
" Helps force plug-ins to load correctly when it is turned back on below.
filetype off
" Turn on syntax highlighting.
syntax on
" For plug-ins to load correctly.
filetype plugin indent on
"" General
set number	" Show line numbers
" Automatically wrap text that extends beyond the screen length.
"set virtualedit=onemore
set wrap
set relativenumber " set relative numbers " set relative numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+ 	" Wrap-broken line prefix
set textwidth=79 " Line wrap (number of cols)
"set colorcolumn=+2
set showmatch	" Highlight matching brace
set visualbell	" Use visual bell (no beeping)
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Vim's auto indentation feature does not work properly with text copied from outisde of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>
" Speed up scrolling in Vim
set ttyfast
" Status bar
set laststatus=2
" Display options
set showmode
" Encoding
set encoding=utf-8
" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

"" gruvbox
"set t_Co=256
"set background=dark
"let g:gruvbox_contrast_dark='hard'
"" disable italics because of gruvbox
"let g:gruvbox_italic=0
"" colorscheme
"let g:gruvbox_hls_cursor="blue"
"" for limelight plugin
"let g:limelight_conceal_ctermfg = 'gray'
"color gruvbox
"highlight Normal ctermbg=NONE
"highlight nonText ctermbg=NONE
"" plugins, just add it like this (it's from github): contributor/packageorwhateveritis
"" reload: `:source ~/.vimrc` and `:PlugInstall`
"" update plugins: `:PlugUpdate`
"" remove plugins: delete or comment out Plug commands for the plugins you want to remove and:
"" reload: `:source ~/.vimrc` and `:PlugClean` 
call plug#begin('~/.vim/autoload')
Plug 'morhetz/gruvbox'
" fuzzy find, installed with git, enabling here
Plug '~/.fzf'
"Plug 'junegunn/fzf/blob/master/plugin/fzf.vim'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" status bar
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" work with surrounding brackets, eg. change them
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
" in practice: no more messages because of .swp file
Plug 'gioele/vim-autoswap'
Plug 'godlygeek/tabular'

" Plug 'junegunn/goyo.vim'
" this works with goyo
" Plug 'junegunn/limelight.vim'
" tells if you're using same word too often
" Plug 'dbmrq/vim-ditto'
" LaTeX support
" Plug 'xuhdev/vim-latex-live-preview'

call plug#end()

" vimballs:
" download a vimball somewhere (prefer ~/.vim)
" vim something.vba
" `:so %` (source)
" `:VimballList`
" `:RmVimball vimballfile [path]`

" for vim markdown
let g:vim_markdown_new_list_item_indent = 4 

" source shortcut
:nnoremap <leader>sv :source $MYVIMRC<cr>

" enable fzf
set rtp+=~/.fzf

""" search
" this not wanted because it highlights all previous searches when sourcing vimrc
"set hlsearch	" Highlight all search results
set cursorline 
highlight Cursor guifg=green guibg=red 
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"" highlight cursor when searchigh
"highlight CurSearch guibg=green
"nnoremap <silent> N N:silent! call HighlightCurrentMatch()<CR>
"nnoremap <silent> n n:silent! call HighlightCurrentMatch()<CR>

nnoremap <f3> :set hlsearch!<CR>
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
 
set autoindent	" Auto-indent new lines
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
 
"" Advanced
set ruler	" Show row and column ruler information
 
set autowriteall	" Auto-write all file changes
set backupdir=~/.vim/vim_backups	" Backup directories
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

" tab and shift-tab to switch between buffers
nnoremap  <silent> <Left> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <Right> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

nnoremap <C-S> :update<cr>
inoremap <C-S> <Esc>:update<cr>gi

" clear autocommands to avoid duplicates
autocmd!
"" python
" python PEP8 intendation
" This will give you the standard four spaces when you hit tab, 
" ensure your line length doesn’t go beyond 80 characters, and 
" store the file in a Unix format so you don’t get a bunch of conversion issues when checking into GitHub and/or sharing with other users.
" au BufNewFile,BufRead *.py
"     \ set tabstop=4
"     \ set softtabstop=4
"     \ set shiftwidth=4
"     \ set textwidth=79
"     \ set expandtab
"     \ set autoindent
"     \ set fileformat=unix

augroup filetype_python
    au FileType python :iabbrev <buffer> iff if:<left>
    au FileType python :iabbrev <buffer> fori for i in:<left>
    au FileType python :iabbrev <buffer> pri print()<left>
    au FileType python nnoremap <buffer> <localleader>c ma0i#<esc>`a
    au FileType python nnoremap <buffer> <localleader>m ma0<c-V>]<s-I>#<esc>`a
    au FileType python nnoremap <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
augroup END

" For full stack development, you can use another au command for each filetype:
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

augroup tex
    au FileType tex :iabbrev <buffer> cite <left>~\cite{}<left>
    au FileType tex :iabbrev <buffer> ref <left>~\ref{}<left>
    au FileType tex :iabbrev <buffer> textit \textit{``''}<left><left><left>
    au FileType tex :iabbrev <buffer> emph \emph{}<left>
    au FileType tex nnoremap <buffer> <localleader>j vipJ<esc>Aa<bs><esc>
    au FileType tex nnoremap <buffer> <localleader>J vipJ<esc>
augroup END

" auto-complete
" The first line ensures that the auto-complete window goes away when you’re done with it, and 
" the second defines a shortcut for goto definition.
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" makes code look pretty
let python_highlight_all=1
syntax on

" remap esc
inoremap kj <esc>
vnoremap kj <esc>
" after learning the mapping, you can remove the line below
"inoremap <esc> <nop>

" copy paste remap
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d

"" spelling correction
" CTRL+L replaces with the first suggestion 1z=
"set spell 
"set spelllang=en_us
"inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" count eg 1+2+3 with bc
map gbc yypkA =<Esc>jOscale=2<Esc>:.,+1!bc<CR>kJ
" multiple lines in visual mode
vmap gc y'>p:'[,']-1s/$/+/\|'[,']+1j!<CR>'[0"wy$:.s§.*§\=w§<CR>'[yyP:.s/./=/g<CR>_j
