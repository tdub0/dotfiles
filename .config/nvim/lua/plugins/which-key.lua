return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>b", group = "buffer" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "diagnostics" },
          { "<leader>e", group = "explorer" },
          { "<leader>g", group = "git" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>sg", group = "git" },
          { "<leader>u", group = "undo/ui" },
          { "<leader>w", group = "windows" },
          { "<leader>x", group = "quickfix" },
          { "<leader><tab>", group = "tabs" },
        },
      },
    },
  },
}
