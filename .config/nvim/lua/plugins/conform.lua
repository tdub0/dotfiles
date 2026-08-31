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

      -- gq uses the same formatters as <leader>cf
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

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

      local format_opts = { lsp_format = "fallback", quiet = false, timeout_ms = 3000 }

      local function range_from_marks()
        local start_mark = vim.api.nvim_buf_get_mark(0, "<")
        local end_mark = vim.api.nvim_buf_get_mark(0, ">")
        if start_mark[1] == 0 or end_mark[1] == 0 then
          return nil
        end
        if
          start_mark[1] > end_mark[1]
          or (start_mark[1] == end_mark[1] and start_mark[2] > end_mark[2])
        then
          start_mark, end_mark = end_mark, start_mark
        end
        local end_line = vim.api.nvim_buf_get_lines(0, end_mark[1] - 1, end_mark[1], true)[1] or ""
        return {
          start = { start_mark[1], start_mark[2] },
          ["end"] = { end_mark[1], math.min(end_mark[2], #end_line) },
        }
      end

      -- which-key leaves Visual before a nested <leader>cf mapping runs
      -- Keep the span so Format still range-formats after that
      local recent_visual = { buf = -1, ns = 0, range = nil }
      vim.api.nvim_create_autocmd("ModeChanged", {
        group = vim.api.nvim_create_augroup("tdub_conform_visual", { clear = true }),
        pattern = "[vV\x16]:*",
        callback = function()
          local range = range_from_marks()
          if not range then
            return
          end
          recent_visual.buf = vim.api.nvim_get_current_buf()
          recent_visual.ns = vim.uv.hrtime()
          recent_visual.range = range
        end,
      })

      local function take_recent_visual_range()
        if recent_visual.range == nil then
          return nil
        end
        if recent_visual.buf ~= vim.api.nvim_get_current_buf() then
          return nil
        end
        if vim.uv.hrtime() - recent_visual.ns > 2e9 then
          recent_visual.range = nil
          return nil
        end
        local range = recent_visual.range
        recent_visual.range = nil
        return range
      end

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.range > 0 then
          recent_visual.range = nil
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1] or ""
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, #end_line },
          }
        else
          range = take_recent_visual_range()
        end
        conform.format(vim.tbl_extend("force", format_opts, { range = range }))
      end, { range = true, desc = "Format buffer or range" })

      -- String rhs, not a Lua callback, and not lazy keys
      -- Visual `:` prepends '<,'> so Format gets the selection
      vim.keymap.set("n", "<leader>cf", "<cmd>Format<cr>", {
        desc = "[c]ode [f]ormat file or range",
        silent = true,
      })
      vim.keymap.set("x", "<leader>cf", ":Format<CR>", {
        desc = "[c]ode [f]ormat file or range",
        silent = true,
      })
    end,
  },
}
