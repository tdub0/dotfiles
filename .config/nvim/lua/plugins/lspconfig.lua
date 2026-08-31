-- nvim-lspconfig is data
-- lsp/*.lua files load after ~/.config/nvim/lsp and overwrite with force
-- Put overrides in after/lsp so they win
return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
}
