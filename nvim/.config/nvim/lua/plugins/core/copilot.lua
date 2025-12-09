return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },       -- or "zbirenbaum/copilot.lua"
      { "nvim-lua/plenary.nvim" },    -- no need to pin branch here
    },
    build = "make tiktoken",          -- ok on Linux/macOS, or remove if you want
    opts = {
      window = {
        layout = "vertical",          -- <--- was "right"
        width = 0.35,                 -- 35% of the screen; tweak if you like
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)

      -- simple keymap
      vim.keymap.set("n", "<leader>cc", function()
        chat.toggle()
      end, { desc = "Copilot Chat" })
    end,
  },
}
