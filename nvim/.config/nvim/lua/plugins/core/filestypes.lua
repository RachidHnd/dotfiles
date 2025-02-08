return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "html", "python", "javascript" },
        highlight = { enable = true },
      })
    end,
  },

  -- Filetype-specific adjustments
  {
    "nvim-treesitter/playground",
    config = function()
      vim.cmd([[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]])
    end,
  },
}

