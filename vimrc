filetype off                      "necessary on some Linux distros for pathogen to properly load bundles

call pathogen#runtime_append_all_bundles() "load pathogen managed plugins
call pathogen#helptags()

set nocompatible                  " Must come first because it changes other options.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set showmatch                     " Show matching brackets/parenthesis

set incsearch                     " Find as you type search
set hlsearch                      " Highlight search terms
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set foldmethod=indent             "fold based on indent
set foldnestmax=3                 "deepest fold is 3 levels
set nofoldenable                  "dont fold by default

set backspace=indent,eol,start    " Intuitive backspacing.
set hidden                        " Handle multiple buffers better.
set title                         " Set the terminal's title
set number                        " Show line numbers.
set showbreak=...
set ruler                         " Show cursor position.
set wrap                          " Turn on line wrapping.
set wildmode=list:longest         " Complete files like a shell.
set wildmenu                      " Enhanced command line completion.
set wildignore=*.o,*.obj,*~       "stuff to ignore when tab completing
set novisualbell
set noerrorbells
set history=1000                  " Store lots of :cmdline history

set scrolloff=3
set sidescrolloff=7
set sidescroll=1

if has("mouse")
  set mouse=a
endif
set mousehide
set ttymouse=xterm2

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=/tmp                " Keep swap files in one location
set timeoutlen=500

set tabstop=2                     " Global tab width.
set shiftwidth=2                  " And again, related.
set smarttab
set autoindent
set expandtab                     " Use spaces instead of tabs

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

filetype plugin on
filetype indent on                " Turn on file type detection.
syntax on
colorscheme vividchalk
set background=dark

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

"================ Mapping ===================
let mapleader = ","

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" Tab
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Fuzzy Search
"map <leader>f :FuzzyFinderTextMate<Enter>
map <leader>F :FuzzyFinderFile<Enter>
map <leader>d :FuzzyFinderFileWithCurrentBufferDir<Enter>
map <leader>f :FufBuffer<Enter>

" BufExplorer
map <leader>b :BufExplorer<cr>

" NERDTree
silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
nnoremap <silent> <C-f> :call FindInNERDTree()<CR> 

" map to CommandT TextMate style finder
nnoremap <leader>c :CommandT<CR>

"Key mapping for textmate-like indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

"=================== Plugin =====================

"Command-T
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

let g:fuzzy_matching_limit=200
let g:fuzzy_ceiling=10000
let g:fuzzy_ignore="teamsite;tags;*.log;*.jpg;*.gif;*.png;.git/**/*;.svn;.svn/**/*;"

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction
