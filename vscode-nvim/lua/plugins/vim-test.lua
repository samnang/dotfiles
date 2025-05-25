return {
  {
    "vim-test/vim-test",
    vscode = true,
    keys = {
      { "<leader>tr", "<cmd>TestNearest<cr>", desc = "Run nearest nest (vim-test)" },
      { "<leader>tt", "<cmd>TestFile<cr>", desc = "Run test file (vim-test)" },
      { "<leader>t.", "<cmd>TestLast<cr>", desc = "Test last lest (vim-test)" },
      { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Open the last test (vim-test)" },
    },
    init = function()
      vim.g["test#strategy"] = "neovim_vscode"
    end,
  },
}
