set nocompatible                  " Must come first because it changes other options.
filetype off                      " Necessary on some Linux distros for pathogen to properly load bundles

" *********************************************
" *          Vundle - Vim Plugins             *
" *********************************************
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/IndexedSearch'
Plugin 'vim-scripts/L9.git'
Plugin 'vim-scripts/matchit.zip'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-dispatch'
Plugin 'thoughtbot/vim-rspec'
" Plugin 'janko-m/vim-test'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'git://gist.github.com/287147.git'
Plugin 'ngmy/vim-rubocop'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'othree/html5.vim'
Plugin 'mattn/emmet-vim'
Plugin 'fatih/vim-go'
Plugin 'slim-template/vim-slim'
Plugin 'bogado/file-line'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'milkypostman/vim-togglelist'
Plugin 'mxw/vim-jsx'
Plugin 'elixir-lang/vim-elixir'
Plugin 'wesQ3/vim-windowswap'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
syntax enable
filetype plugin indent on         " load file type plugins + indentation

" *********************************************
" *                 Settings                  *
" *********************************************
set encoding=utf-8

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set showmatch                     " Show matching brackets/parenthesis

set nowrap                        " don't wrap lines
set tabstop=2 shiftwidth=2        " a tab is two spaces (or set this to 4)
set expandtab                     " use spaces, not tabs (optional)
set backspace=indent,eol,start    " backspace through everything in insert mode"
set autoindent                    " match indentation of previous line
set pastetoggle=<F2>

set incsearch                     " Find as you type search
set hlsearch                      " Highlight search terms
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set foldmethod=syntax             "fold based on indent
set foldnestmax=3                 "deepest fold is 3 levels
set nofoldenable                  "dont fold by default

set hidden                        " Handle multiple buffers better.
set title                         " Set the terminal's title
set number                        " Show line numbers.
set ruler                         " Show cursor position.
set cursorline                    " Highlight current line
set colorcolumn=81
set list listchars=tab:»·,trail:· " Display extra whitespace
set wildmode=list:longest         " Complete files like a shell.
set wildmenu                      " Enhanced command line completion.
set wildignore=*.o,*.obj,*~       " Stuff to ignore when tab completing
set novisualbell
set noerrorbells
set history=1000                  " Store lots of :cmdline history

set scrolloff=3
set sidescrolloff=7

set splitbelow
set splitright

set mouse-=a
set mousehide
set ttymouse=xterm2
set sidescroll=1

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=/tmp                " Keep swap files in one location
set timeoutlen=500

set laststatus=2                  " Show the status line all the time
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set autowrite

set t_Co=256                      " Set terminal to 256 colors
set background=dark
colorscheme solarized

autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.thor set filetype=ruby

autocmd Filetype gitcommit setlocal spell textwidth=72

" Allow stylesheets to autocomplete hyphenated words
autocmd FileType css,scss,sass setlocal iskeyword+=-

" *********************************************
" *                 Functions                 *
" *********************************************

" Find Cucumber's unused steps
command! CucumberFindUnusedSteps :call CucumberFindUnusedSteps()
function! CucumberFindUnusedSteps()
  let olderrorformat = &l:errorformat
  try
    set errorformat=%m#\ %f:%l
    cexpr system('bundle exec cucumber --no-profile --no-color --format usage --dry-run features \| grep "NOT MATCHED BY ANY STEPS" -B1 \| egrep -v "(--\|NOT MATCHED BY ANY STEPS)"')
    cwindow
  finally
    let &l:errorformat = olderrorformat
  endtry
endfunction

" Ack current word in command mode
function! AckGrep(word)
  if empty(a:word)
    let word = expand("<cword>")
  else
    let word = a:word
  endif

  cgetexpr system("ag --search-files ".word)
  cw
endfunction

function! AckVisual()
  normal gv"xy

  let escape_chars = ['(', ')']
  for char in escape_chars
    let @x = escape(@x, char)
  endfor

  call AckGrep(shellescape(@x))
endfunction

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

""" FocusMode
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set noruler
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0
  else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    execute 'colorscheme ' . g:colors_name
  endif
endfunc

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Automatically set paste mode in Vim when pasting in insert mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()


" Automatically create non existing directories
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" *********************************************
" *               Key Bindings                *
" *********************************************
let mapleader = ","

" Toggle Folding
nnoremap <leader>f za

" Clear last search highlighting
nnoremap <Space> :noh<cr>

" Easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Open the definition in a new split
nnoremap <c-\> <c-w>g<c-]>

" Insert blank lines without going into insert mode
nmap go o<esc>
nmap gO O<esc>

" Shortcut for =>
imap <C-l> <Space>=><Space>

" Convert old hash to new Ruby 1.9 syntax
map <leader>: :%s/:\(\w\+\)\(\s*=>\s*\)/\1: /gc<CR>

" indent/unindent visual mode selection with tab/shift+tab
vmap <tab> >gv
vmap <s-tab> <gv

" F7 reformats the whole file and leaves you where you were (unlike gg)
map <silent> <F7> mzgg=G'z :delmarks z<CR>:echo "Reformatted."<CR>

" open files in directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" rename current file
map <leader>n :call RenameFile()<cr>

" AckGrep current word
map <leader>a :call AckGrep('')<CR>
" AckVisual current selection
vmap <leader>a :call AckVisual()<CR>
command! -nargs=? Ag call AckGrep(<q-args>)

" File tree browser - backslash
map \ :NERDTreeToggle<CR>
" File tree browser showing current file - pipe (shift-backslash)
map \| :NERDTreeFind<CR>

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>T :call RunNearestSpec()<CR>
map <Leader>A :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch rspec {spec}"

"Run Ruby code analyzer
let g:vimrubocop_keymap = 0
map <leader><leader> :RuboCop<cr>

nnoremap <F1> :call ToggleFocusMode()<cr>

nnoremap <leader>. :CtrlPTag<cr>

nnoremap <silent> <Leader>? :TagbarToggle<CR>

map <leader>gg :topleft :split Gemfile<cr>

nmap <silent> <leader>d <Plug>DashSearch
nmap <silent> <leader>D <Plug>DashGlobalSearch

"  Save File
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>

" Toggles the quickfix window.
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>

" vim.go
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>gds <Plug>(go-def-split)

" vim-ruby-xmpfilter
let g:xmpfilter_cmd = "seeing_is_believing"
autocmd FileType ruby nmap <buffer> <leader>m <Plug>(seeing_is_believing-mark)
autocmd FileType ruby xmap <buffer> <leader>m <Plug>(seeing_is_believing-mark)
autocmd FileType ruby imap <buffer> <leader>m <Plug>(seeing_is_believing-mark)

autocmd FileType ruby nmap <buffer> <F4> <Plug>(seeing_is_believing-clean)
autocmd FileType ruby xmap <buffer> <F4> <Plug>(seeing_is_believing-clean)
autocmd FileType ruby imap <buffer> <F4> <Plug>(seeing_is_believing-clean)

" xmpfilter compatible
autocmd FileType ruby nmap <buffer> <leader>r <Plug>(seeing_is_believing-run_-x)
autocmd FileType ruby xmap <buffer> <leader>r <Plug>(seeing_is_believing-run_-x)
autocmd FileType ruby imap <buffer> <leader>r <Plug>(seeing_is_believing-run_-x)

" auto insert mark at appropriate spot.
autocmd FileType ruby nmap <buffer> <F5> <Plug>(seeing_is_believing-run)
autocmd FileType ruby xmap <buffer> <F5> <Plug>(seeing_is_believing-run)
autocmd FileType ruby imap <buffer> <F5> <Plug>(seeing_is_believing-run)

" *********************************************
" *           Plugin Customization            *
" *********************************************

" ctrlp.vim
let g:ctrlp_match_window = 'max:15'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*   " for Linux/MacOSX
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" vim-gitgutter
highlight clear SignColumn
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" vim-rubocop
if filereadable(expand('./.hound.yml'))
  let g:vimrubocop_config = './.hound.yml'
endif

" vim-indent-guides
let g:indent_guides_guide_size = 1

" vim-airline
let g:airline_powerline_fonts = 1

" *********************************************
" *        Local Vimrc Customization          *
" *********************************************
if filereadable(expand('~/.vimrc.local'))
  so ~/.vimrc.local
endif

set exrc
set secure
