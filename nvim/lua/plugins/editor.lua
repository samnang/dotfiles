return {
  { "tpope/vim-rhubarb", dependencies = "tpope/vim-fugitive" },
  { "wsdjeg/vim-fetch" },
  { "max397574/better-escape.nvim", config = true },
  { "aserowy/tmux.nvim", opts = { navigation = { enable_default_keybindings = false } } },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>T"] = { name = "+vim-test" },
      },
    },
  },
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.g.codeium_filetypes = { TelescopePrompt = false }

      vim.keymap.set("i", "<M-;>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true, desc = "Codeium: Accept suggestion" })
      vim.keymap.set("i", "<M-]>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, desc = "Codeium: Next suggestion" })
      vim.keymap.set("i", "<M-[>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, desc = "Codeium: Previous suggestion" })
      vim.keymap.set("i", "<M-Space>", function()
        return vim.fn["codeium#Complete"](-1)
      end, { expr = true, desc = "Codeium: Trigger suggestion" })
      vim.keymap.set("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, desc = "Codeium: Clear suggestion" })
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-pack/nvim-spectre",
    opts = { live_update = true, color_devicons = true, lnum_for_results = true },
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
      {
        "<leader>sr",
        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        mode = { "v" },
        desc = "Search current word (Spectre)",
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
  {
    "stevearc/aerial.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        layout = {
          min_width = { 15, 0.1 },
        },
      })
    end,
  },
}
