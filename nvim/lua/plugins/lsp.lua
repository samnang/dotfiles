return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "solargraph",
        "rust-analyzer",
        "yaml-language-server",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      },
    },
  },
}
