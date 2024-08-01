local ls = require('luasnip')

local jump_forward = function ()
  ls.jump(1) 
end

local jump_backward = function ()
  ls.jump(-1) 
end

vim.keymap.set({"i", "s"}, "<C-L>", jump_forward , {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", jump_backward , {silent = true})

