-- lua/plugins/core/theme.lua
return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,          -- load at startup
    priority = 1000,       -- before other UI plugins
    config = function()
      -- make sure Neovim uses 24-bit colors
      vim.o.termguicolors = true
      vim.o.background = "dark"   -- or "light" if you prefer

      require("vscode").setup({
        italic_comments   = true,
        disable_nvimtree_bg = true,
        color_overrides = {
          vscLineNumber = "#5A5A5A",
        },
      })

      -- explicitly apply the theme
      vim.cmd.colorscheme("vscode")
    end,
  },
}

