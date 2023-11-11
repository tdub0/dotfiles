return {
  {
    "mfussenegger/nvim-lint",
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      -- TODO: figure out why flake8 no work through nvim-lint
      -- local flake8 = lint.linters.flake8
      -- flake8.args = {
      --   "--max-line-length=88",
      --   "--extend_ignore=E203",
      --   "--max-complexity=10",
      -- }

      lint.linters_by_ft = {
        markdown = { "markdownlint" },
        yaml = { "yamllint" },
        -- python = { "flake8" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
      end, { desc = "[c]ode [l]int: trigger linting for current file" })
    end,
  },
}
