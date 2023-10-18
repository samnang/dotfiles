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
        "<leader>tA",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach to the nearest test",
      },
    },
  },
}
