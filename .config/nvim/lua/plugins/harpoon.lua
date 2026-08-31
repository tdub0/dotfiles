return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>a",
          function()
            require("harpoon"):list():add()
          end,
          desc = "harpoon - [a]dd file",
        },
        {
          "<leader>m",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "harpoon - [m]enu",
        },
        {
          "<C-h>",
          function()
            require("harpoon"):list():select(1)
          end,
        },
        {
          "<C-j>",
          function()
            require("harpoon"):list():select(2)
          end,
        },
        {
          "<C-k>",
          function()
            require("harpoon"):list():select(3)
          end,
        },
        {
          "<C-l>",
          function()
            require("harpoon"):list():select(4)
          end,
        },
      }
      return keys
    end,
  },
}
