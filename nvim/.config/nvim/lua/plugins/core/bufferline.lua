return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local colors = {
      bg = "#1e1e1e",
      bg_dark = "#181818",
      bg_highlight = "#264f78",
      fg = "#d4d4d4",
      fg_dark = "#808080",
    }

    require("bufferline").setup({
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        separator_style = "thin",  -- cleaner than slant
        show_buffer_close_icons = true,
        show_close_icon = false,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        modified_icon = "●",
        buffer_close_icon = "󰅖",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 20,
        offsets = {
          {
            filetype = "NvimTree",
            text = "Explorer",
            highlight = "Directory",
            separator = true,
            text_align = "center",
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_tab_indicators = true,
        always_show_bufferline = true,
      },
      highlights = {
        fill = { bg = colors.bg_dark },
        background = { fg = colors.fg_dark, bg = colors.bg_dark },
        buffer_selected = { fg = colors.fg, bg = colors.bg, bold = true, italic = false },
        buffer_visible = { fg = colors.fg_dark, bg = colors.bg_dark },
        close_button = { fg = colors.fg_dark, bg = colors.bg_dark },
        close_button_selected = { fg = colors.fg, bg = colors.bg },
        close_button_visible = { fg = colors.fg_dark, bg = colors.bg_dark },
        indicator_selected = { fg = colors.bg_highlight, bg = colors.bg },
        modified = { fg = "#e2c08d", bg = colors.bg_dark },
        modified_selected = { fg = "#e2c08d", bg = colors.bg },
        separator = { fg = colors.bg_dark, bg = colors.bg_dark },
        separator_selected = { fg = colors.bg_dark, bg = colors.bg },
        separator_visible = { fg = colors.bg_dark, bg = colors.bg_dark },
        tab = { fg = colors.fg_dark, bg = colors.bg_dark },
        tab_selected = { fg = colors.fg, bg = colors.bg },
        tab_separator = { fg = colors.bg_dark, bg = colors.bg_dark },
        tab_separator_selected = { fg = colors.bg_dark, bg = colors.bg },
        offset_separator = { fg = colors.bg_dark, bg = colors.bg_dark },
      },
    })

    -- Clean winbar showing filename on the right
    vim.o.winbar = "%=%m %f "
  end,
}
