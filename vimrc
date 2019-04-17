if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

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

set foldmethod=indent             "fold based on indent
set foldnestmax=3                 "deepest fold is 3 levels
set nofoldenable                  "dont fold by default

set hidden                        " Handle multiple buffers better.
set title                         " Set the terminal's title
set number                        " Show line numbers.
set ruler                         " Show cursor position.
set list listchars=tab:»·,trail:· " Display extra whitespace
set wildmode=list:longest         " Complete files like a shell.
set wildmenu                      " Enhanced command line completion.
set wildignore=*.o,*.obj,*~       " Stuff to ignore when tab completing
set novisualbell
set noerrorbells
set history=1000                  " Store lots of :cmdline history

set synmaxcol=200                 " Syntax coloring lines that are too long just slows down the world
set scrolloff=3
set sidescrolloff=7

set splitbelow
set splitright

set mouse-=a
set mousehide
set sidescroll=1

" Speed up Vim
let g:ruby_path = system('echo $HOME/.rbenv/shims')
set lazyredraw
set ttyfast

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " no swap files
set directory=/tmp                " Keep swap files in one location
set timeoutlen=500

set laststatus=2                  " Show the status line all the time
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set autowrite
set autoread                      " Auto-reload buffers when files are changed on disk

" onedark.vim
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
set t_Co=256                      " Set terminal to 256 colors
set background=dark
colorscheme onedark

setglobal complete-=i

autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.thor set filetype=ruby

autocmd Filetype gitcommit setlocal spell textwidth=72

" Allow stylesheets to autocomplete hyphenated words
autocmd FileType css,scss,sass setlocal iskeyword+=-

" *********************************************
" *                 Functions                 *
" *********************************************

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

" puts the caller
nnoremap <leader>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

" Shortcut for =>
imap <C-l> <Space>=><Space>

" Convert old hash to new Ruby 1.9 syntax
map <leader>: :%s/:\(\w\+\)\(\s*=>\s*\)/\1: /gc<CR>

map <leader>' :%s/'\([^']*\)'/"\1"/gc<CR>

" indent/unindent visual mode selection with tab/shift+tab
vmap <tab> >gv
vmap <s-tab> <gv

" AckGrep current word
map <leader>a :call AckGrep('')<CR>
" AckVisual current selection
vmap <leader>a :call AckVisual()<CR>
command! -nargs=? Ag call AckGrep(<q-args>)

" File tree browser - backslash
map \ :NERDTreeToggle<CR>
" File tree browser showing current file - pipe (shift-backslash)
map \| :NERDTreeFind<CR>

" vim-test
nmap <silent> <leader>R :TestFile -strategy=basic<CR>
nmap <silent> <leader>r :TestNearest -strategy=basic<CR>
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>A :TestSuite<CR>
nmap <silent> <leader>. :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "dispatch"
if has('nvim')
  tmap <C-o> <C-\><C-n>
end

"Run Ruby code analyzer
let g:vimrubocop_keymap = 0
map <leader><leader> :RuboCop<cr>

nnoremap <silent> <F8> :TagbarToggle<CR>

nmap <silent> <leader>d <Plug>DashSearch
nmap <silent> <leader>D <Plug>DashGlobalSearch

nnoremap <leader>? :CtrlPCommandPalette<cr>

"  Save File
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>

" ALEFix
nmap <silent> <leader>F <Plug>(ale_fix)

" Toggles the quickfix window.
nmap <leader>q <Plug>(qf_qf_toggle)

" Reload Browser from Vim http://chrismontrois.net/2015/11/05/vim-reload/
function ReloadBrowser()
  execute ':silent !osascript ~/.vim/refresh-chrome.applescript' | execute ':redraw!'
endfunction
autocmd Filetype html,css,javascript nnoremap <silent> <leader>r :call ReloadBrowser()<CR>

" Pretty format
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
au FileType json setlocal equalprg=python\ -m\ json.tool

augroup seeingIsBelievingSettings
  autocmd!

  " Annotate marked lines
    autocmd FileType ruby nmap <F5> :%.!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk --xmpfilter-style<CR>;
  " Mark the current line for annotation
    autocmd FileType ruby nmap <F4> A # => <Esc>
  " Mark the highlighted lines for annotation
    autocmd FileType ruby vmap <F4> :norm A # => <Esc>
augroup END

" *********************************************
" *           Plugin Customization            *
" *********************************************

" ctrlp.vim
let g:ctrlp_match_window = 'max:15'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*   " for Linux/MacOSX

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

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
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline_theme='onedark'

" gist-vim
let g:gist_post_private = 1

" ale (syntax checker)
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_highlights = 0
"nmap <silent> <C-w> <Plug>(ale_next_wrap)

let g:commandPalette = {
    \ 'SeeIsBelieving: Annotate every line': '%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk',
    \ 'SeeIsBelieving: Clear marks/annotations': '%.!seeing_is_believing --clean',
    \ 'Github: Browse file on Github': 'Gbrowse',
    \ 'Maximizer: Toggle': 'MaximizerToggle',
    \ 'Tagbar: Toggle': 'TagbarToggle',
    \ 'ALE: Auto Fix (rubocop, prettier, eslint, etc...)': 'ALEFix',
    \ 'CarbonNowSh: Create source code images': 'CarbonNowSh',
    \ 'Goyo: Writing mode': 'Goyo',
    \ 'Goyo: Writing mode off': 'Goyo!'}
" *********************************************
" *        Local Vimrc Customization          *
" *********************************************
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
