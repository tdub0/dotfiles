-- LSP settings
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

  nmap("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
  nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "type [d]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[w]orkspace [l]ist folders")
end

-- enable the following language servers
local language_servers = {
  -- astro = {},
  -- gopls = {},
  clangd = {},
  rust_analyzer = {},
  lua_ls = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
    },
  },
  pylsp = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
        autopep8 = { enabled = false },
        flake8 = { enabled = true },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        pydocstyle = { enabled = false },
        pyflakes = { enabled = false },
        rope_autoimport = { enabled = false },
        yapf = { enabled = false },
        pylsp_mypy = { enabled = true },
        jedi_completion = { fuzzy = true },
      },
    },
  },
  -- tailwindcss = {},
}

return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
    },
    {
      "antosha417/nvim-lsp-file-operations",
      config = true,
    },
    -- Automatically install LSPs to stdpath for neovim
    {
      "williamboman/mason.nvim",
      dependencies = {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
      },
      config = function()
        local mason = require("mason")
        local mason_tool_installer = require("mason-tool-installer")
        -- enable mason and configure icons
        mason.setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        })

        mason_tool_installer.setup({
          ensure_installed = {
            "black", -- python formatter
            "flake8", -- python linter
            "isort", -- python formatter
            "markdownlint", -- markdown linter
            "prettierd", -- yaml/markdown formatter
            "shellcheck", -- bash/shell linter
            "shfmt", -- shell formatter
            "stylua", -- lua formatter
            "yamlfmt", -- yaml formatter
            "yamllint", -- yaml linter
          },
        })
      end,
      opts = {},
    },

    {
      "williamboman/mason-lspconfig.nvim",
    },

    -- Bottom right status updates for LSP on file load
    {
      "j-hui/fidget.nvim",
      opts = {},
    },

    -- Lua completion for nvim/vim api functions
    {
      "folke/neodev.nvim",
      opts = {},
    },
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(language_servers) })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          diagnostics = {
            underline = true,
            update_in_insert = false,
            virtual_text = {
              spacing = 4,
              source = "if_many",
              prefix = "●",
              -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
              -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
              -- prefix = "icons",
            },
            severity_sort = true,
          },
          capabilities = capabilities,
          on_attach = on_attach,
          settings = language_servers[server_name],
        })
      end,
    })
  end,
}
