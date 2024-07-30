vim.opt.relativenumber = true
vim.opt.cursorline = true


require("config.lazy")
require('config.lsp').setup()
