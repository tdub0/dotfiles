return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      local yamllint = lint.linters.yamllint
      yamllint.args = {
        '-d "{extends: default, rules: {document-start: disable}}"',
        "-",
      }

      -- ruff LSP owns Python lint. nvim-lint covers shell, yaml, and ansible.
      lint.linters_by_ft = {
        sh = { "shellcheck" },
        yaml = { "yamllint" },
        ["yaml.ansible"] = { "ansible_lint", "yamllint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function(event)
          if vim.bo[event.buf].buftype ~= "" then
            return
          end
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>cn", function()
        lint.try_lint()
      end, { desc = "[c]ode li[n]t: trigger linting for current file" })
    end,
  },
}
