return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")

      -- HTML LSP (Django Templates)
      lspconfig.html.setup({
        filetypes = { "html", "htmldjango" },
      })

      -- Emmet for fast HTML editing
      lspconfig.emmet_ls.setup({
        filetypes = { "html", "css", "scss", "javascriptreact", "htmldjango" },
      })

      -- TypeScript LSP (for Alpine.js) [Updated from tsserver to ts_ls]
      lspconfig.ts_ls.setup({
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      -- ESLint for Alpine.js
      lspconfig.eslint.setup({
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      -- Python LSP
      lspconfig.pylsp.setup({
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = { enabled = true, maxLineLength = 88 }, -- Auto-formatting
              pyflakes = { enabled = true }, -- Linting
              jedi_completion = { enabled = true }, -- Autocompletion
              jedi_hover = { enabled = true }, -- Hover documentation
              jedi_symbols = { enabled = true, all_scopes = true }, -- Symbol support
              mccabe = { enabled = false }, -- Cyclomatic complexity
            },
          },
        },
      })
    end,
  },
}

