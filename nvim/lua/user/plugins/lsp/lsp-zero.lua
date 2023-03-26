local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"rust_analyzer",
	"lua_ls",
	"gopls",
	"jsonls",
	"solargraph",
	"terraformls",
	"yamlls",
	"solc",
})

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
end)

vim.o.updatetime = 250
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float({focus=false})]])

lsp.nvim_workspace()
lsp.setup()
