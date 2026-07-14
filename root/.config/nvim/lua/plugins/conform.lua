return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
        local conform = require("conform")
        conform.setup({
            notify_on_error = false,
            formatters_by_ft = {
                css = { "prettier" },
                html = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                json = { "prettier" },
                json5 = { "prettier" },
                jsonc = { "prettier" },
                less = { "prettier" },
                sass = { "prettier" },
                scss = { "prettier" },
                sh = { "shfmt" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                vue = { "prettier" },
                yaml = { "prettier" },
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_fallback = true,
            },
        })
        vim.keymap.set("n", "<leader>f", function()
            conform.format({ async = true, lsp_format = "fallback" })
        end, { desc = "[F]ormat buffer" })
    end,
}
