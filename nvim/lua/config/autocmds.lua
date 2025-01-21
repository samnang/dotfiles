-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Filetype detection
vim.filetype.add({ filename = { ["Brewfile"] = "ruby" } })

-- disable autoformat on save
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "ruby" },
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })

-- Highlight on yank (override to have faster timeout which is default: 150)
-- https://github.com/LazyVim/LazyVim/blob/a72a84972d85e5bbc6b9d60a0983b37efef21b8a/lua/lazyvim/config/autocmds.lua#L13-L19
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("lazyvim_highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 50 })
  end,
})
