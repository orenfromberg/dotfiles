" Install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'ayu-theme/ayu-vim'
Plug 'cespare/vim-toml'
Plug 'chr4/nginx.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'modille/groovy.vim'
Plug 'myitcv/govim'
Plug 'plasticboy/vim-markdown'
Plug 'stephpy/vim-yaml'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'

" Initialize plugin system
call plug#end()

" Setup colors
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

" ALE
" Only run what I specifically ask for
let g:ale_linters_explicit = 1

let g:ale_fixers = {
            \   'javascript': ['prettier'],
            \   'python': ['black'],
            \ }

let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" Statusline
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline_section_a = ''
let g:airline_section_b = '%{FugitiveHead()}'
let g:airline_section_c = '%m%r'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = '%l:%c'

"Vim-Rooter
let g:rooter_silent_chdir = 1

" GitGutter
if exists('&signcolumn')
    set signcolumn=yes
else
    let g:gitgutter_sign_column_always = 1
endif
" Markdown
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
"Prevent setting conceal
let g:vim_json_syntax_conceal = 0

" Terraform
" Prevent fmt on save since ale does it
let g:terraform_fmt_on_save=1

"""""
" Key bindings
"""""

" change the leader key from "\" to the space bar
let mapleader="\<SPACE>"

" Alternate ways to exit insert mode
inoremap <M-CR> <Esc>
inoremap jk <Esc>

" Quick way out of all buffers when using merge tool
nnoremap <leader>q :qa<CR>
" Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>
" Shortcut to source (reload) THIS configuration file after editing it: (s)ource (c)onfiguraiton
nnoremap <silent> <leader>rc :source $MYVIMRC<CR>
" Move between buffers
nnoremap <silent> <leader><leader> :bprevious<CR>
nnoremap <silent> <leader><CR> :bn<CR>
" Close current buffer
nnoremap <silent> <leader>w :bd<cr>
" Searching
nnoremap <silent> <leader>c :nohlsearch<CR>
nnoremap <leader>s :%s//g<Left><Left>
" Search and replace over all files in quickfix, e.g., from RipGrep
nnoremap <leader>sg :cfdo %s///g <bar> update<C-Left><C-Left><C-Left><Right><Right><Right>
" Copy/paste to clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
" Disable arrow keys in normal mode
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
" Disable q from starting macro mode
nnoremap q <nop>
" Easier movement between splits
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
" File selection
nnoremap <silent> <leader>e :Explore<cr>
" Enter blank lines
nnoremap <silent> <leader>o o<ESC>k
nnoremap <silent> <leader>O O<ESC>j

" Use ripgrep to search
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
command! -nargs=+ RipGrep execute 'silent grep! <args>' | copen 12
nnoremap <leader>g :RipGrep<space>

""""
" Spellcheck
" [s and ]s to move forward and back. z= for suggestions
""""
function! ToggleSpellCheck()
  setlocal spell! spelllang=en_us 
  if &syntax !=# 'OFF' && &spell
      setlocal syntax=OFF
  else
      syntax enable
  endif
endfunction
nnoremap <silent> <leader>sc :call ToggleSpellCheck()<CR> 

""""
" General settings
" hat tips to tpope/vim-sensible
" http://nerditya.com/code/guide-to-neovim/
"""""
set encoding=utf-8

" No numbers by default toggle on relative for easy line selection
set nonumber
nnoremap <silent> <leader>n :set relativenumber!<CR>

set hlsearch
set incsearch
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set showmatch

set nrformats-=octal

set laststatus=2
set ruler
set wildmenu

" searching
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters
set gdefault            " Use 'g' flag by default with :s/foo/bar/

" Scrolling display
if !&scrolloff
    set scrolloff=1
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set display+=lastline


if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Joining
set formatoptions+=j " Delete comment character when joining commented lines
" set formatoptions+=o " Continue comment marker in new lines

if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread

set history=1000
set tabpagemax=50

if !empty(&viminfo)
    set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
endif
" Prevent creation of .netrwhist files
let g:netrw_dirhistmax = 0
let g:netrw_liststyle = 3
let g:netrw_banner = 0

set nobackup
set nowritebackup
" Put all swap files in one place
set directory^=$HOME/.vim/tmp//

" Set default indent to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Short updatetime time for govim are more responsive for quickfixlist
set updatetime=500
