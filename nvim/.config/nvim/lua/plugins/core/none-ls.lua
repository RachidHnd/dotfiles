return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- Djlint for Django Templates
                null_ls.builtins.formatting.djlint.with({
                    extra_args = { "--reformat" },
                }),

                -- Prettier for HTML, CSS, JSON, Markdown, YAML
                null_ls.builtins.formatting.prettier,

                -- Black for Python
                null_ls.builtins.formatting.black,

                -- GoFmt for Go
                null_ls.builtins.formatting.gofmt,

                -- Lua formatter (stylua)
                null_ls.builtins.formatting.stylua,
            },
        })

        -- Auto-format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = { "*.html", "*.htm", "*.djhtml", "*.lua", "*.py", "*.js", "*.ts", "*.json", "*.yaml", "*.css", "*.md", "*.go" },
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
}

