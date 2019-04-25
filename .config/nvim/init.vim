"*****************************************************************************
" Plug
"*****************************************************************************
let vimplug_exists=expand('~/.local/share/nvim/site/autoload/plug.vim')
if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug...\n"
  silent exec "!\curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

"*****************************************************************************
" Plugins
"*****************************************************************************
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
Plug 'christoomey/vim-tmux-navigator'

" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()

"*****************************************************************************
" Basic Setup
"*****************************************************************************
set nocompatible  " vim not vi

let mapleader="\<Space>" " Map leader to <Space>

filetype plugin indent on " Load plugins according to detected filetype
syntax on                 " Enable syntax highligting
set encoding=utf-8        " default encoding
set mouse=a               " use the mouse
set spell                 " enable spell check
set spelllang=en_us

set autoindent                  " Indent according to previous line
set expandtab                   " Use spaces instead of tabs
set softtabstop=2               " Tab key indents by 2 spaces
set shiftwidth=2                " >> indents by 2 spaces
set shiftround                  " >> indents by multiple of shiftwidth
set backspace=indent,eol,start  " Make backspace work properly

set hidden            " switch between buffers without saving
set laststatus=2      " always show status
set display=lastline  " Display as much as possible of the last line

set showmode  " show current mode in command-line
set showcmd   " show typed keys when more are expected

set incsearch " highight while searching with / or  ?.
set hlsearch  " keep matches highlighted
set smartcase " lowercase searches are case insensitive

set lazyredraw " only redraw when necessary

set splitbelow " open new windows below
set splitright " open new windows right

set cursorline    " find current line quickly
set wrapscan      " search wraps around EOF
set report=0      " always report number of lines changed
set synmaxcol=300 " only highlight the first 300 columns

set noswapfile " dont use swapfile
set nobackup   " no backup files
set nowritebackup

set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git

"*****************************************************************************
" Visual Settings
"*****************************************************************************

silent! colorscheme gruvbox
set termguicolors

set relativenumber " relative line numbers
set number         " also show current absolute line number

set colorcolumn=100 " add ruler at column 100
set tw=100          " break at ruler with gqq

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'gruvbox'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1

"*****************************************************************************
" Bindings
"*****************************************************************************
" Save
noremap <leader>s :w<CR>

" Tab
inoremap <S-Tab> <C-d>

" Spell
nmap <silent> <leader>z :set spell!<CR>

" Split
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>

" Git
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gsh :Gpush<CR>
nnoremap <leader>gll :Gpull<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gr :Gremove<CR>
nnoremap <leader>o :.Gbrowse<CR>

" Jump to start or end of line with home row keys
map H ^
map L $

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Clipboard copy/paste
noremap <leader>y "+Y<CR>
noremap <leader>p "+gP<CR>
noremap <leader>x "+X<CR>

" Buffer nav
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Close buffer
noremap <leader>q :bd<CR>
noremap <leader>Q :q<CR>

" Clear search (highlight)
nnoremap <silent> <leader>/ :noh<cr>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" fzf
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :Files<CR>
nnoremap <silent> <leader>f :BLines<CR>
nnoremap <silent> <leader>' :History<CR>
nnoremap <silent> <leader>F :Rg 

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

"*****************************************************************************
" Plugin Settings
"*****************************************************************************

" fzf.vim with ripgrep
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Add preview to Rg search
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', 'ctrl-p'),
  \   <bang>0)

" Add preview to Files search
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" ale
let g:ale_linters = {"rust": ['rls']}

" markdown
let g:markdown_fenced_languages = ['cpp']
let g:markdown_minlines = 300

" airline
let g:airline_powerline_fonts = 1

