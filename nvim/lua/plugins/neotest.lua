return {
  { "nvim-neotest/neotest-jest" },
  { "olimorris/neotest-rspec" },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
      "nvim-neotest/neotest-jest",
      "folke/which-key.nvim",
    },
    opts = {
      status = { virtual_text = false },
      adapters = {
        ["neotest-rspec"] = {
          -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
          rspec_cmd = function()
            return vim.tbl_flatten({
              "bundle",
              "exec",
              "rspec",
            })
          end,
        },
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
