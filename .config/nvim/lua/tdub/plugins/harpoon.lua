return {
  -- harpoon
  {
    "theprimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local map = vim.keymap.set
      map("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "harpoon - [a]dd file" })
      map("n", "<leader>m", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = "harpoon - [m]enu" })
      map("n", "<C-h>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "harpoon - nav file [1]" })
      map("n", "<C-j>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "harpoon - nav file [2]" })
      map("n", "<C-k>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "harpoon - nav file [3]" })
      map("n", "<C-l>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = "harpoon - nav file [4]" })
    end,
  },
}
