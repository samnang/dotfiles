return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local logo = [[

  ██████   █████                   █████   █████  ███
 ░░██████ ░░███                   ░░███   ░░███  ░░░
  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████
  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███
  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███
  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███
  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████
 ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░

]]

      opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
      opts.section.header.val = vim.split(logo, "\n", { trimempty = true })

      opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
      opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
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
}
