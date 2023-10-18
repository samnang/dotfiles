return {
  {
    "vim-test/vim-test",
    dependencies = {
      "akinsho/toggleterm.nvim",
    },
    keys = {
      { "<leader>Tr", "<cmd>TestNearest<cr>", desc = "Run nearest nest (vim-test)" },
      { "<leader>Tt", "<cmd>TestFile<cr>", desc = "Run test file (vim-test)" },
      { "<leader>T.", "<cmd>TestLast<cr>", desc = "Test last lest (vim-test)" },
      { "<leader>Tv", "<cmd>TestVisit<cr>", desc = "Open the last test (vim-test)" },
    },
    init = function()
      vim.g["test#strategy"] = "toggleterm"
    end,
  },
}
