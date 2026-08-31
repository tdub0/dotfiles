return {
  workspace_required = true,
  settings = {
    gopls = {
      directoryFilters = { "-.git", "-node_modules" },
    },
  },
}
