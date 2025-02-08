return({
  {
    'Mofiqul/vscode.nvim',
    config = function()
      -- Enable true colors
      vim.opt.termguicolors = true
      
      -- Set the colorscheme
      vim.cmd('colorscheme vscode')

      -- Optional: Set the variant (dark or light)
      -- Uncomment one of the following lines based on preference:
      
      -- vim.g.vscode_style = "dark"  -- Dark mode
      -- vim.g.vscode_style = "light" -- Light mode
      
      -- Optional: Enable transparent background
      -- vim.g.vscode_transparent = 1

      -- Optional: Disable nvim-tree background color
      -- vim.g.vscode_disable_nvimtree_bg = true
    end
  }
})

