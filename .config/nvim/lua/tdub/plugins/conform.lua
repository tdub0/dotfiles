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
          json = { "prettierd" },
          lua = { "stylua" },
          markdown = { "prettierd" },
          python = { "isort", "black" },
          sh = { "shfmt" },
          yaml = { "yamlfmt" },
        },
        format_on_save = {
          async = false,
          lsp_fallback = true,
          quiet = false,
          timeout_ms = 3000,
        },
      })

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
