-- Keep --background-index for cross-TU navigation on large C/C++ trees
-- Store PCH on disk and run the index at low priority to bound RSS
return {
  workspace_required = true,
  cmd = {
    "clangd",
    "--log=error",
    "--background-index",
    "--background-index-priority=low",
    "--pch-storage=disk",
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
