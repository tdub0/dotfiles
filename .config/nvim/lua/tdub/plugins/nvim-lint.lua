return {
  {
    "mfussenegger/nvim-lint",
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      -- separate flake8 linting outside of pylsp flake8
      -- pylsp flake8 uses project or global .flake8 file
      -- diagnostics from both are shown in open files
      local flake8 = lint.linters.flake8
      flake8.args = {
        "--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s",
        "--max-line-length=88",
        "--extend-ignore=E203",
        "--max-complexity=10",
        "--no-show-source",
        "-",
      }

      -- check current file with ":lua print(vim.bo.filetype)"
      lint.linters_by_ft = {
        markdown = { "markdownlint" },
        yaml = { "yamllint" },
        python = { "flake8" },
        sh = { "shellcheck" },
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
