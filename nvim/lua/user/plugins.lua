-------------------------
-- Bootstrapping Packer
-------------------------

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- packer can manage itself

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({
		"nvim-telescope/telescope.nvim", -- fuzzy finder
		requires = {
			"nvim-lua/plenary.nvim", -- lua functions that many plugins use
		},
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	use({
		"navarasu/onedark.nvim", -- preferred colorscheme
		config = function()
			require("onedark").load()
		end,
	})

	use("akinsho/bufferline.nvim") -- pretty tabs / buffers

	use("szw/vim-maximizer") -- maximizes and restores current window
	use("tpope/vim-surround")
	use("tpope/vim-rails") -- Rails commands
	use("tpope/vim-fugitive") -- Git commands
	use("tpope/vim-endwise")
	use("nvim-lualine/lualine.nvim") -- statusline
	use("numToStr/Comment.nvim") -- code commeter
	use("folke/zen-mode.nvim") -- Zen mode editor
	use("mbbill/undotree")
	use("wsdjeg/vim-fetch") -- open file with line number

	use("vim-test/vim-test")
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup()
		end,
	})

	use({
		"echasnovski/mini.align", -- Align text interactively
		config = function()
			require("mini.align").setup()
		end,
	})

	use({
		"lewis6991/gitsigns.nvim", -- Git line modifications
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({
		"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	})

	use({
		"johmsalas/text-case.nvim",
		config = function()
			require("textcase").setup({ prefix = "<leader>cc" })
			require("telescope").load_extension("textcase")
			vim.api.nvim_set_keymap("n", "<leader>cc.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
			vim.api.nvim_set_keymap("v", "<leader>cc.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
		end,
	})

	use({
		"nvim-tree/nvim-tree.lua", -- file explorer
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	})

	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "ray-x/lsp_signature.nvim" },

			-- configure formatters & linters
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "jayp0521/mason-null-ls.nvim" },
			-- {'MunifTanjim/prettier.nvim'},

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "onsails/lspkind.nvim" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},

		use({
			"folke/trouble.nvim", -- Show errors and diagnostics in quickfix window
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({})
			end,
		}),
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
