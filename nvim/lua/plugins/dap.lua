return {
  {
    "mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "codelldb", "js" },
    },
  },

  {
    "mxsdev/nvim-dap-vscode-js",
    config = function()
      local mason_registry = require("mason-registry")
      local js_debug_path = mason_registry.get_package("js-debug-adapter"):get_install_path()

      require("dap-vscode-js").setup({
        debugger_path = js_debug_path,
        debugger_cmd = { "js-debug-adapter" },
        adapters = { "pwa-node", "pwa-chrome", "node-terminal" }, -- which adapters to register in nvim-dap
      })

      for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file (" .. language .. ")",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach (" .. language .. ")",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
