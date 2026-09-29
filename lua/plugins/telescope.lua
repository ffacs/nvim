local function picker(name, opts)
  return function()
    require("telescope.builtin")[name](opts or {})
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
    { "<leader>f", picker("lsp_document_symbols", { symbols = { "function", "method", "constructor" } }), desc = "Search: Document functions (LSP)" },
    { "<leader>o", picker("lsp_document_symbols"), desc = "Search: Document symbols (LSP)" },
    { "<leader>ft", picker("lsp_document_symbols"), desc = "Search: Document symbols (LSP)" },
  },
}
