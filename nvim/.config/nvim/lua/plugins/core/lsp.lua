return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      --------------------------------------------------------------------
      -- Capabilities (completion etc.)
      --------------------------------------------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      --------------------------------------------------------------------
      -- Per-server configuration using vim.lsp.config()
      --------------------------------------------------------------------

      -- HTML (for Django templates too)
      vim.lsp.config("html", {
        capabilities = capabilities,
        filetypes = { "html" },
      })

      vim.lsp.config("djlsp", {
        capabilities = capabilities,
        filetypes = { "htmldjango" },
      })

      vim.lsp.config("htmx", {
        capabilities = capabilities,
        filetypes = { "htmldjango", "html" },
      })

      -- Emmet
      vim.lsp.config("emmet_ls", {
        capabilities = capabilities,
        filetypes = { "html", "css", "scss", "javascriptreact", "htmldjango" },
      })

      -- TypeScript / JavaScript
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      -- ESLint
      vim.lsp.config("eslint", {
        capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      -- Python
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      --------------------------------------------------------------------
      -- Mason + mason-lspconfig setup (installs & enables servers)
      --------------------------------------------------------------------
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "html",
          "djlsp",
          "htmx",
          "emmet_ls",
          "ts_ls",
          "eslint",
          "pyright",
        },
      })
    end,
  },
}

