return {
  "johmsalas/text-case.nvim",
  opts = {
    prefix = "<leader>cc",
  },
  keys = {
    { "<leader>cc", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Change Case" },
  },
  config = function()
    require("telescope").load_extension("textcase")
  end,
}
