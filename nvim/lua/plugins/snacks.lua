return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
      bigfile = { enabled = true, notify = true },
      quickfile = { enabled = true },
      words = { enabled = true },
      statuscolumn = { enabled = true },
      scroll = { enabled = true },
      zen = { enabled = true },
      image = { enabled = true },
      terminal = {
        win = {
          wo = {
            winbar = "",
          },
        },
      },
      dashboard = {
        row = 10,
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
      },
    },
  },
}
