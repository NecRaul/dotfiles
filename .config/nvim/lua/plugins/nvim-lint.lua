return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        vim.list_extend(lint.linters.gitlint.args, {
            "--config",
            vim.fn.expand("~/.gitlint"),
        })
        vim.list_extend(lint.linters.luacheck.args, {
            "--config",
            vim.fn.expand("~/.config/nvim/luacheckrc"),
        })

        lint.linters_by_ft = {
            dockerfile = { "hadolint" },
            dotenv = { "dotenv_linter" },
            editorconfig = { "editorconfig-checker" },
            ghaction = { "actionlint" },
            gitcommit = { "gitlint" },
            html = { "htmlhint" },
            javascript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            kotlin = { "ktlint" },
            json = { "jsonlint" },
            lua = { "luacheck" },
            make = { "checkmake" },
            markdown = { "markdownlint-cli2" },
            python = { "ruff" },
            sh = { "shellcheck" },
            typescript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            vue = { "eslint_d" },
            yaml = { "yamllint" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
                require("lint").try_lint("typos")
                require("lint").try_lint("gitleaks")
            end,
        })
    end,
}
