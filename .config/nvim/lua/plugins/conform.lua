return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
        local conform = require("conform")
        conform.setup({
            notify_on_error = false,
            formatters_by_ft = {
                c = { "clang-format" },
                cmake = { "gersemi" },
                cpp = { "clang-format" },
                cs = { "csharpier" },
                css = { "prettier" },
                go = { "goimports" },
                html = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                jq = { "jq" },
                json = { "prettier" },
                json5 = { "prettier" },
                jsonc = { "prettier" },
                less = { "prettier" },
                lua = { "stylua" },
                markdown = { "markdownlint-cli2" },
                python = { "ruff_fix", "ruff_format" },
                sass = { "prettier" },
                scss = { "prettier" },
                sh = { "shfmt" },
                tailwindcss = { "rustywind" },
                toml = { "taplo" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                vue = { "prettier" },
                xml = { "xmlformatter" },
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
