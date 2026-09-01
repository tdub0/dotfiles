-- nvim-lspconfig ships lsp/*.lua
-- after/lsp loads last and wins with force
return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
}
