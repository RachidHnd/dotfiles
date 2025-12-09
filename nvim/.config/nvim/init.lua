vim.g.mapleader = " "

require("config.ui")
require("plugins.lazy")
require("config.keymaps")
-- save on insert mode with ctrl+s 

vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>gi', { noremap = true, silent = true })

-- Example mappings using the leader key
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })


-- Make ctrl u and ctrl d set cursor in the middle
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })


vim.o.number = true
vim.o.relativenumber = true

-- Toggle the tree visibility
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Find the current file in the tree
vim.api.nvim_set_keymap('n', '<leader>f', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-- Refresh the tree to reflect any external changes

-- Create a new file in the directory
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeCreate<CR>', { noremap = true, silent = true })

-- Rename the selected file
vim.api.nvim_set_keymap('n', '<leader>rn', ':NvimTreeRename<CR>', { noremap = true, silent = true })

-- Delete the selected file
vim.api.nvim_set_keymap('n', '<leader>d', ':NvimTreeRemove<CR>', { noremap = true, silent = true })

-- Collapse all folders in the tree
vim.api.nvim_set_keymap('n', '<leader>c', ':NvimTreeCollapse<CR>', { noremap = true, silent = true })

-- Move up to the parent directory
vim.api.nvim_set_keymap('n', '<leader>p', ':NvimTreeDirUp<CR>', { noremap = true, silent = true })

-- Open the selected file or directory
vim.api.nvim_set_keymap('n', '<CR>', ':NvimTreeOpen<CR>', { noremap = true, silent = true })

-- Close the tree window if it’s the last one open
vim.api.nvim_set_keymap('n', '<leader>q', ':NvimTreeClose<CR>', { noremap = true, silent = true })
-- Focus on nvim-tree when you're in a file

vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeFocus<CR>', { noremap = true, silent = true })

-- Navigate to the next buffer
vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
-- Navigate to the previous buffer
vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
-- Close the current buffer
vim.api.nvim_set_keymap('n', '<Leader>bd', ':bdelete<CR>', { noremap = true, silent = true })


vim.g.clipboard = {
  name = "win32yank",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = 0,
}
vim.o.guifont = "FiraCode Nerd Font:h15"
