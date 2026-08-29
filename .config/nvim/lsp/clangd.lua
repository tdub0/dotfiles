-- Keep --background-index: large C/C++ trees need the persistent index for
-- cross-TU navigation. pch-storage=disk and low index priority keep RSS down
-- while the index builds.
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
