return {
  {
    "tamago324/lir.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      local actions = require("lir.actions")
      local mark_actions = require("lir.mark.actions")
      local clipboard_actions = require("lir.clipboard.actions")

      -- disabling netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("lir").setup({
        show_hidden_files = false,
        ignore = {},
        devicons = {
          enable = true,
          highlight_dirname = true,
        },
        mappings = {
          ["l"] = actions.edit,
          ["<C-s>"] = actions.split,
          ["<C-v>"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,

          ["h"] = actions.up,
          ["q"] = actions.quit,

          ["K"] = actions.mkdir,
          ["N"] = actions.newfile,
          ["R"] = actions.rename,
          ["@"] = actions.cd,
          ["Y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["D"] = actions.delete,

          ["J"] = function()
            mark_actions.toggle_mark("n")
            vim.cmd("normal! j")
          end,
          ["C"] = clipboard_actions.copy,
          ["X"] = clipboard_actions.cut,
          ["P"] = clipboard_actions.paste,
        },
        float = {
          winblend = 0,
          curdir_window = {
            enable = true,
            highlight_dirname = true,
          },
        },
        on_init = function() end,
        hide_cursor = true,
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "lir" },
        callback = function()
          -- use visual mode
          vim.api.nvim_buf_set_keymap(
            0,
            "x",
            "J",
            ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
            { noremap = true, silent = true }
          )

          -- echo cwd
          vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
        end,
      })

      local map = vim.keymap.set
      map("n", "<leader>pv", ":lua require('lir.float').toggle()<CR>", { desc = "toggle explorer" })
      map("n", "<leader>et", ":lua require('lir.float').toggle()<CR>", { desc = "[e]xplorer [t]oggle" })
      map("n", "<leader>ei", ":lua require('lir.float').init()<CR>", { desc = "[e]xplorer [i]nit" })
      map("n", "<leader>ef", ":edit .<CR>", { desc = "[e]xplorer cwd [f]iles" })
    end,
  },
  {
    "tamago324/lir-git-status.nvim",
    config = function()
      local lir_git_status = require("lir.git_status")
      lir_git_status.setup({
        show_hidden_files = false,
      })
    end,
  },
}
