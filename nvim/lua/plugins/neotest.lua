return {
  { "nvim-neotest/neotest-jest" },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-jest",
      "folke/which-key.nvim",
    },
    opts = {
      status = { virtual_text = false },
      adapters = {
        ["neotest-rspec"] = {},
        ["neotest-rust"] = {},
        ["neotest-jest"] = {},
      },
    },
    keys = {
      {
        "<leader>t.",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tR",
        function()
          require("neotest").run.run()

          -- Wait until a test process started
          vim.defer_fn(function()
            require("neotest").run.attach()
          end, 500)
        end,
        desc = "Run and attach to the nearest test",
      },
      {
        "<leader>tA",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach to the nearest test",
      },
    },
  },
}
