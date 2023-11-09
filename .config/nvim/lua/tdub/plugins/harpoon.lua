return {
  -- harpoon
  {
    "theprimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local keymap = vim.keymap
      keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "harpoon - [a]dd file" })
      keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
        { desc = "harpoon - [m]enu" }
      )
      keymap.set(
        "n",
        "<leader>h",
        "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
        { desc = "harpoon - nav file [1]" }
      )
      keymap.set(
        "n",
        "<leader>j",
        "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
        { desc = "harpoon - nav file [2]" }
      )
      keymap.set(
        "n",
        "<leader>k",
        "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
        { desc = "harpoon - nav file [3]" }
      )
      keymap.set(
        "n",
        "<leader>l",
        "<cmd>lua require('harpoon.ui').nav_file(4)<cr>",
        { desc = "harpoon - nav file [4]" }
      )
    end,
  },
}
