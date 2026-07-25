-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- opt.clipboard = "" -- don't sync with system clipboard

opt.relativenumber = false

-- disable auto-open the Output messages
-- https://github.com/vscode-neovim/vscode-neovim/issues/2507
opt.cmdheight = 100
