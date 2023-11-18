return {
  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    "nvim-telescope/telescope.nvim",
    -- cmd = "Telescope",
    lazy = false,
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
        },
        "kyazdani42/nvim-web-devicons",
      },
    },
    opts = {},
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          path_display = { "truncate " },
          mappings = {
            i = {
              ["<C-p>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })
      telescope.load_extension("fzf")

      -- set telescope keymaps
      local map = vim.keymap.set
      map("n", "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Switch Buffer" })
      map("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
      map("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
      map(
        "n",
        "<leader>sb",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        { desc = "[s]earch [b]uffers" }
      )
      map("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "[s]earch [f]iles" })
      map("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", { desc = "[s]earch [r]ecent" })
      map("n", "<leader>sgc", "<cmd>Telescope git_commits<CR>", { desc = "[s]earch [g]it [c]ommits" })
      map("n", "<leader>sgs", "<cmd>Telescope git_status<CR>", { desc = "[s]earch [g]it [s]tatus" })
      map("n", '<leader>s"', "<cmd>Telescope registers<cr>", { desc = "[s]earch registers" })
      map("n", "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "[s]earch [a]uto commands" })
      map("n", "<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "[s]earch current buffer" })
      map("n", "<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "[s]earch [c]ommand history" })
      map("n", "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "[s]earch [C]ommands" })
      map("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "[s]earch buffer [d]iagnostics" })
      map("n", "<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "[s]earch workspace [d]iagnostics" })
      map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "[s]earch [h]elp" })
      map("n", "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "[s]earch [H]ighlight Groups" })
      map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "[s]earch [k]ey maps" })
      map("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "[s]earch [m]an pages" })
      map("n", "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "[s]earch [m]ark" })
      map("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "[s]earch [o]ptions" })
      map("n", "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "[s]earch [R]esume" })
      map("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "[s]earch [w]ord" })
    end,
  },
}
