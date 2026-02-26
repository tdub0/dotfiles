return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when vim.uv is referenced
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
