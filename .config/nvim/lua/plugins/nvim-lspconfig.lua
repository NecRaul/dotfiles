return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {},
        },
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "j-hui/fidget.nvim",
            opts = {
                progress = { ignore = { "lua_ls", "jdtls" } },
            },
        },
        "saghen/blink.cmp",
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("nvim-lsp-attach", {
                clear = true,
            }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, {
                        buffer = event.buf,
                        desc = "LSP: " .. desc,
                    })
                end
                map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
                map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
                map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                map("<leader>dn", vim.diagnostic.goto_next, "Next diagnostic")
                map("<leader>dp", vim.diagnostic.goto_prev, "Previous diagnostic")
                map("<leader>df", vim.diagnostic.open_float, "Floating diagnostic")
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method("textDocument/documentHighlight", event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup("nvim-lsp-highlight", {
                        clear = false,
                    })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })
                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("nvim-lsp-detach", {
                            clear = true,
                        }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({
                                group = "nvim-lsp-highlight",
                                buffer = event2.buf,
                            })
                        end,
                    })
                end
                if client and client:supports_method("textDocument/inlayHint", event.buf) then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({
                            bufnr = event.buf,
                        }))
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

        local language_servers = {
            ["autotools-language-server"] = "autotools_ls", -- Autotools/Make/Configure
            ["bash-language-server"] = "bashls", -- Bash
            ["clangd"] = "clangd", -- C/C++
            ["css-lsp"] = "cssls", -- CSS
            ["diagnostic-languageserver"] = "diagnosticls", -- Diagnostics
            ["docker-compose-language-service"] = "docker_compose_language_service", -- Docker-Compose
            ["docker-language-server"] = "docker_language_server", -- Docker
            ["eslint-lsp"] = "eslint", -- ESLint
            ["gh-actions-language-server"] = "gh_actions_ls", -- Github Actions
            ["gopls"] = "gopls", -- Go
            ["gradle-language-server"] = "gradle_ls", -- Gradle
            ["html-lsp"] = "html", -- HTML
            ["jdtls"] = "jdtls", -- Java
            ["jq-lsp"] = "jqls", -- JQ
            ["json-lsp"] = "jsonls", -- JSON
            ["kotlin-lsp"] = "kotlin_lsp", -- Kotlin
            ["lemminx"] = "lemminx", -- XML
            ["lua-language-server"] = "lua_ls", -- Lua
            ["marksman"] = "marksman", -- Markdown
            ["omnisharp"] = "omnisharp", -- C#
            ["perlnavigator"] = "perlnavigator", -- Perl
            ["postgres-language-server"] = "postgres_lsp", -- PostgreSQL
            ["ruff"] = "ruff", -- Python
            ["rust-analyzer"] = "rust_analyzer", -- Rust
            ["some-sass-language-server"] = "somesass_ls", -- SCSS/SASS
            ["stylua"] = "stylua", -- Lua
            ["tailwindcss-language-server"] = "tailwindcss", -- TailwindCSS
            ["taplo"] = "taplo", -- TOML
            ["ty"] = "ty", -- Python
            ["typescript-language-server"] = "ts_ls", -- Javascript/Typescript
            ["vue-language-server"] = "vue_ls", -- Vue
            ["yaml-language-server"] = "yamlls", -- YAML
            ["zls"] = "zls", -- Zig
        }

        local linters = { --
            "actionlint", -- Github Actions
            "checkmake", -- Make
            "dotenv-linter", -- dotenv
            "editorconfig-checker", -- editorconfig
            "eslint_d", -- Javascript/Typescript
            "gitleaks", -- git secrets
            "gitlint", -- COMMIT_EDITMSG
            "hadolint", -- Dockerfile
            "htmlhint", -- HTML
            "jsonlint", -- JSON
            "ktlint", -- Kotlin
            "luacheck", -- Lua
            "markdownlint-cli2", -- Markdown
            "postgres-language-server", -- SQL
            "shellcheck", -- Bash
            "typos", -- Spellcheck
            "yamllint", -- YAML
        }

        local formatters = { --
            "clang-format", -- C/C++
            "csharpier", -- C#
            "gersemi", -- CMake
            "goimports", -- Go
            "jq", -- JQ
            "markdownlint-cli2", -- Markdown
            "prettier", -- HTML/CSS/Javascript/Typescript/JSX/TSX/Vue/JSON/JSON5/JSONC/YAML/SASS/SCSS/Less
            "rustywind", -- Tailwind CSS
            "shfmt", -- Bash
            "stylua", -- Lua
            "taplo", -- TOML
            "xmlformatter", -- XML
        }

        local optional = {
            "codebook", -- Spellcheck
        }

        local ensure_installed = vim.tbl_keys(language_servers)
        vim.list_extend(ensure_installed, linters)
        vim.list_extend(ensure_installed, formatters)
        vim.list_extend(ensure_installed, optional)

        require("mason-tool-installer").setup({
            ensure_installed = ensure_installed,
        })

        for _, lsp_name in pairs(language_servers) do
            vim.lsp.enable(lsp_name)
        end

        vim.lsp.config("taplo", {
            filetypes = { "toml" },
            root_dir = require("lspconfig.util").root_pattern("*.toml", ".git"),
        })

        vim.lsp.config("lua_ls", {
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath("config")
                        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                    then
                        return
                    end
                end
                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = {
                        version = "LuaJIT",
                        path = { "lua/?.lua", "lua/?/init.lua" },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = vim.tbl_filter(function(d)
                            return not d:match(vim.fn.stdpath("config") .. "/?a?f?t?e?r?")
                        end, vim.api.nvim_get_runtime_file("", true)),
                    },
                })
            end,
            settings = {
                Lua = {},
            },
        })
    end,
}
