return {
  -- Jellybeans
  {
    "metalelf0/jellybeans-nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme jellybeans-nvim]])
    end,
  },
}
