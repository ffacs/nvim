local ok, err = pcall(function()
  local config = require("lazy.core.config")
  for name, plugin in pairs(config.plugins) do
    assert(plugin._.installed, "Plugin installation failed: " .. name)
  end
  require("lazy").load({ plugins = { "telescope.nvim", "nvim-cmp" } })
  assert(vim.fn.executable("rg") == 1, "ripgrep is missing")
  assert(vim.fn.exists(":Telescope") == 2, "Telescope did not load")
  local registry = require("mason-registry")
  print("Refreshing language server registry...")
  registry.refresh()
  local mapping = require("mason-lspconfig").get_mappings().lspconfig_to_mason
  local pending, failures = 0, {}
  for _, server in ipairs(require("config.lsp").list) do
    local name = assert(mapping[server], "Unknown language server: " .. server)
    local pkg = registry.get_package(name)
    if not pkg:is_installed() then
      pending = pending + 1
      print("Installing " .. name)
      pkg:once("install:success", function()
        print("Installed " .. name)
        pending = pending - 1
      end)
      pkg:once("install:failed", function()
        table.insert(failures, name)
        pending = pending - 1
      end)
      pkg:install()
    end
  end
  assert(vim.wait(20 * 60 * 1000, function() return pending == 0 end, 100), "Language server installation timed out; see :MasonLog")
  assert(#failures == 0, "Language servers failed: " .. table.concat(failures, ", ") .. "; see :MasonLog and rerun bootstrap.sh")
  assert(vim.v.errmsg == "", vim.v.errmsg)
  print("Ready: plugins, ripgrep, and configured language servers are installed.")
end)
if not ok then
  vim.api.nvim_err_writeln(tostring(err))
  vim.cmd("cquit 1")
else
  vim.cmd("qa!")
end
