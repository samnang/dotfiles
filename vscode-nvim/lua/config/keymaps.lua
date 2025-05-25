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

local vscode = require("vscode")

-- clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })

-- Don't touch unnamed register when pasting over visual selection
map("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

map("n", "g|", function()
  vscode.action("editor.action.revealDefinitionAside")
end, { desc = "Go to definition in split" })

map("n", "gr", function()
  vscode.action("editor.action.referenceSearch.trigger")
end, { desc = "Go to references" })

map("n", "gi", function()
  vscode.action("editor.action.goToImplementation")
end, { desc = "Go to implementation" })

map("n", "<leader>ca", function()
  vscode.action("editor.action.quickFix")
end, { desc = "Code Actions" })

map("n", "<leader>cl", function()
  vscode.action("workbench.actions.view.problems")
end, { desc = "Show problems panel" })

map("n", "[d", function()
  vscode.action("editor.action.marker.prev")
end, { desc = "Previous diagnostic" })

map("n", "]d", function()
  vscode.action("editor.action.marker.next")
end, { desc = "Next diagnostic" })

map("n", "<leader><leader>", function()
  vscode.action("workbench.action.quickOpen")
end, { desc = "Quick Open" })

map("n", "<leader>e", function()
  vscode.action("workbench.action.toggleSidebarVisibility")
end, { desc = "Show explorer" })

map("n", "<leader>fe", function()
  vscode.action("workbench.files.action.showActiveFileInExplorer")
end, { desc = "Show file in explorer" })

map("n", "<leader>sr", function()
  vscode.action("editor.action.startFindReplaceAction")
end, { desc = "Find and replace" })

map("n", "<leader>sw", function()
  vscode.action("workbench.action.findInFiles", {
    args = {
      query = vim.fn.expand("<cword>"),
    },
  })
end, { desc = "Find word in project" })

map("n", "<leader>/", function()
  vscode.action("workbench.action.findInFiles")
end, { desc = "Find in project" })

map("n", "<leader>bo", function()
  vscode.action("workbench.action.closeOtherEditors")
end, { desc = "Close other editors" })

map("n", "<leader>bd", function()
  vscode.action("workbench.action.closeActiveEditor")
end, { desc = "Close other editors" })
