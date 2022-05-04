" Plugins
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

" Theme
syntax on
colorscheme onedark

syntax enable
syntax on
filetype on
filetype plugin on
filetype plugin indent on
set termguicolors
set ttyfast " Improves smoothness of redrawing
set mouse=a " Enable mouse
set encoding=UTF-8
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set number " Show line number
set tabstop=4
set shiftwidth=4
set autoindent " Auto indent
set smartindent " Smart indent
set showtabline=2
set clipboard=unnamedplus " Use system clipboard
set cursorline " Highlight current line
set keymodel=startsel,stopsel " Mapping <Shift>-Arrows to selecting characters/lines
set signcolumn=yes
set nowrap
set splitbelow
set noswapfile
" Don't redraw while executing macros (good performance config)
set lazyredraw
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
" When joining lines, don't insert a space between two multi-byte characters
set formatoptions+=B
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab " Use spaces instead of tabs
" Use these symbols for invisible chars
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:»,precedes:«
set foldlevel=100 " unfold all by default
" the mouse pointer is hidden when characters are typed
set mousehide
" Always show current position
set ruler
" Turn spell check off
set nospell
" Height of the command bar
set cmdheight=1
" Turn on the Wild menu
set wildmenu
set wildmode=list:longest,full

set virtualedit=block

" Ignore compiled files
set wildignore=*.so,*.swp,*.pyc,*.pyo,*.exe,*.7z
if has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*,*\desktop.ini
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set sessionoptions-=options " Don't restore all options and mappings

" Restore last session automatically (default off)
if !exists('g:rc_restore_last_session') | let g:rc_restore_last_session = 0 | endif
" Always save the last session
augroup rc_save_session
    autocmd!
    autocmd VimLeave * exe ":mksession! ~/.vim/.last.session"
augroup END
" Try to restore last session
augroup rc_restore_session
    autocmd!
    autocmd VimEnter * call RCRestoreLastSession()
augroup END
function! RCRestoreLastSession()
    if g:rc_restore_last_session
        if filereadable(expand("~/.vim/.last.session"))
           exe ":source ~/.vim/.last.session"
       endif
   endif
endfunction
" Restore the last session manually
if filereadable(expand("~/.vim/.last.session"))
    nnoremap <silent> <Leader>r :source ~/.vim/.last.session<CR>
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" Visually select the text that was last edited/pasted
nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

" Set to auto read when a file is changed from the outside
set autoread

set updatetime=200

" Set how many lines of history VIM has to remember
set history=1000 " command line history

" Swap files are necessary when crash recovery
if !isdirectory($HOME . "/.vim/swapfiles") | call mkdir($HOME . "/.vim/swapfiles", "p") | endif
set dir=$HOME/.vim/swapfiles//

" For regular expressions turn magic on
set magic
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch

" Disable highlight when <Backspace> is pressed
nnoremap <silent> <BS> :nohlsearch<CR>

" A buffer becomes hidden when it is abandoned
set hidden

set splitright " Puts new vsplit windows to the right of the current
set splitbelow " Puts new split windows to the bottom of the current

" Always show status line
set laststatus=2
set statusline=%<%f\ " filename
set statusline+=%w%h%m%r " option
set statusline+=\ [%{&ff}]/%y " fileformat/filetype
set statusline+=\ [%{getcwd()}] " current dir
set statusline+=\ [%{&encoding}] " encoding
set statusline+=%=%-14.(%l/%L,%c%V%)\ %p%% " Right aligned file nav info

" Allow cursor show after last character
set ve+=onemore

function! MapBoth(keys, rhs)
    execute 'nmap' a:keys a:rhs
    execute 'imap' a:keys '<ESC><ESC>' . a:rhs
    execute 'vmap' a:keys '<ESC><ESC>' . a:rhs
    execute 'cmap' a:keys '<ESC><ESC>' . a:rhs
    execute 'tmap' a:keys '<LeftMouse>' . a:rhs
endfunction

call MapBoth('<C-z>', ':undo<CR>')
call MapBoth('<C-y>', ':redo<CR>')
call MapBoth('<A-Left>', ':tabprev<CR>')
call MapBoth('<A-Right>', ':tabnext<CR>')
call MapBoth('<C-n>', ':tabnew<CR>')
call MapBoth('<C-S-Up>', ':wincmd k<CR>')
call MapBoth('<C-S-Down>', ':wincmd j<CR>')
call MapBoth('<C-S-Left>', ':wincmd h<CR>')
call MapBoth('<C-S-Right>', ':wincmd l<CR>')
" Find
call MapBoth('<C-f>', '/')
" Create a new line
call MapBoth('<A-CR>', 'o')
" Exit tab | window
call MapBoth('<C-w>', ':q!<CR>')
" Fast jump
call MapBoth('<C-Up>', '5k')
call MapBoth('<C-Down>', '5j')
call MapBoth('<C-Left>', '10h')
call MapBoth('<C-Right>', '10l')
" Switch mode
call MapBoth('<C-\>', '<ESC><ESC>:') " Ctrl + \ to go to Command mode
imap <C-.> <C-o>
" Copy
call MapBoth('<C-c>', 'yy')
vmap <C-c> ygv
" Cut
call MapBoth('<C-x>', 'dd')
vmap <C-x> d
" Paste
call MapBoth('<C-v>', 'gP')
vmap <C-v> gP
" Select all
call MapBoth('<C-a>', 'ggVG$')
" Save
call MapBoth('<C-s>', ':w<CR>')
" Backspace
vmap <BS> "_d
nmap <BS> i<BS>
" Enter
nmap <CR> i<CR>
" Right indent
nmap <Tab> i<Tab>
vmap <Tab> >gv
" Left indent
call MapBoth('<S-Tab>', '<<')
vmap <S-Tab> <gv
" GoTo code navigation.
call MapBoth('<F12>', '<Plug>(coc-definition)')
" Formatting selected code.
call MapBoth('<leader>f', '<Plug>(coc-format-selected)')
" Outline
call MapBoth('<C-r>', ':CocList outline<cr>')
" Commentary
call MapBoth('<C-_>', 'gcc')
vmap <C-_> gcgv
" FZF
call MapBoth('<C-p>', ':FZF<CR>')
" Exit vim
call MapBoth('<C-d>', ':qa!<CR>')
" File explorer
call MapBoth('<C-b>', "<Cmd>CocCommand explorer<CR>")

" Move out of selected text behavior
vmap <Left> <ESC>`<<Left>
vmap <Up> <ESC>`<<Up>
vmap <Right> <ESC>`><Right>
vmap <Down> <ESC>`><Down>

" Ctrl + P
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](node_modules|build|public|lib|dist)|(\.(git|svn))$',
    \ 'file': 'tags\|tags.lock\|tags.temp',
\ }

" Lightline
let g:lightline = {}
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]] }
let g:lightline.active = {
            \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
            \            [ 'lineinfo' ],
      		\            [ 'percent' ],
			\            [ 'fileformat', 'fileencoding', 'filetype'] ]
			\ }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

" Outline
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
let g:vista_update_on_text_changed=1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Golang support
" Add missing imports on save
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
" Format go file on save
autocmd BufWritePre *.go :silent call CocAction('format')

