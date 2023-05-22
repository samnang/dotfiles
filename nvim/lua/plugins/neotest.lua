return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
      "olimorris/neotest-rspec",
      "rouge8/neotest-rust",
      "folke/which-key.nvim",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest"),
          require("neotest-rspec"),
          require("neotest-rust"),
        },
      })

      require("which-key").register({
        ["<leader>t"] = {
          name = "+test",
          t = { '<cmd>lua require("neotest").run.run()<cr>', "Run Nearest Test" },
          ["."] = { '<cmd>lua require("neotest").run.run_last()<cr>', "Run Last Test" },
          a = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Run All" },
          o = { '<cmd>lua require("neotest").output.open({ last_run = true, enter = true })<cr>', "Show Output" },
          O = { '<cmd>lua require("neotest").output.open({ short = true })<cr>', "Show Current Test Output" },
          s = { '<cmd>lua require("neotest").summary.toggle()<cr>', "Toggle Summary" }, -- `:h neotest.setup()` Summary mappings
          n = { '<cmd>lua require("neotest").jump.next({ status = "failed" })<cr>', "Jump to Next Failed" },
          N = { '<cmd>lua require("neotest").jump.prev({ status = "failed" })<cr>', "Jump to Preview Failed" },
        },
      })
    end,
  },
}
