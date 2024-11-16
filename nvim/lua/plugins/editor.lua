return {
  { "pteroctopus/faster.nvim" },
  { "tpope/vim-rhubarb", dependencies = "tpope/vim-fugitive" },
  { "wsdjeg/vim-fetch" },
  { "max397574/better-escape.nvim", config = true },
  {
    "akinsho/git-conflict.nvim",
    opts = {
      default_mappings = {
        ours = "<leader>gCo",
        theirs = "<leader>gCt",
        none = "<leader>gC0",
        both = "<leader>gCb",
        next = "<leader>gCn",
        prev = "<leader>gCp",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },

  { "aserowy/tmux.nvim", opts = { navigation = { enable_default_keybindings = false } } },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        ["<leader>T"] = { name = "+vim-test" },
        ["<leader>r"] = { name = "+rest-http" },
      },
    },
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>sf",
        mode = { "n" },
        "<cmd>lua require('grug-far').grug_far({ prefills = { flags = vim.fn.expand('%') } })<CR>",
        desc = "Search on current file (Spectre)",
      },
      {
        "<leader>sf",
        "<cmd>lua require('grug-far').with_visual_selection({ prefills = { flags = vim.fn.expand('%') } })<CR>",
        mode = { "v" },
        desc = "Search on current file (Spectre)",
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

  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      {
        "<leader>U",
        "<cmd>Telescope undo<cr>",
        desc = "Undo history",
      },
    },
    opts = {
      extensions = {
        undo = {
          use_delta = true,
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.7,
          },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
      { "echasnovski/mini.icons" },
    },
    opts = {
      show_icons = true,
      leader_key = ";",
      buffer_leader_key = "m",
      mappings = {
        open_vertical = "|",
        open_horizontal = "-",
      },
    },
  },
}
