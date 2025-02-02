return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        event = "VeryLazy",
        opts = {
          hint = "floating-big-letter",
          show_prompt = false,
        },
      },
    },
    keys = {
      { "|", "<Cmd>Neotree<CR>", desc = "File tree" },
    },
    opts = {
      window = {
        mappings = {
          ["<esc>"] = "clear_hl",
          ["<c-s>"] = "open_split",
          ["<c-v>"] = "open_vsplit",
          ["O"] = "system_open",
          ["J"] = "first_sibling",
          ["K"] = "last_sibling",
          ["h"] = "navigate_out",
          ["l"] = "navigate_in",
          ["/"] = "noop",
        },
      },
      commands = {
        clear_hl = function(state)
          vim.api.nvim_command("noh")
        end,
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#open-with-system-viewer
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          path = vim.fn.shellescape(path, 1)
          -- macOs: open file in default application in the background.
          vim.api.nvim_command("silent !open -g " .. path)
          -- Linux: open file in default application
          -- vim.api.nvim_command("silent !xdg-open " .. path)
        end,

        -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/220#discussioncomment-2460683
        -- Go to first/last sibling
        first_sibling = function(state)
          local tree = state.tree
          local node = tree:get_node()
          local siblings = tree:get_nodes(node:get_parent_id())
          local renderer = require("neo-tree.ui.renderer")
          renderer.focus_node(state, siblings[#siblings]:get_id())
        end,

        last_sibling = function(state)
          local tree = state.tree
          local node = tree:get_node()
          local siblings = tree:get_nodes(node:get_parent_id())
          local renderer = require("neo-tree.ui.renderer")
          renderer.focus_node(state, siblings[1]:get_id())
        end,

        -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#navigation-with-hjkl
        -- Navigation with hjkl
        navigate_out = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" and node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        navigate_in = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            if not node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            elseif node:has_children() then
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        end,
      },
      filesystem = {
        filtered_items = {
          always_show = {
            ".github",
            ".tool-versions",
            ".editorconfig",
            ".gitignore",
            ".env",
            ".env.example",
            ".env.sample",
            ".env.development",
            ".env.test",
            ".env.local",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
    },
  },
}
