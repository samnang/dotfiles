return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "mason.nvim", "davidmh/cspell.nvim" },
    config = function()
      local cspell = require("cspell")

      local config = {
        config_file_preferred_name = "cspell.json",
        cspell_config_dirs = { "~/.config/" },
      }

      require("null-ls").setup({
        sources = {
          cspell.diagnostics.with({
            -- Set the severity to HINT for unknown words
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity["HINT"]
            end,

            config = config,
          }),
          cspell.code_actions.with({ config = config }),
        },
      })
    end,
  },
}
