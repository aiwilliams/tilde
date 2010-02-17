" I have many people to thank, including, but not limited to:
"
"   http://github.com/matthewtodd/dotfiles
"   http://github.com/jtimberman/dotvim
"   http://github.com/tpope


" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" use subdirectories under ~/.vim/bundle
"
" Pathogen also provides :call pathogen#helptags() to regenerate helptags for
" each of the bundled plugins as needed
"
" Note that the runtimepath must be set *before* calling filetype plugin on if
" filetypes are to be recognized by plugins
call pathogen#runtime_append_all_bundles()

filetype plugin on

let mapleader = ","
imap ;; <Esc>

set autoindent
set autowrite
set expandtab " expand tabs to spaces
set shiftwidth=2
set tabstop=2
set smarttab
set wildmode=list:longest " helpful tab completion
set backspace=start,indent,eol " allow delete across lines
set hlsearch
set number
set history=1000

syntax enable

" strip trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" recognize Capfile, Gemfile
autocmd BufRead,BufNewFile Capfile set filetype=ruby
autocmd BufRead,BufNewFile Gemfile set filetype=ruby

" Tree on specified directory/bookmark
map <leader>nt :NERDTree<space>

" Open tree on current directory
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" Reveal current file in tree
map <leader>R :NERDTreeFind<CR>

" Set options if a gui is running
if has("gui_running")
  set guioptions+=TlRLrb
  set guioptions-=TlRLrb
endif

colorscheme desert256

set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position


" ---- Opening Files ----
let g:fuzzy_ignore = "vendor/**/*,tmp/**/*,*.log"
let g:fuzzy_matching_limit = 70
map <leader>b :FufBuffer<CR>
map <leader>t :FufFile<CR>
map <leader>q :FufQuickfix<CR>

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" ---- Searching ----
nmap <leader>f :Ack<space>
nmap <leader>w :Ack<space><cword><CR>
nmap <leader>rw :Ack<space>--type=ruby<space><cword><CR>

" ---- Editing ----

" Show trailing whitespace with ,s
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>


" ---- Running rake ----
map <leader>r :Rake<CR>
map <leader>R :.Rake<CR>
