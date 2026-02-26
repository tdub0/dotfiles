-- Ruff handles formatting/linting only; disable hover so other LSPs (e.g. basedpyright) take over
vim.lsp.config("ruff", {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
})
