return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    -- Telescope ships no useful tags
    -- Track HEAD
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },

      { "<leader>sb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "[s]earch [b]uffers" },
      { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[s]earch [f]iles" },
      { "<leader>sgf", "<cmd>Telescope git_files<cr>", desc = "[s]earch [g]it [f]iles" },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "[s]earch [r]ecent" },

      { "<leader>sgc", "<cmd>Telescope git_commits<cr>", desc = "[s]earch [g]it [c]ommits" },
      { "<leader>sgs", "<cmd>Telescope git_status<cr>", desc = "[s]earch [g]it [s]tatus" },

      { "<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[s]earch current buffer" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "[s]earch [w]ord" },

      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "[s]earch registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "[s]earch [a]uto commands" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "[s]earch [c]ommand history" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "[s]earch [C]ommands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "[s]earch buffer [d]iagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "[s]earch workspace [d]iagnostics" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[s]earch [h]elp" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "[s]earch [H]ighlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[s]earch [k]ey maps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "[s]earch [l]ocation list" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "[s]earch [m]arks" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "[s]earch [M]an pages" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "[s]earch [o]ptions" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "[s]earch [q]uickfix" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "[s]earch [R]esume" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          file_ignore_patterns = { "%.git/" },
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
        pickers = {
          find_files = {
            hidden = true,
          },
          grep_string = {
            additional_args = { "--hidden", "--glob", "!**/.git/*" },
          },
          live_grep = {
            additional_args = { "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },
}
