return {
  { "tpope/vim-rails" },
  {
    "RRethy/nvim-treesitter-endwise",
    config = function()
      require("nvim-treesitter.configs").setup({
        endwise = {
          enable = true,
        },
      })
    end,
  },
}
