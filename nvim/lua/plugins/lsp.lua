return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "rust-analyzer",
        "yaml-language-server",
        "css-lsp",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        -- https://github.com/LazyVim/LazyVim/pull/4406
        ts_ls = {
          enabled = false,
        },
        cssls = {
          settings = {
            css = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      },
    },
    setup = {
      -- https://github.com/LazyVim/LazyVim/pull/4406
      ts_ls = function()
        -- disable tsserver
        return true
      end,
    },
  },
}
