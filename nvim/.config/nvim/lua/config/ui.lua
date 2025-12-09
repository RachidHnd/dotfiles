local opt = vim.opt
local g   = vim.g

opt.termguicolors   = true
opt.number          = true
opt.relativenumber  = true
opt.signcolumn      = "yes"
opt.cursorline      = true

opt.splitright      = true
opt.splitbelow      = true
opt.laststatus      = 3
opt.showtabline     = 2

-- Leave splits to the colorscheme:
-- (no custom fillchars/VertSplit highlight)

if vim.fn.executable("win32yank.exe") == 1 then
  g.clipboard = {
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
end

opt.guifont = "JetBrainsMono Nerd Font:h14"

