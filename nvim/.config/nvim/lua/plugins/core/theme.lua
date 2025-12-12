return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.termguicolors = true
    vim.o.background = "dark"

    local c = require("vscode.colors").get_colors()

    require("vscode").setup({
      transparent = false,
      italic_comments = true,
      italic_inlayhints = true,
      underline_links = true,
      disable_nvimtree_bg = true,
      terminal_colors = true,
    })

    vim.cmd.colorscheme("vscode")
  end,
}
