-----------------------------------------------------------
--
-- VS CODE STYLE KEYMAPS FOR NEOVIM
-----------------------------------------------------------

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-----------------------------------------------------------
-- BASIC WINDOWS / VSCODE BEHAVIORS
-----------------------------------------------------------

-- Select All (Ctrl+A)
map("n", "<C-a>", "ggVG", opts)

-- Cut (Ctrl+X)
map("v", "<C-x>", '"+x', opts)
map("n", "<C-x>", '"+dd', opts)

-- Copy (Ctrl+C)
map("v", "<C-c>", '"+y', opts)

-- Paste (Ctrl+V)
map("n", "<C-v>", '"+p', opts)
map("i", "<C-v>", '<Esc>"+pa', opts)
map("v", "<C-v>", '"+p', opts)

-- Save (Ctrl+S)
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>a", opts)

-- Quit (Ctrl+Q)
map("n", "<C-q>", ":q<CR>", opts)

-----------------------------------------------------------
-- CURSOR MOVEMENT LIKE VSCODE
-----------------------------------------------------------

-- Ctrl + Arrow for word jumping
map("n", "<C-Right>", "w", opts)
map("n", "<C-Left>", "b", opts)
map("i", "<C-Right>", "<Esc>wa", opts)
map("i", "<C-Left>", "<Esc>ba", opts)

-----------------------------------------------------------
-- MOVE LINE/BLOCK UP/DOWN (VS CODE)
-----------------------------------------------------------

-- Normal mode
map("n", "<A-Up>", ":m .-2<CR>==", opts)
map("n", "<A-Down>", ":m .+1<CR>==", opts)

-- Visual mode (preserve selection)
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

-- Alternate movement using Alt + hjkl
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)

-- Indent left/right (Alt+h/l)
map("n", "<A-h>", "<<", opts)
map("n", "<A-l>", ">>", opts)
map("v", "<A-h>", "<gv", opts)
map("v", "<A-l>", ">gv", opts)

-----------------------------------------------------------
-- COMMENT TOGGLE (VS CODE CTRL + /)
-----------------------------------------------------------

map("n", "<C-/>", "gcc", { noremap = false })
map("v", "<C-/>", "gc", { noremap = false })

-----------------------------------------------------------
-- SPLITS (VSCODE STYLE)
-----------------------------------------------------------

map("n", "<C-\\>", ":vsplit<CR>", opts)
map("n", "<C-_>", ":split<CR>", opts)   -- Ctrl+Shift+- split below

-----------------------------------------------------------
-- FILE EXPLORER (NVIMTREE)
-----------------------------------------------------------

-- Open NvimTree with Enter
map("n", "<CR>", ":NvimTreeOpen<CR>", opts)

-- Focus tree
map("n", "<leader>t", ":NvimTreeFocus<CR>", opts)

-- Close tree
map("n", "<leader>q", ":NvimTreeClose<CR>", opts)

-----------------------------------------------------------
-- BUFFERLINE (TABS LIKE VS CODE)
-----------------------------------------------------------

-- Next/prev tabs
map("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)

-- Close buffer
map("n", "<Leader>bd", ":bdelete<CR>", opts)

-----------------------------------------------------------
-- TELESCOPE (VS CODE CTRL+P, CTRL+SHIFT+P, SEARCH)
-----------------------------------------------------------

map("n", "<C-p>", ":Telescope find_files<CR>", opts)        -- Quick open
map("n", "<C-S-p>", ":Telescope commands<CR>", opts)        -- Command palette
map("n", "<C-f>", ":Telescope live_grep<CR>", opts)         -- Search in files
map("n", "<Leader>r", ":Telescope oldfiles<CR>", opts)      -- Recent files

-----------------------------------------------------------
-- WINDOW NAVIGATION (VS CODE CTRL+1, CTRL+2, etc.)
-----------------------------------------------------------

map("n", "<leader>1", "1gt", opts)
map("n", "<leader>2", "2gt", opts)
map("n", "<leader>3", "3gt", opts)

-----------------------------------------------------------
-- CLIPBOARD CONFIG (WIN32YANK FOR WSL)
-----------------------------------------------------------

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

-----------------------------------------------------------
-- GUI FONT (NEOVIDE / GHOSTTY)
-----------------------------------------------------------

vim.o.guifont = "FiraCode Nerd Font:h15"

-----------------------------------------------------------
-- DEBUG KEYBINDINGS (VSCODE STYLE)
-- Note: Main debug keybindings are defined in dap.lua plugin spec
-- This ensures proper lazy-loading behavior
-----------------------------------------------------------

