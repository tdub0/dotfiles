vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
    },
  },
})
