return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      local oil = require("oil")

      oil.setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = true,

        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },

        float = {
          padding = 2,
          max_width = 90,
          max_height = 40,
          win_options = {
            winblend = 0,
          },
        },

        keymaps = {
          ["l"] = "actions.select",
          ["<CR>"] = "actions.select",
          ["h"] = "actions.parent",
          ["-"] = "actions.parent",
          ["q"] = "actions.close",
          ["<Esc>"] = "actions.close",
          ["."] = "actions.toggle_hidden",
          ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-v>"] = { "actions.select", opts = { vertical = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["g?"] = "actions.show_help",
          ["<C-l>"] = "actions.refresh",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["gy"] = "actions.copy_entry_path",
        },

        view_options = {
          show_hidden = true,
        },
      })

      local map = vim.keymap.set
      map("n", "<leader>et", "<cmd>Oil --float<cr>", { desc = "[e]xplorer [t]oggle" })
      map("n", "<leader>ef", "<cmd>Oil<cr>", { desc = "[e]xplorer cwd [f]iles" })
    end,
  },
}
