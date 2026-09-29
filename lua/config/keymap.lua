vim.keymap.set("n", "<F2>", ":Lexplore<enter>", {noremap = true, silent = true})

-- LSP navigation and code actions.
vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, desc = "LSP: Hover documentation" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, desc = "LSP: Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "LSP: Go to declaration" })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { silent = true, desc = "LSP: Go to type definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true, desc = "LSP: Find references" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { silent = true, desc = "LSP: Rename symbol" })
vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "LSP: Code action" })

vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true, desc = "LSP: Go to implementation" })
vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { silent = true, desc = "LSP: Signature help" })
vim.keymap.set({ "n", "x" }, "<leader>=", function()
  vim.lsp.buf.format()
end, { silent = true, desc = "LSP: Format code" })

-- Diagnostics.
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true, desc = "Diagnostics: Show details" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Diagnostics: Previous" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Diagnostics: Next" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { silent = true, desc = "Diagnostics: Location list" })
