local opt = vim.opt

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true         -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2           -- 2 spaces for tabs
opt.shiftwidth = 2        -- 2 spaces for indent width
opt.expandtab = true      -- expand tab to spaces
opt.autoindent = true     -- copy indent from current line when starting new one

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- line wrapping
opt.wrap = false          -- disable line wrapping

-- search settings
opt.incsearch = true
opt.incsearch = true
opt.ignorecase = true     -- ignore case when searching
opt.smartcase = true      -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true     -- highlight the current cursor line

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- backup
opt.backup = false        -- Don't make a backup before overwriting a file.
opt.writebackup = false   -- And again.
opt.swapfile = false      -- no swap files
vim.opt.undodir = vim.env.HOME .. "/.vim/undodir"
vim.opt.undofile = true

-- split windows
opt.splitright = true     -- split vertical window to the right
opt.splitbelow = true     -- split horizontal window to the bottom

opt.iskeyword:append("-") -- consider string-string as whole word

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark"       -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"        -- show sign column so that text doesn't shift
