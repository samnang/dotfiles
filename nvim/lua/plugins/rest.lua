return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("rest-nvim").setup()
      require("telescope").load_extension("rest")
    end,
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "REST: Run HTTP request under cursor" },
      { "<leader>rl", "<cmd>Rest run<cr>", desc = "REST: Re-run last HTTP request" },
      {
        "<leader>rn",
        "<cmd>lua require('telescope').extensions.rest.select_env()<cr>",
        desc = "REST: Select environment",
      },
    },
  },
}
