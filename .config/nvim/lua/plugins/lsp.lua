return {
  -- mason: installs LSP server binaries and other tooling
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    cmd = "Mason",
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
      require("mason-tool-installer").setup({
        ensure_installed = {
          "ansible-language-server",
          "ansible-lint",
          "clangd",
          "docker-compose-language-service",
          "dockerfile-language-server",
          "gopls",
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
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Shared capabilities: merge nvim-cmp completion items into all servers
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )
      capabilities.positionEncodings = { "utf-8", "utf-16" }
      vim.lsp.config("*", { capabilities = capabilities })

      -- Global diagnostics
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      })

      -- LSP keymaps and inlay hints (runs once per buffer on attach)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("tdub-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", function()
            Snacks.picker.lsp_definitions()
          end, "[g]oto [d]efinition")
          map("gr", function()
            Snacks.picker.lsp_references()
          end, "[g]oto [r]eferences")
          map("gI", function()
            Snacks.picker.lsp_implementations()
          end, "[g]oto [i]mplementation")
          map("gy", function()
            Snacks.picker.lsp_type_definitions()
          end, "[g]oto t[y]pe definition")
          map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
          map("K", vim.lsp.buf.hover, "Hover")
          map("gK", vim.lsp.buf.signature_help, "Signature Help")
          map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
          map("<leader>cl", function()
            Snacks.picker.lsp_config()
          end, "[l]sp info")
          map("<leader>cr", vim.lsp.buf.rename, "[r]ename")
          map("<leader>cR", function()
            Snacks.rename.rename_file()
          end, "[r]ename file")
          map("<leader>ss", function()
            Snacks.picker.lsp_symbols()
          end, "[s]ymbols")
          map("<leader>sS", function()
            Snacks.picker.lsp_workspace_symbols()
          end, "[S]ymbols (Workspace)")
          map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
          map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
          map("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "[w]orkspace [l]ist folders")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            map("<leader>uh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle Inlay Hints")
          end
        end,
      })

      -- Minimal configs for servers that need no custom settings.
      -- lsp/*.lua handles servers that do (clangd, lua_ls, harper_ls, basedpyright, ruff).
      for _, server in ipairs({
        "ansiblels",
        "docker_compose_language_service",
        "dockerls",
        "gopls",
        "rust_analyzer",
      }) do
        vim.lsp.config(server, {})
      end

      -- Enable servers; complex configs are in lsp/*.lua
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
