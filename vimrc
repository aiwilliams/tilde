
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
set backspace=start,indent,eol                             " Allow delete across lines
set hlsearch
set number

set statusline=
set statusline+=%-3.3n\                                    " buffer number
set statusline+=%f\                                        " filename
set statusline+=%h%m%r%w                                   " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]               " file type
set statusline+=%=                                         " right align remainder
set statusline+=0x%-8B                                     " character value
set statusline+=%-14(%l,%c%V%)                             " line, character
set statusline+=%<%P                                       " file position

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

syntax enable                                              " Of course we want syntax highlighting!

if has("gui_running")
  set guioptions+=TlRLrb
  set guioptions-=TlRLrb
  set guifont=Monaco:h14
endif

colorscheme desert256

" =================
" :help filetype
" =================
filetype plugin indent on
autocmd BufRead,BufNewFile Capfile set filetype=ruby       " recognize Capfile
autocmd BufRead,BufNewFile Gemfile set filetype=ruby       " recognize Gemfile


" ==================
" Buffers
" ==================
set hidden                                                 " Leave buffers even when they're changed
au FocusLost * :wall                                       " Write all named, changed buffers when Vim loses focus

autocmd BufWritePre * :%s/\s\+$//e                         " strip trailing whitespace

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


" ==================
" NERDtree plugin
" ==================
map <leader>nt :NERDTree<space>
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>R :NERDTreeFind<CR>


" ==================
" Tags
"   See http://sites.google.com/site/daveparillo/software-development/vim/ctags
" ==================
" TODO Learn to use tags beyond the TlistToggle...
"set tags=./tags
"map <leader>gt :execute

" Taglist plugin
let Tlist_Show_One_File = 1
map <leader>S :TlistToggle<CR><C-W>h
let tlist_javascript_settings='javascript;v:globals;c:classes;f:functions;m:methods;p:properties;r:protoype'


" ==================
" FuzzyFinder plugin
" ==================

let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|swp|log|DS_Store|gdbinit)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|vendor|tmp|\.(sass-cache|gdb|bundle)'
let g:fuf_enumerating_limit = 70
let g:fuf_maxMenuWidth = 150
map <leader>b :FufBuffer<CR>
map <leader>t :FufFile<CR>
map <leader>q :FufQuickfix<CR>

" ---- Searching ----
nmap <leader>f :Ack<space>
nmap <leader>w :Ack<space><cword><CR>
vmap <leader>w "ry:Ack<space>"<C-r>r"<CR>
nmap <leader>rw :Ack<space>--type=ruby<space><cword><CR>

" Substitution
nmap <leader>r :%s/<C-r><C-w>/
vmap <leader>r "ry:%s/<C-r>r/

" Show trailing whitespace with ,s
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
