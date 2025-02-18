return {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    opts = {
      silent = true,
      completion = {
        autocomplete = false,
        menu = {
          auto_show = function(ctx)
            return ctx.mode ~= "default"
          end,
        },
      },
      filetypes = {
        ["NvimTree"] = false,
        ["codecompanion"] = false,
        ["snacks_picker_input"] = false,

        -- Disable for dressing.nvim
        ["DressingSelect"] = false,
        ["DressingInput"] = false,
      },
    },
    config = function(_, opts)
      local neocodeium = require("neocodeium")
      local blink = require("blink.cmp")

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function()
          neocodeium.clear()
        end,
      })

      opts.filter = function()
        return not blink.is_visible()
      end
      neocodeium.setup(opts)

      vim.keymap.set("i", "<A-;>", neocodeium.accept)
      vim.keymap.set("i", "<A-w>", neocodeium.accept_word)
      vim.keymap.set("i", "<A-l>", neocodeium.accept_line)
      vim.keymap.set("i", "<A-]>", neocodeium.cycle_or_complete)
      vim.keymap.set("i", "<A-[>", function()
        require("neocodeium").cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<C-x>", neocodeium.clear)
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<C-a>",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Open the CodeCompanion Actions Palette",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
      },
      {
        "<leader>a",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle a CodeCompanion chat buffer",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "gemini",
        },
        inline = {
          adapter = "gemini",
        },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:op read op://Personal/5tg2exq5jmnt7n3zagyjzcxuci/credential --no-newline",
            },
          })
        end,
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "cmd:op read op://Personal/5tg2exq5jmnt7n3zagyjzcxuci/credential --no-newline",
            },
          })
        end,
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },
}
