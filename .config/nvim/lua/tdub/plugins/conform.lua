return {
  {
    "stevearc/conform.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
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
          python = { "isort", "black" },
          sh = { "shfmt" },
          yaml = { "yamlfmt" },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { async = false, lsp_fallback = true, quiet = false, timeout_ms = 3000 }
        end,
      })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
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

      vim.keymap.set("n", "<leader>uD", "<cmd>FormatDisable<CR>", { desc = "[D]isable formatting" })
      vim.keymap.set("n", "<leader>uE", "<cmd>FormatEnable<CR>", { desc = "[E]nable formatting" })

      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        conform.format({
          async = false,
          lsp_fallback = true,
          quiet = false,
          timeout_ms = 3000,
        })
      end, { desc = "[c]ode [f]ormat file or range" })
      vim.keymap.set({ "n", "v" }, "<leader>f", function()
        conform.format({
          async = false,
          lsp_fallback = true,
          quiet = false,
          timeout_ms = 3000,
        })
      end, { desc = "[f]ormat file or range" })
    end,
  },
}
