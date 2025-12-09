return {
  "Mofiqul/vscode.nvim",
  lazy = false,        -- load during startup
  priority = 1000,     -- load before other UI plugins
  config = function()
    -- make sure truecolor is on
    vim.o.termguicolors = true

    -- dark or light
    vim.o.background = "dark"   -- or "light"

    local c = require("vscode.colors").get_colors()

    require("vscode").setup({
      -- VS Code-like defaults; tweak to taste
      transparent = false,
      italic_comments = true,
      italic_inlayhints = true,
      underline_links = true,
      disable_nvimtree_bg = true,
      terminal_colors = true,

      -- examples; optional
      -- color_overrides = {
      --   vscLineNumber = "#FFFFFF",
      -- },
      -- group_overrides = {
      --   Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
      -- },
    })

    -- recommended way to apply it
    vim.cmd.colorscheme("vscode")
  end,
}
