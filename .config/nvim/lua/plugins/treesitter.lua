return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { mode = "cursor", max_lines = 2 },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install({
        "bash",
        "c",
        "cpp",
        "diff",
        "dockerfile",
        "gitcommit",
        "gitignore",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "ninja",
        "printf",
        "python",
        "query",
        "regex",
        "rst",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      })

      -- nvim-treesitter main does not start highlighting. Start it per buffer.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("tdub_treesitter", { clear = true }),
        callback = function(event)
          pcall(vim.treesitter.start, event.buf)
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local move = require("nvim-treesitter-textobjects.move")
      local sel = require("nvim-treesitter-textobjects.select")
      local map = vim.keymap.set


      map({ "n", "x", "o" }, "]f", function()
        move.goto_next_start("@function.outer", "textobjects")
      end)
      map({ "n", "x", "o" }, "]c", function()
        move.goto_next_start("@class.outer", "textobjects")
      end)
      map({ "n", "x", "o" }, "]F", function()
        move.goto_next_end("@function.outer", "textobjects")
      end)
      map({ "n", "x", "o" }, "]C", function()
        move.goto_next_end("@class.outer", "textobjects")
      end)
      map({ "n", "x", "o" }, "[f", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end)
      map({ "n", "x", "o" }, "[c", function()
        move.goto_previous_start("@class.outer", "textobjects")
      end)
      map({ "n", "x", "o" }, "[F", function()
        move.goto_previous_end("@function.outer", "textobjects")
      end)
      map({ "n", "x", "o" }, "[C", function()
        move.goto_previous_end("@class.outer", "textobjects")
      end)


      map({ "x", "o" }, "aa", function()
        sel.select_textobject("@parameter.outer", "textobjects")
      end)
      map({ "x", "o" }, "ia", function()
        sel.select_textobject("@parameter.inner", "textobjects")
      end)
      map({ "x", "o" }, "af", function()
        sel.select_textobject("@function.outer", "textobjects")
      end)
      map({ "x", "o" }, "if", function()
        sel.select_textobject("@function.inner", "textobjects")
      end)
      map({ "x", "o" }, "ac", function()
        sel.select_textobject("@class.outer", "textobjects")
      end)
      map({ "x", "o" }, "ic", function()
        sel.select_textobject("@class.inner", "textobjects")
      end)
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
}
