-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function upsert_user_command(name, rhs, opts)
  if vim.fn.exists(":" .. name) == 2 then
    vim.api.nvim_del_user_command(name)
  end

  vim.api.nvim_create_user_command(name, rhs, opts)
end

local function run(cmd, err)
  local out = vim.fn.systemlist(cmd)[1]
  if vim.v.shell_error ~= 0 or not out or out == "" then
    vim.notify(err, vim.log.levels.ERROR)
    return nil
  end
  return out
end

upsert_user_command("GBrowse", function(opts)
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("GBrowse: no file in current buffer", vim.log.levels.ERROR)
    return
  end

  local dir = vim.fn.fnamemodify(file, ":h")
  local root = run({ "git", "-C", dir, "rev-parse", "--show-toplevel" }, "GBrowse: not inside a git repository")
  if not root then
    return
  end

  local rel_path = vim.fs.relpath(root, file)
  if not rel_path then
    vim.notify("GBrowse: unable to compute relative file path", vim.log.levels.ERROR)
    return
  end

  local branch = run({ "git", "-C", root, "rev-parse", "--abbrev-ref", "HEAD" }, "GBrowse: unable to resolve current branch")
  if not branch then
    return
  end

  if branch == "HEAD" then
    branch = run({ "git", "-C", root, "rev-parse", "HEAD" }, "GBrowse: unable to resolve current commit")
    if not branch then
      return
    end
  end

  local target = opts.range > 0 and ("%s:%d"):format(rel_path, opts.line1) or rel_path
  local url = run({ "gh", "browse", "--no-browser", "--branch", branch, target }, "GBrowse: failed to resolve GitHub URL via gh")
  if not url then
    return
  end

  if opts.line2 > opts.line1 then
    url = url:gsub("#L" .. opts.line1 .. "$", "#L" .. opts.line1 .. "-L" .. opts.line2)
  end
  vim.ui.open(url)
end, { range = true })
