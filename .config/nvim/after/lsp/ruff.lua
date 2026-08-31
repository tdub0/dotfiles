-- ruff formats, lints, and offers code actions
-- basedpyright owns hover, types, completion, and navigation
return {
  workspace_required = true,
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.definitionProvider = false
    client.server_capabilities.referencesProvider = false
    client.server_capabilities.completionProvider = false
    client.server_capabilities.signatureHelpProvider = false
  end,
}
