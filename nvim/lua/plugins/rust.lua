return {
  {
    "simrat39/rust-tools.nvim",
    dependencies = {
      "mattn/webapi-vim",
    },
    config = function()
      local opts = {
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(_, bufnr)
            require("which-key").register({
              r = {
                name = "rust",
                h = {
                  "<cmd>lua require'rust-tools'.hover_actions.hover_actions()<cr>",
                  "Hover actions",
                  buffer = bufnr,
                },
                m = { "<cmd>lua require'rust-tools'.expand_macro.expand_macro()<cr>", "Expand Macro", buffer = bufnr },
                r = { "<cmd>wa<cr><cmd>lua require'rust-tools'.runnables.runnables()<cr>", "Runnables", buffer = bufnr },
                d = {
                  "<cmd>wa<cr><cmd>lua require'rust-tools'.debuggables.debuggables()<cr>",
                  "Debuggables",
                  buffer = bufnr,
                },
              },
            }, { prefix = "<leader>" })
          end,
        },
      }

      -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
      -- https://github.com/simrat39/rust-tools.nvim/wiki/Debugging#codelldb-a-better-debugging-experience
      local mason_registry = require("mason-registry")
      if mason_registry.is_installed("codelldb") then
        local extension_path = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
          or extension_path .. "lldb/lib/liblldb.so"

        opts.dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        }
      else
        opts.dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
          },
        }
      end

      require("rust-tools").setup(opts)
    end,
  },
}
