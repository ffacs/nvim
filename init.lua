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

local config_dir = vim.fn.stdpath("config")
---@cast config_dir string

vim.cmd("source " .. vim.fn.resolve(config_dir .. "/viml_conf/plugins.vim"))
