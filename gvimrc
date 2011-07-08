set columns=180 
set lines=41
set cursorline

if has("mouse")
  set mouse=a
endif

set guifont=Monaco:h18
set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.
set background=light              " Background.
set go-=m go-=T go-=l go-=L go-=r go-=R go-=b go-=F

colorscheme vividchalk

"Load NERDTree and put cursor in other window
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
