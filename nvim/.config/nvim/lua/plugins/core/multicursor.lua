-- lua/plugins/core/multicursor.lua
-- VSCode-like multi-cursor functionality
return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.g.VM_maps = {
        -- Ctrl+D: Select word under cursor, repeat for next occurrence
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",

        -- Select all occurrences (using leader key since Ctrl+Shift often doesn't work)
        ["Select All"] = "\\A",             -- \A to select all occurrences

        -- Add cursors up/down (using leader key alternatives)
        ["Add Cursor Down"] = "\\j",        -- \j to add cursor below
        ["Add Cursor Up"] = "\\k",          -- \k to add cursor above

        -- Skip/remove
        ["Skip Region"] = "<C-k>",          -- Skip current, select next
        ["Remove Region"] = "\\x",          -- \x to remove current cursor (safer than Ctrl+Shift+K)

        ["Undo"] = "u",
        ["Redo"] = "<C-r>",
      }

      -- Additional settings
      vim.g.VM_theme = "iceblue"
      vim.g.VM_highlight_matches = "underline"
      vim.g.VM_silent_exit = 0
      vim.g.VM_use_first_cursor_in_line = 1

      -- Leader for VM is \ by default
      vim.g.VM_leader = "\\"
    end,
  },
}
