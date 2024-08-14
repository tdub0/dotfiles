return {
  -- Set lualine as statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    opts = {
      options = {
        icons_enabled = true,
        -- theme = "everforest",
        theme = "catppuccin",
        component_separators = "|",
        section_separators = "",
      },
    },
  },
}
