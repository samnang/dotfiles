return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typos-lsp",
        "cspell",
        "json-lsp",
        "yaml-language-server",
        "css-lsp",
        "rust-analyzer",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
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

        eslint = {},
      },
      setup = {
        -- https://www.lazyvim.org/configuration/recipes#add-eslint-and-use-it-for-formatting
        eslint = function()
          Snacks.util.lsp.on({ name = "eslint" }, function(_, client)
            client.server_capabilities.documentFormattingProvider = true
          end)
          Snacks.util.lsp.on({ name = "vtsls" }, function(_, client)
            client.server_capabilities.documentFormattingProvider = false
          end)
        end,
      },
    },
  },
}
