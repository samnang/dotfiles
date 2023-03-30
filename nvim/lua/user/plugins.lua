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

-- autocommand that reloads neovim and installs/updates/removes plugins when file is saved
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

	use("nvim-treesitter/nvim-treesitter")

	use("navarasu/onedark.nvim") -- preferred colorscheme

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
	use("mattn/webapi-vim")
	use("vim-test/vim-test")
	use("akinsho/toggleterm.nvim")
	use("echasnovski/mini.align") -- Align text interactively
	use("lewis6991/gitsigns.nvim") -- Git line modifications
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use("folke/which-key.nvim")
	use("johmsalas/text-case.nvim")
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
			requires = "kyazdani42/nvim-web-devicons"
		}),
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
