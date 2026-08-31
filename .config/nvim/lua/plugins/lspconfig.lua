-- nvim-lspconfig is data. Server tables live in its lsp/ directory and merge
-- with ~/.config/nvim/lsp/*.lua. Load it at startup so vim.lsp.enable finds them.
return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
}
