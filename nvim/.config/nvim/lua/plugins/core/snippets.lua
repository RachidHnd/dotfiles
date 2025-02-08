return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.3.*", -- Ensure you're using a stable version
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")

      -- Load VSCode-style snippets (from friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Prebuilt snippet collection (optional)
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  },
}

