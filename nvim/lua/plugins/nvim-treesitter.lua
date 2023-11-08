return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.matchup = { enable = true } -- vim-matchup integration
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-CR>",
          node_incremental = "<CR>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }
      vim.list_extend(opts.ensure_installed, {
        "solidity",
        "css",
        "scss",
      })
    end,
  },
}
