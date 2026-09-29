local function picker(name, opts)
  return function()
    require("telescope.builtin")[name](vim.deepcopy(opts or {}))
  end
end

-- Symbol search requires an attached server with document-symbol support.
-- Other buffers still get a useful text search without an LSP error.
local function document_symbols(opts)
  return function()
    local builtin = require("telescope.builtin")
    local bufnr = vim.api.nvim_get_current_buf()
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if client.initialized and client.supports_method("textDocument/documentSymbol", { bufnr = bufnr }) then
        local current_opts = vim.deepcopy(opts or {})
        current_opts.bufnr = bufnr
        current_opts.winnr = vim.api.nvim_get_current_win()
        builtin.lsp_document_symbols(current_opts)
        return
      end
    end
    builtin.current_buffer_fuzzy_find({ prompt_title = "Buffer text (LSP symbols unavailable)" })
  end
end

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  opts = {
    defaults = {
      file_ignore_patterns = { "%.git/", "__pycache__/", "build/" },
    },
    pickers = {
      find_files = { hidden = true },
      live_grep = { additional_args = { "--hidden", "--glob", "!.git/*" } },
    },
  },
  keys = {
    { "<C-p>", picker("find_files"), desc = "Search: Files" },
    { "<leader>ff", picker("find_files"), desc = "Search: Files" },
    { "<leader>fg", picker("live_grep"), desc = "Search: Project text" },
    { "<leader>fh", picker("help_tags"), desc = "Search: Help" },
    { "<leader>fb", picker("buffers"), desc = "Search: Buffers" },
    { "<leader>fr", picker("oldfiles"), desc = "Search: Recent files" },
    { "<leader>f", document_symbols({ symbols = { "function", "method", "constructor" } }), desc = "Search: Functions / buffer text" },
    { "<leader>o", document_symbols(), desc = "Search: Symbols / buffer text" },
    { "<leader>ft", document_symbols(), desc = "Search: Symbols / buffer text" },
  },
}
