vim.lsp.config("clangd", {
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
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
  },
  capabilities = {
    offsetEncoding = { "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  },
})
