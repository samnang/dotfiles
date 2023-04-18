return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "solargraph",
        "rust_analyzer",
        "yamlls",
      })
    end,
  },
}
