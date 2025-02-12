return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- HTML LSP (Django Templates)
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html"},
      })

      lspconfig.djlsp.setup({
        capabilities = capabilities,
        filetypes = { "htmldjango" },
      })

      lspconfig.htmx.setup({
	capabilities = capabilities,
	filetypes = { "htmldjango","html"}
      })
      -- Emmet LSP for HTML/CSS editing
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { "html", "css", "scss", "javascriptreact", "htmldjango" },
      })

      -- TypeScript/JavaScript LSP
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      -- ESLint LSP
      lspconfig.eslint.setup({
        capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      -- Python LSP
      lspconfig.pyright.setup({
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
    end,
  },
}

