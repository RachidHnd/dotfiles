return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "html", "emmet_ls", "ts_ls", "eslint", "pyright" }, -- Add required LSP servers here
      })
      
      -- Install debug adapters via Mason
      local mason_registry = require("mason-registry")
      local debuggers = { "codelldb", "debugpy" }
      
      for _, debugger in ipairs(debuggers) do
        if not mason_registry.is_installed(debugger) then
          vim.cmd("MasonInstall " .. debugger)
        end
      end
    end,
  },
}

