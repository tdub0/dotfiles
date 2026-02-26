return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      -- Configure yamllint
      local yamllint = lint.linters.yamllint
      yamllint.args = {
        '-d "{extends: default, rules: {document-start: disable}}"',
        "-",
      }

      -- check current file with ":lua print(vim.bo.filetype)"
      lint.linters_by_ft = {
        python = { "ruff" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>cn", function()
        lint.try_lint()
      end, { desc = "[c]ode li[n]t: trigger linting for current file" })
    end,
  },
}
