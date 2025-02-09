return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completion
      "hrsh7th/cmp-buffer", -- Buffer completion
      "hrsh7th/cmp-path", -- Path completion
      "saadparwaiz1/cmp_luasnip", -- Snippet completion
      "L3MON4D3/LuaSnip", -- Snippet engine
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Use LuaSnip for expanding snippets
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion
          ["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger completion
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP completion
          { name = "luasnip" }, -- Snippet completion
          { name = "buffer" }, -- Buffer completion
          { name = "path" }, -- Path completion
        }),
      })
    end,
  },
}

