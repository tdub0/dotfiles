return {
  workspace_required = true,
  settings = {
    ["rust-analyzer"] = {
      files = {
        excludeDirs = { ".git", "target", "node_modules" },
      },
    },
  },
}
