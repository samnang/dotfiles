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
          -- Hide written messages
          filter = {
            event = "msg_show",
            find = "%dL, %d",
            kind = "",
          },
          opts = {
            skip = true,
          },
        },
        {
          -- Hide deprecated messages
          filter = {
            event = "notify",
            find = "treesitter",
            kind = "warn",
          },
          opts = {
            skip = true,
          },
        },
      },
    },
  },
}
