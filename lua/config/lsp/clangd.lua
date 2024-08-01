local util = require 'lspconfig.util'

local root_files = {
	'.clangd',
	'.clang-tidy',
	'.clang-format',
	'compile_commands.json',
	'compile_flags.txt',
	'build.sh', -- buildProject
	'configure.ac', -- AutoTools
	'run',
	'compile',
}

local function get_clangd_path()
	return "clangd"
end

local lsp_capabilities =
    vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities())

-- TODO: add clang-tidy to on_atach with clangd
return {
	cmd = { get_clangd_path(),
		"--background-index=false",
		"--clang-tidy",
		"--completion-style=bundled",
		"--cross-file-rename",
		"--enable-config", -- clangd 11+ supports reading from .clangd configuration file
		"--header-insertion=never",
		"--pch-storage=memory", -- could also be disk
		"-j=5",		-- number of workers
		"--log=error",
	},
	filetypes = { "c", "cc", "cpp", "objc", "objcpp" },
	root_dir = function(fname)
			return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
		end,
	single_file_support = true,
	init_options = {
		compilationDatabasePath = vim.fn.getcwd() .. "/build",
	},
	capabilities = lsp_capabilities,
}
