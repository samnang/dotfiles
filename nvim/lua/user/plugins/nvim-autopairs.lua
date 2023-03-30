local setup, nvim_autopairs = pcall(require, "nvim-autopairs")
if not setup then
	return
end

nvim_autopairs.setup()
