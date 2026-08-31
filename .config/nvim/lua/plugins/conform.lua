return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>uD", "<cmd>FormatDisable<CR>", desc = "[D]isable formatting" },
      { "<leader>uE", "<cmd>FormatEnable<CR>", desc = "[E]nable formatting" },
    },
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters = {
          shfmt = {
            prepend_args = { "-i", "4" },
          },
        },
        formatters_by_ft = {
          lua = { "stylua" },
          -- ruff CLI fixes imports
          -- ruff LSP formats
          python = {
            "ruff_fix",
            "ruff_organize_imports",
            lsp_format = "prefer",
          },
          sh = { "shfmt" },
          yaml = { "yamlfmt" },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { lsp_format = "fallback", quiet = false, timeout_ms = 3000 }
        end,
      })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })

      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        conform.format({
          lsp_format = "fallback",
          quiet = false,
          timeout_ms = 3000,
        })
      end, { desc = "[c]ode [f]ormat file or range" })
      vim.keymap.set({ "n", "v" }, "<leader>f", function()
        conform.format({
          lsp_format = "fallback",
          quiet = false,
          timeout_ms = 3000,
        })
      end, { desc = "[f]ormat file or range" })
    end,
  },
}
