return {
  {
    "catppuccin/nvim",
    lazy = false, -- load this during startup
    priority = 1000, -- with high priority
    config = function()
      vim.cmd([[colorscheme catppuccin-macchiato]])
    end,
  },
}
