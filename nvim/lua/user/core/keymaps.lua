local which_key = require("which-key")

vim.g.mapleader = " " -- set leader key to space

-- clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Don't touch unnamed register when pasting over visual selection
vim.keymap.set("x", "p", function()
	return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

-- Window Navigation
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

which_key.register({
	["jk"] = { "<ESC>", "Escape Mode", mode = "i" },
	["<CR>"] = { "<cmd>nohl<CR>", "Clear Search Highlight" },

	["<leader>+"] = { "<C-a>", "Increment" },
	["<leader>-"] = { "<C-x>", "Decrement" },
})

-- Easier navigation between split windows
which_key.register({
	["<leader>s"] = {
		name = "+split",
		v = { "<C-w>v", "Vertical" },
		h = { "<C-w>s", "Horizontal" },
		e = { "<C-w>=", "Equal Size" },
		x = { "<cmd>close<cr>", "Close" },
		["|"] = { "<C-w>v", "Vertical" },
		["-"] = { "<C-w>s", "Horizontal" },
		["="] = { "<C-w>=", "Equal Size" },

		-- vim-maximizer
		m = { "<cmd>MaximizerToggle<cr>", "Toggle Maximize" },
	},

	["<leader>t"] = {
		name = "+tab",
		o = { "<cmd>tabnew<cr>", "New" },
		n = { "<cmd>tabn<cr>", "Next" },
		p = { "<cmd>tabp<cr>", "Previous" },
		x = { "<cmd>tabclose<cr>", "Close" },
	},
})

which_key.register({
	-- legendary
	["<C-p>"] = { "<cmd>Legendary<cr>", "Show Command Palette" },

	-- undotree
	["<leader>u"] = { "<cmd>UndotreeToggle<cr>", "UndoTree | Toggle" },

	-- vim-test
	["<leader>rt"] = { "<cmd>TestNearest<cr>", "Test | Nearest" },
	["<leader>T"] = { "<cmd>TestFile<cr>", "Test | File" },
	["<leader>l"] = { "<cmd>TestLast<cr>", "Test | File" },

	-- nvim-tree
	["\\"] = { "<cmd>NvimTreeToggle<cr>", "File Explorer | Toggle" },
	["|"] = { "<cmd>NvimTreeFindFile<cr>", "File Explorer | Reveal File" },

	-- telescope
	["<leader>f"] = {
		name = "+file",
		f = { "<cmd>Telescope find_files<cr>", "File | Find" },
		s = { "<cmd>Telescope live_grep<cr>", "File | Find String" },
		c = { "<cmd>Telescope grep_string<cr>", "File | Find String Under Cursor" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		b = { "<cmd>Telescope buffers<cr>", "Open Buffer" },

		-- LSP
		m = { "<cmd>LspZeroFormat<cr>", "Format File" },
		["."] = { "<cmd>TroubleToggle<cr>", "Show Errors & Diagnostics" },
	},
})

-- toggleterm
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
which_key.register({
	["<leader>`"] = { "<cmd>ToggleTerm<cr>", "Terminal | Toggle" },
})
