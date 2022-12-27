local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	debug = true,
	-- setup formatters & linters
	sources = {
		formatting.prettier.with({
			extra_filetypes = { "solidity" },
		}),
		formatting.stylua,
		formatting.rubocop,
		formatting.rustfmt,

		diagnostics.eslint,
		diagnostics.rubocop,
	},

	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.name == "tsserver" or current_client.name == "rust_analyzer" then
			current_client.server_capabilities.documentFormattingProvider = false
		end

		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})

require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = true,
	automatic_setup = false,
})
