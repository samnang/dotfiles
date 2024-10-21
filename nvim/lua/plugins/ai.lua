return {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    opts = {
      silent = true,
      filetypes = {
        ["NvimTree"] = false,

        -- Disable for dressing.nvim
        ["DressingSelect"] = false,
        ["DressingInput"] = false,
      },
    },
    config = function(_, opts)
      local neocodeium = require("neocodeium")
      neocodeium.setup(opts)

      vim.keymap.set("i", "<A-;>", neocodeium.accept)
      vim.keymap.set("i", "<A-w>", neocodeium.accept_word)
      vim.keymap.set("i", "<A-l>", neocodeium.accept_line)
      vim.keymap.set("i", "<A-]>", neocodeium.cycle_or_complete)
      vim.keymap.set("i", "<A-[>", function()
        require("neocodeium").cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<C-x>", neocodeium.clear)

      local cmp = require("cmp")
      local commands = require("neocodeium.commands")

      cmp.event:on("menu_opened", function()
        commands.disable()
        neocodeium.clear()
      end)

      cmp.event:on("menu_closed", function()
        commands.enable()
      end)

      cmp.setup({
        completion = {
          autocomplete = false,
        },
      })
    end,
    dependencies = {
      "nvim-cmp",
    },
  },

  {
    "robitx/gp.nvim",
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        "<cmd>GpChatToggle<cr>",
        desc = "Toggle (AI Chat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        "<cmd>GpChatDelete<cr>",
        desc = "Delete (AI Chat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        "<cmd>GpChatPaste<cr>",
        desc = "Paste the selection (AI Chat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ai",
        "<cmd>GpImplement<cr>",
        desc = "Implement code from comments in a visual selection (AI Chat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ai",
        "<cmd>GpImplement<cr>",
        desc = "Implement code from comments in a visual selection (AI Chat)",
        mode = { "n", "v" },
      },
    },
    config = function()
      local conf = {
        openai_api_key = os.getenv("ANTHROPIC_API_KEY"),
        providers = {
          anthropic = {
            endpoint = "https://api.anthropic.com/v1/messages",
          },

          googleai = {
            endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
            secret = os.getenv("GOOGLEAI_API_KEY"),
          },
        },

        hooks = {
          Explain = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please respond by explaining the code above."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, agent, template)
          end,

          CodeReview = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please analyze for code smells and suggest improvements."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
          end,
        },
      }

      require("gp").setup(conf)
    end,
  },
}
