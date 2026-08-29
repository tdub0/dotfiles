return {
  -- mason: installs LSP server binaries and other tooling
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 100,
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      -- GitHub-release packages install without extra toolchains.
      -- npm/go packages are only requested when those compilers exist, so a
      -- host without node/go does not error on every startup. vim.lsp.enable
      -- below still lists the servers; they simply never attach if missing.
      local ensure_installed = {
        "ansible-lint",
        "clangd",
        "harper-ls",
        "lua-language-server",
        "stylua",
        "basedpyright",
        "ruff",
        "rust-analyzer",
        "shellcheck",
        "shfmt",
        "yamlfmt",
        "yamllint",
      }
      if vim.fn.executable("npm") == 1 then
        vim.list_extend(ensure_installed, {
          "ansible-language-server",
          "docker-compose-language-service",
          "dockerfile-language-server",
        })
      end
      if vim.fn.executable("go") == 1 then
        ensure_installed[#ensure_installed + 1] = "gopls"
      end
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
        run_on_start = true,
        start_delay = 500,
        auto_update = false,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
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

      -- 0.12 already issues viewport (range) token requests when the server
      -- supports them, then follows up with a full-document map. Drop the
      -- full/delta requests so long-lived clangd/rust-analyzer sessions do
      -- not keep a token map for every line of every open buffer.
      local function prefer_viewport_semantic_tokens(client)
        if client._tdub_viewport_tokens then
          return
        end
        client._tdub_viewport_tokens = true
        local provider = client.server_capabilities.semanticTokensProvider
        if type(provider) ~= "table" or not provider.range then
          return
        end
        local orig = client.request
        function client.request(self, method, params, handler, bufnr)
          if
            method == "textDocument/semanticTokens/full"
            or method == "textDocument/semanticTokens/full/delta"
          then
            return false
          end
          return orig(self, method, params, handler, bufnr)
        end
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("tdub-lsp-attach", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client then
            prefer_viewport_semantic_tokens(client)
            if
              client:supports_method("textDocument/inlayHint")
              and not vim.b[event.buf].tdub_lsp_inlay
            then
              vim.b[event.buf].tdub_lsp_inlay = true
              vim.keymap.set("n", "<leader>uh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
              end, { buffer = event.buf, desc = "LSP: Toggle Inlay Hints" })
            end
          end

          -- Keymaps once per buffer; extra clients (ruff + basedpyright) must
          -- not rebind or re-require telescope.
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
          map("<leader>cl", "<cmd>lsp<cr>", "[l]sp info")
          map("<leader>cr", vim.lsp.buf.rename, "[r]ename")
          map("<leader>cR", function()
            Snacks.rename.rename_file()
          end, "[r]ename file")
          map("<leader>ss", builtin.lsp_document_symbols, "[s]ymbols")
          map("<leader>sS", builtin.lsp_workspace_symbols, "[S]ymbols (Workspace)")
          map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
          map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
          map("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "[w]orkspace [l]ist folders")
        end,
      })

      -- lsp/*.lua supplies per-server settings; enable activates FileType attach.
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
    end,
  },
}
