return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          keys = {
            { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
            { "<leader>cR", false },
            { "<leader>Rc", "<cmd>RustOpenCargo<cr>", desc = "Open Cargo (Rust)" },
            { "<leader>Rd", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
            { "<leader>Rr", "<cmd>RustRunnables<cr>", desc = "Runnables (Rust)" },
            { "<leader>Rm", "<cmd>RustExpandMacro<cr>", desc = "Expand Macro (Rust)" },
          },
        },
      },
    },
  },
}
