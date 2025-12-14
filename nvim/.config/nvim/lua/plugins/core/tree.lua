local function my_on_attach(bufnr)
	local api = require "nvim-tree.api"
	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set('n', '<LeftRelease>', function()
		local node = api.tree.get_node_under_cursor()
		if node.nodes ~= nil then
			-- Folder: open/close
			api.node.open.edit()
		else
			-- File: open
			api.node.open.edit()
		end
	end, { buffer = bufnr })
end


return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = {
        side = "left",
        width = 32,
        preserve_window_proportions = true,
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
          show = { file = true, folder = true, git = true, diagnostics = true },
          diagnostics_placement = "signcolumn",
          glyphs = {
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      filters = { dotfiles = false },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
      },
      diagnostics = {
        enable = false,
      },
      on_attach = my_on_attach,
    })
    -- Blend sidebar with theme + git colors
    vim.cmd([[
      highlight NvimTreeNormal guibg=NONE
      highlight NvimTreeNormalNC guibg=NONE
      highlight NvimTreeWinSeparator guifg=#313244 guibg=NONE
      highlight NvimTreeGitDirty guifg=#f9e2af
      highlight NvimTreeGitStaged guifg=#a6e3a1
      highlight NvimTreeGitNew guifg=#94e2d5
      highlight NvimTreeGitDeleted guifg=#f38ba8
    ]])
  end,
}
