-- Bootstrap lazy.nvim
local configpath = vim.env.NVIM_BOOTSTRAP_CONFIG or vim.fn.stdpath("config")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lockpath = configpath .. "/lazy-lock.json"
  local lock = vim.json.decode(table.concat(vim.fn.readfile(lockpath), "\n"))
  local commit = assert(lock["lazy.nvim"] and lock["lazy.nvim"].commit, "Missing lazy.nvim lock entry")
  -- Clone into a temporary sibling so interrupted downloads do not break retries.
  local staging = lazypath .. ".bootstrap-" .. vim.fn.getpid()
  local ok, err = pcall(function()
    local function git(args)
      local out = vim.fn.system(args)
      if vim.v.shell_error ~= 0 then
        error(out)
      end
    end
    git({ "git", "clone", "--filter=blob:none", "--no-checkout", "https://github.com/folke/lazy.nvim.git", staging })
    git({ "git", "-C", staging, "checkout", commit })
    assert((vim.uv or vim.loop).fs_rename(staging, lazypath))
  end)
  if not ok then
    vim.fn.delete(staging, "rf")
    error("Plugin bootstrap failed. Check Git/network access and run bootstrap.sh again.\n" .. tostring(err))
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  lockfile = configpath .. "/lazy-lock.json",
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
