return {
  -- Mason Setup
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end,
  },

  -- Mason-LSPConfig Setup (Make sure Mason is set up before using it)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "html",         -- HTML LSP (for Django HTML)
          "emmet_ls",     -- Emmet (for HTML/CSS autocompletion)
          "ts_ls",        -- TypeScript LSP (for Alpine.js) [Updated from tsserver]
          "eslint",       -- ESLint (for Alpine.js linting)
        },
        automatic_installation = true, -- Auto install missing LSPs
      })
    end,
  },
}

