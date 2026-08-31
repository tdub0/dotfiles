-- lazydev injects the Neovim API
-- Do not add nvim_get_runtime_file here
return {
  workspace_required = true,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        disable = { "missing-fields" },
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}
