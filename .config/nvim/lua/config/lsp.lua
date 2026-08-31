-- Refuse to start a server with $HOME as the workspace.
-- Force-stop hung servers 3s after :qa.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.general = capabilities.general or {}
capabilities.general.positionEncodings = { "utf-8", "utf-16" }
vim.lsp.config("*", {
  capabilities = capabilities,
  workspace_required = true,
  exit_timeout = 3000,
})

local sev = vim.diagnostic.severity
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  signs = {
    text = {
      [sev.ERROR] = "●",
      [sev.WARN] = "●",
      [sev.INFO] = "●",
      [sev.HINT] = "●",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("tdub-lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client:supports_method("textDocument/inlayHint")
      and not vim.b[event.buf].tdub_lsp_inlay
    then
      vim.b[event.buf].tdub_lsp_inlay = true
      vim.keymap.set("n", "<leader>uh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, { buffer = event.buf, desc = "LSP: Toggle Inlay Hints" })
    end

    -- Bind once. ruff and basedpyright both attach to Python.
    if vim.b[event.buf].tdub_lsp_keys then
      return
    end
    vim.b[event.buf].tdub_lsp_keys = true

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    local builtin = require("telescope.builtin")
    map("gd", builtin.lsp_definitions, "[g]oto [d]efinition")
    map("gr", builtin.lsp_references, "[g]oto [r]eferences")
    map("gI", builtin.lsp_implementations, "[g]oto [i]mplementation")
    map("gy", builtin.lsp_type_definitions, "[g]oto t[y]pe definition")
    map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
    map("K", vim.lsp.buf.hover, "Hover")
    map("gK", vim.lsp.buf.signature_help, "Signature Help")
    map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
    map("<leader>cl", "<cmd>checkhealth vim.lsp<cr>", "[l]sp info")
    map("<leader>cr", vim.lsp.buf.rename, "[r]ename")
    map("<leader>cR", function()
      Snacks.rename.rename_file()
    end, "[r]ename file")
    map("<leader>ss", builtin.lsp_document_symbols, "[s]ymbols")
    map("<leader>sS", builtin.lsp_workspace_symbols, "[S]ymbols (Workspace)")
  end,
})

vim.lsp.enable({
  "ansiblels",
  "basedpyright",
  "clangd",
  "docker_compose_language_service",
  "dockerls",
  "gopls",
  "harper_ls",
  "lua_ls",
  "ruff",
  "rust_analyzer",
})
