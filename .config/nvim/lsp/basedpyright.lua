return {
  workspace_required = true,
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        diagnosticMode = "openFilesOnly",
        ignore = { "*" },
      },
    },
  },
  on_attach = function(client)
    -- ruff owns format / lint / code actions
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
