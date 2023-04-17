local status, lsp = pcall(require, "lsp-zero")
if not status then
  return
end

lsp.preset({
  name = "recommended",
  set_lsp_keymaps = { preserve_mappings = false },
})

lsp.ensure_installed({
  "tsserver",
  "eslint",
  "rust_analyzer",
  "lua_ls",
  "jsonls",
  "solargraph",
  "yamlls",
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
