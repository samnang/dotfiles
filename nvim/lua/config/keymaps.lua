-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })

-- Interfere with window nevigation in LazyVim
-- https://github.com/LazyVim/LazyVim/discussions/277
map({ "n", "t" }, "<C-h>", [[<CMD>lua require("tmux").move_left()<CR>]])
map({ "n", "t" }, "<C-l>", [[<CMD>lua require("tmux").move_right()<CR>]])
map({ "n", "t" }, "<C-k>", [[<CMD>lua require("tmux").move_top()<CR>]])
map({ "n", "t" }, "<C-j>", [[<CMD>lua require("tmux").move_bottom()<CR>]])

-- Faster to quit
map({ "n", "v", "t" }, "<C-q>", [[<CMD>:q<CR>]])

-- Override existing flash.nvim: Flash Treesitter
map("v", "S", "<Esc><Cmd>lua require'nvim-surround'.visual_surround({ line_mode = false })<CR>", {
  desc = "Add a surrounding pair around a visual selection",
  silent = true,
})

-- Don't touch unnamed register when pasting over visual selection
map("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

map("n", "<leader>bX", [[<CMD>%bdelete|edit#|bdelete#<CR>]], { desc = "Close all buffers except the current" })
