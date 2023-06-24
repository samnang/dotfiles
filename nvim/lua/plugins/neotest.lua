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
    end,
    keys = {
      {
        "<leader>t.",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
    },
  },
}
