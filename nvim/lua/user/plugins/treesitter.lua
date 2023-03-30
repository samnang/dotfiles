local setup, treesitter_install = pcall(require, "nvim-treesitter.install")
if not setup then
	return
end

local ts_update = treesitter_install.update({ with_sync = true })
ts_update()

local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"bash",
		"comment",
		"css",
		"dockerfile",
		"gitignore",
		"go",
		"graphql",
		"hcl",
		"help",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"ruby",
		"rust",
		"scss",
		"solidity",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"yaml",
	},
	-- auto install above language parsers
	auto_install = true,
})
