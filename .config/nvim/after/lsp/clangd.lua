return {
  cmd = {
    "clangd",
    "--log=error",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--limit-references=5000",
    "--limit-results=500",
  },
  capabilities = {
    general = {
      positionEncodings = { "utf-16" },
    },
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-16" },
  },
}
