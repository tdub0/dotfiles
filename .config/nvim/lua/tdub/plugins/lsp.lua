-- LSP settings
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
  nmap("<leader>cl", require("snacks.picker").lsp_config, "[l]sp info")
  nmap("<leader>cr", vim.lsp.buf.rename, "[r]ename")
  nmap("<leader>cR", require("snacks.rename").rename_file, "[r]ename")

  nmap("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
  nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
  nmap("gy", vim.lsp.buf.type_definition, "[g]oto t[y]pe definition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")
  nmap("K", vim.lsp.buf.hover, "hover help")
  nmap("gK", vim.lsp.buf.signature_help, "signature help")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[w]orkspace [l]ist folders")
  if client.supports_method("textDocument/inlayHint") then
    nmap("<leader>uh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
    end, "toggle inlay [h]ints")
  end
end

-- enable the following language servers
local language_servers = {
  ansiblels = {},
  clangd = {},
  docker_compose_language_service = {},
  dockerls = {},
  gopls = {},
  harper_ls = {
    ["harper-ls"] = {
      linters = {
        spell_check = true,
        spelled_numbers = false,
        an_a = true,
        sentence_capitalization = true,
        unclosed_quotes = true,
        wrong_quotes = false,
        long_sentences = true,
        repeated_words = true,
        spaces = true,
        matcher = true,
      },
    },
  },
  lua_ls = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      doc = {
        privateName = { "^_" },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
      workspace = { checkThirdParty = false },
    },
  },
  basedpyright = {
    basedpyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
    },
  },
  ruff = {},
  rust_analyzer = {},
}

return {
  -- mason for installing lsps and tools
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
          "ansible-language-server", -- ansible lsp
          "ansible-lint", -- ansible linter
          "clangd", -- c/c++
          "cmakelint", -- cmake linter
          "docker-compose-language-service", -- docker compose lsp
          "dockerfile-language-server", -- dockerfile lsp
          "gopls", -- go lsp
          "harper-ls", -- spell/grammar checker
          "lua-language-server", -- lua lsp
          "basedpyright", -- python
          "ruff", -- python
          "rust-analyzer", -- rust lsp
          "shellcheck", -- bash/shell linter
          "shfmt", -- shell formatter
          "yamlfmt", -- yaml formatter
          "yamllint", -- yaml linter
        },
      })
    end,
    opts = {},
  },

  -- mason lspconfig for auto installation and enabling of lsps
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- global diagnostics config
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "icons",
        },
        severity_sort = true,
        signs = true,
        float = {
          border = "rounded",
          source = "if_many",
        },
      })

      -- global lsp config
      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      for server_name, server_settings in pairs(language_servers) do
        vim.lsp.config(server_name, {
          settings = server_settings,
        })
      end

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(language_servers),
        automatic_enable = true,
      })

      -- Defer to pyright over ruff for certain lsp behavior
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client.name == "ruff" then
            -- Disable hover in favor of basedpyright
            client.server_capabilities.hoverProvider = false
          end
        end,
        desc = "LSP: Disable hover capability from Ruff",
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "text", "gitcommit" },
        callback = function()
          vim.lsp.start({
            name = "harper_ls",
            cmd = { "harper-ls", "--stdio" },
          })
        end,
      })
    end,
  },

  -- file operations for lsp
  {
    "antosha417/nvim-lsp-file-operations",
    config = true,
  },

  -- status updates for lsp
  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  -- lua completion for nvim/vim api functions
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
}