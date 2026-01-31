return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        vim.list_extend(lint.linters.gitlint.args, { "--config", vim.fn.expand("~/.gitlint") })
        lint.linters_by_ft = {
            _ = { "gitleaks" },
            c = { "cpplint" },
            cmake = { "cmakelint" },
            cpp = { "cpplint" },
            css = { "stylelint" },
            dockerfile = { "hadolint" },
            dockerignore = { "hadolint" },
            dotenv = { "dotenv-linter" },
            editorconfig = { "editorconfig-checker" },
            gitcommit = { "gitlint" },
            go = { "staticcheck" },
            gradle = { "npm-groovy-lint" },
            groovy = { "npm-groovy-lint" },
            html = { "htmlhint" },
            java = { "checkstyle" },
            javascript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            json = { "jsonlint" },
            less = { "stylelint" },
            lua = { "luacheck" },
            make = { "checkmake" },
            markdown = { "markdownlint-cli2" },
            php = { "phpstan" },
            python = { "ruff" },
            ruby = { "rubocop" },
            rust = { "bacon" },
            sass = { "stylelint" },
            scss = { "stylelint" },
            sh = { "shellcheck" },
            sql = { "postgres-language-server" },
            systemd = { "systemdlint" },
            typescript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            vue = { "eslint_d" },
            yaml = { "yamllint", "actionlint" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
