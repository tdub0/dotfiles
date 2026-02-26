vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = { disable = { "missing-fields" } },
      workspace = { checkThirdParty = false },
    },
  },
})
