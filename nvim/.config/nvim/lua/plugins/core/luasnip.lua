return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").config.set_config({
        history = true, -- Keep snippet history
        updateevents = "TextChanged,TextChangedI",
      })

      -- Load friendly snippets (optional)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}

