local keymap = vim.keymap

vim.g.mapleader = " "       -- set leader key to space

---------------------
-- General Keymaps
---------------------

keymap.set("i", "jk", "<ESC>")                         -- use jk to exit insert mode
keymap.set("n", "<CR>", ":nohl<CR>", { silent=true })  -- clear search highlights


-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management

-- Easier navigation between split windows
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")

keymap.set("n", "<leader>sv", "<C-w>v")        -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s")        -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=")        -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>")    -- close current split window
keymap.set("n", "<leader>|", "<C-w>v")         -- split window vertically
keymap.set("n", "<leader>-", "<C-w>s")         -- split window horizontally
keymap.set("n", "<leader>=", "<C-w>=")         -- make split windows equal width & height

keymap.set("n", "<leader>to", ":tabnew<CR>")   -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>")     --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>")     --  go to previous tab

-- clipboard
keymap.set({"n", "v"}, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])


----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")     -- toggle split window maximization

-- undotree
keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- nvim-tree
keymap.set("n", "\\", ":NvimTreeToggle<CR>")     -- toggle file explorer
keymap.set("n", "|", ":NvimTreeFindFile<CR>")    -- Find file in file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")   -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")    -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")  -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")      -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")    -- list available help tags

-- vim-test
keymap.set("n", "<leader>t", ":TestNearest<CR>", { silent=true })
keymap.set("n", "<leader>T", ":TestFile<CR>", { silent=true })
keymap.set("n", "<leader>l", ":TestLast<CR>", { silent=true })

-- Language Server Protocol
keymap.set("n", "<leader>rs", ":LspRestart<CR>")       -- mapping to restart lsp if necessary
keymap.set("n", "<leader>fm", ":LspZeroFormat<CR> :w<CR>") -- Format current buffer

-- toggleterm
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
keymap.set("n", "<leader>`", ":ToggleTerm<CR>")
