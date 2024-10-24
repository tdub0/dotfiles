return {
  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
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
          { "<leader>]", group = "next" },
          { "<leader>[", group = "prev" },
          { "<leader><tab>", group = "tabs" },
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        wk.register(opts.defaults)
      end
    end,
  },
}
