return {
  { "tpope/vim-rhubarb", dependencies = "tpope/vim-fugitive" },
  { "wsdjeg/vim-fetch" },
  { "max397574/better-escape.nvim", config = true },
  { "aserowy/tmux.nvim", opts = { navigation = { enable_default_keybindings = false } } },
  { "sitiom/nvim-numbertoggle" },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-pack/nvim-spectre",
    opts = { live_update = true },
    keys = {
      {
        "<leader>sf",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        mode = { "n" },
        desc = "Search on current file (Spectre)",
      },
      {
        "<leader>sf",
        '<cmd>lua require("spectre").open_file_search()<CR>',
        mode = { "v" },
        desc = "Search on current file (Spectre)",
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          always_show = {
            ".github",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ft", "<cmd>Telescop filetypes<cr>", desc = "Select filetype" },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    keys = {
      { "zp", "<Cmd>lua require('ufo').peekFoldedLinesUnderCursor()<CR>", desc = "Preview folded lines under cursor" },
    },
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },

    init = function()
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },

  {
    "declancm/maximize.nvim",
    keys = {
      { "<Leader>wz", "<Cmd>lua require('maximize').toggle()<CR>", desc = "Window Maximizer Toggle" },
    },
  },
}
