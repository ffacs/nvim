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
  require("mason").setup()
  require("mason-lspconfig").setup({ ensure_installed = servers.list })
	for _, server in pairs(servers.list) do
		local opts = {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}

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


return servers
