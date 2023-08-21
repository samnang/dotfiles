return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.matchup = { enable = true } -- vim-matchup integration
      vim.list_extend(opts.ensure_installed, {
        "solidity",
        "scss",
      })
    end,
  },
}
