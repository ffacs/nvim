require('mason').setup()
require('mason-lspconfig').setup()
local lspconfig = require("lspconfig")

local servers = {}

servers.list = {
	"bashls",
	"clangd",
	"cmake",
	"lua_ls",
	"pylsp",
	"vimls",
	"rust_analyzer"
}

servers.setup = function()
	for _, server in pairs(servers.list) do
		opts = {}

		if server == "clangd" then
			local clangd_opts = require("config.lsp.clangd")
			opts = vim.tbl_deep_extend("force", clangd_opts, opts)
		end

		if server == "cmake" then
			local cmake_opts = require("config.lsp.cmake")
			opts = vim.tbl_deep_extend("force", cmake_opts, opts)
		end

		lspconfig[server].setup(opts)
	end
end

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, opts)

return servers
