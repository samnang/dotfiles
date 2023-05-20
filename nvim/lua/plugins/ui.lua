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
