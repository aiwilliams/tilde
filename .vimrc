
"call pathogen#helptags() " regenerate helptags
call pathogen#runtime_append_all_bundles()                 " Thank you, T. Pope!

set nocompatible                                           " We aren't interested in backward compatability with vi, set before all other
set history=1000                                           " Lots of command line history
set autoindent
set autowrite
set expandtab                                              " Expand tabs to spaces
set shiftwidth=2
set tabstop=2
set smarttab
set wildmode=list:longest                                  " Helpful tab completion
set wcm=<Tab>                                              " :h wildcharm
set backspace=start,indent,eol                             " Allow delete across lines
set nowrap                                                 " Don't wrap lines longer than window width

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" ====================
" User Interface
" ====================
set hlsearch                                               " I like highlighted searches
set number                                                 " Show line numbers on the left

set laststatus=2                                           " always show status line

set statusline=
set statusline+=%-3.3n\                                    " buffer number
set statusline+=%f\                                        " filename
set statusline+=%h%m%r%w                                   " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]               " file type
set statusline+=%=                                         " right align remainder
set statusline+=0x%-8B                                     " character value
set statusline+=%-14(%l,%c%V%)                             " line, character
set statusline+=%<%P                                       " file position

if has("gui_running")
  set guioptions+=TlRLrb
  set guioptions-=TlRLrb
  set guifont=Monaco:h14
endif

colorscheme desert256
syntax enable                                              " Of course we want syntax highlighting!
highlight LineNr guifg=#383838                             " Lighten up the line numbers

" =================
" :help filetype
" =================
filetype plugin indent on
autocmd BufRead,BufNewFile Capfile set filetype=ruby       " recognize Capfile
autocmd BufRead,BufNewFile Gemfile set filetype=ruby       " recognize Gemfile
autocmd BufRead,BufNewFile *.jst set filetype=html


" ==================
" Buffers
" ==================
set hidden                                                 " Leave buffers even when they're changed

autocmd BufReadPost *                                      " Restore cursor position
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

if v:version >= 703                                        " Persistent UNDO, only available in Vim 7.3 or greater
  set undofile
  set undodir=~/.vim/.undo
endif


" ==================
" Mappings
" ==================
let mapleader = ","                                        " A way to make command mapping shorter; see <leader> throughout this
imap ;; <Esc>

" insert line above/below
nnoremap <D-CR> o<ESC>
nnoremap <D-S-CR> O<ESC>
inoremap <D-S-CR> <ESC>O
nnoremap <leader><space> i<space><ESC>

" move between windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" resize windows
nmap <C-Left> <C-W><<C-W><
nmap <C-Right> <C-W>><C-W>>
nmap <C-Up> <C-W>+<C-W>+
nmap <C-Down> <C-W>-<C-W>-

nnoremap <leader>b :b<space><Tab>

" gundo - an undo tree browser
nnoremap <F5> :GundoToggle<CR>

" edit vimrc
nmap <leader>v :sp $MYVIMRC<CR><C-W>_
nmap <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR><leader>d<leader>d<C-L>

" command-t
silent! nmap <unique> <silent> <Leader>f :CommandT<CR>
nnoremap <leader>F :CommandTFlush<CR>:CommandT<CR>
set wildignore+=public/assets/**,build/**,vendor/plugins/**,vendor/linked_gems/**,vendor/gems/**,vendor/rails/**,vendor/ruby/**,vendor/cache/**,Libraries/**,coverage/**
let g:CommandTMaxHeight=20
let g:CommandTMatchWindowAtTop=0

" NERDtree
let NERDTreeWinSize=31
map <leader>nt :NERDTree<space>
map <leader>nb :NERDTreeFromBookmark<space>
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>R :NERDTreeFind<CR>

" Rails
nnoremap <leader><leader>c :Rcontroller<space>
nnoremap <leader><leader>m :Rmodel<space>
nnoremap <leader><leader>a :Rmailer<space>
nnoremap <leader><leader>v :Rview<space>
nnoremap <leader><leader>h :Rhelper<space>
nnoremap <leader><leader>i :Rinitializer<space>
nnoremap <leader><leader>e :Renvironment<space>
nnoremap <leader><leader>l :Rlib<space>
nnoremap <leader><leader>f :Rfeature<space>
nnoremap <leader><leader>u :Runittest<space>
nnoremap <leader><leader>j :Rjavascript<space>
nnoremap <leader><leader>t :Rtask<space>
nnoremap <leader><leader>r :Rspec<space>

nnoremap <leader>h :FixWhitespace<CR>

" ==================
" Tags
"   See http://sites.google.com/site/daveparillo/software-development/vim/ctags
"   
"   :!ctags -R  // recursively generate tags for every known file type
" ==================
" TODO Learn to use tags beyond the TlistToggle...
"set tags=./tags
"map <leader>gt :execute

" Taglist plugin
let Tlist_Show_One_File = 1
map <leader>S :TlistToggle<CR>
let tlist_javascript_settings='javascript;v:globals;c:classes;f:functions;m:methods;p:properties;r:protoype'


" ---- Searching ----
set incsearch                                           " Incremental searching with /
nnoremap <leader>A :Ack<cword><CR>
nnoremap <leader>a :Ack<Space>
nnoremap <leader>rw :Ack<space>--type=ruby<space><cword><CR>
vmap <leader>A "ry:Ack<space>"<C-r>r"<CR>

" Substitution
nmap <leader>r :%s/<C-r><C-w>/
vmap <leader>r "ry:%s/<C-r>r/

" Show trailing whitespace with ,s
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
