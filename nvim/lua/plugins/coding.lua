return {
  {
    "echasnovski/mini.align",
    config = function()
      require("mini.align").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    config = true,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").load()
      require("luasnip").filetype_extend("ruby", { "rails" })
    end,
  },
}
