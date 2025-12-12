return {
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup({
        ---Add a space between comment and the line
        padding = true,
        ---Whether the cursor should stay at its position
        sticky = true,
        ---Lines to be ignored while (un)comment
        ignore = nil,
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
          ---Line-comment toggle keymap
          line = 'gcc',
          ---Block-comment toggle keymap
          block = 'gbc',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap
          line = 'gc',
          ---Block-comment keymap
          block = 'gb',
        },
        ---LHS of extra mappings
        extra = {
          ---Add comment on the line above
          above = 'gcO',
          ---Add comment on the line below
          below = 'gco',
          ---Add comment at the end of line
          eol = 'gcA',
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
          ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = true,
          ---Extra mapping; `gco`, `gcO`, `gcA`
          extra = true,
        },
        ---Function to call before (un)comment
        pre_hook = nil,
        ---Function to call after (un)comment
        post_hook = nil,
      })

      -----------------------------------------------------------
      -- VSCODE-STYLE COMMENT KEYBINDINGS
      -----------------------------------------------------------
      local api = require('Comment.api')
      
      -- Ctrl+/ for line comments (VSCODE)
      -- Note: In terminals, Ctrl+/ is sent as Ctrl+_ 
      vim.keymap.set('n', '<C-_>', api.toggle.linewise.current, { desc = 'Comment line' })
      vim.keymap.set('n', '<C-/>', api.toggle.linewise.current, { desc = 'Comment line' })
      
      -- Ctrl+/ for visual mode line comments
      vim.keymap.set('v', '<C-_>', function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.linewise(vim.fn.visualmode())
      end, { desc = 'Comment selection' })
      
      vim.keymap.set('v', '<C-/>', function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.linewise(vim.fn.visualmode())
      end, { desc = 'Comment selection' })
      
      -- Shift+Alt+A for block comments (VSCODE)
      vim.keymap.set('n', '<S-A-a>', api.toggle.blockwise.current, { desc = 'Comment block' })
      vim.keymap.set('n', '<S-M-a>', api.toggle.blockwise.current, { desc = 'Comment block' })
      
      vim.keymap.set('v', '<S-A-a>', function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.blockwise(vim.fn.visualmode())
      end, { desc = 'Comment block selection' })
      
      vim.keymap.set('v', '<S-M-a>', function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.blockwise(vim.fn.visualmode())
      end, { desc = 'Comment block selection' })
    end,
  },
}
