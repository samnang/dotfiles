return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "filetype")
      table.insert(opts.sections.lualine_x, {
        function()
          local status = require("neocodeium").get_status()
          return string.gsub(status, "%s+", "")
        end,
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
