if vim.fn.has("nvim-0.10") == 0 then
  error("This configuration requires Neovim 0.10 or newer. See README.md.")
end

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.autoindent = true
vim.g.mapleader = ' '

require("config.globals")

require("config.lazy")
require('config.lsp').setup()
require('config.keymap')
require('config.snip')
