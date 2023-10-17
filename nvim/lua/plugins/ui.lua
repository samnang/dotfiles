return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "filetype")
      table.insert(opts.sections.lualine_x, {
        "codeium#GetStatusString",
        icon = "🤖",
        color = { gui = "bold" },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    opts = function(_, opts)
      require("mini.indentscope").setup(opts)

      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#98C379" })
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local logo = [[
███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
]]
      opts.config.header = vim.split(string.rep("\n", 8) .. logo .. "\n\n", "\n")
    end,
  },

  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            any = {
              -- Hide written messages
              {
                event = "msg_show",
                find = "%dL, %d",
                kind = "",
              },
              -- Hide yank/delete/undo messages
              {
                event = "msg_show",
                find = "%d more line?",
              },
              {
                event = "msg_show",
                find = "%d fewer line?",
              },
              {
                event = "msg_show",
                find = "%d lines? less",
              },
              {
                event = "msg_show",
                find = "%d changes?; before",
              },
              -- Hide deprecated messages
              {
                event = "notify",
                find = "treesitter",
                kind = "warn",
              },
              -- Hide yanked messages
              {
                event = "msg_show",
                find = "%d lines yanked",
              },
            },
          },
          opts = {
            skip = true,
          },
        },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bX", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close all other visible buffers" },
    },
    opts = {
      options = {
        tab_size = 24,
        separator_style = "slant",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
          },
        },
      },
    },
  },
}
