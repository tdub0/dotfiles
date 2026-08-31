return {
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
      -- GitHub-release packages need no extra toolchain
      -- Ask for npm/go packages only when those compilers exist
      -- A host without them does not error on startup
      -- vim.lsp.enable still lists the servers
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
}
