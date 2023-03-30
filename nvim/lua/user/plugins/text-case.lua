local setup, textcase = pcall(require, "textcase")
if not setup then
	return
end

local setup, telescope = pcall(require, "telescope")
if not setup then
	return
end

textcase.setup({ prefix = "<leader>cc" })

telescope.load_extension("textcase")
vim.api.nvim_set_keymap("n", "<leader>cc.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
vim.api.nvim_set_keymap("v", "<leader>cc.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
