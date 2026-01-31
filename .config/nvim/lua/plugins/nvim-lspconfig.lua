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
            opts = {},
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
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        local language_servers = { --
            "autotools-language-server", -- Autotools/Make/Configure
            "bash-language-server", -- Bash
            "clangd", -- C/C++
            "csharp-language-server", -- C#
            "css-lsp", -- CSS
            "diagnostic-languageserver", -- Diagnostics
            "docker-language-server", -- Docker/Docker-Compose
            "eslint-lsp", -- ESLint
            "gh-actions-language-server", -- GitHub Actions
            "gopls", -- Go
            "gradle-language-server", -- Gradle
            "groovy-language-server", -- Groovy
            "html-lsp", -- HTML
            "jdtls", -- Java
            "jq-lsp", -- JQ
            "json-lsp", -- JSON
            "lemminx", -- XML
            "lua-language-server", -- Lua
            "marksman", -- Markdown
            "perlnavigator", -- Perl
            "phpactor", -- PHP
            "postgres-language-server", -- SQL
            "ruff", -- Python
            "ty", -- Python
            "rubocop", -- Ruby
            "rust-analyzer", -- Rust
            "some-sass-language-server", -- SASS
            "stylua", -- Lua
            "systemd-lsp", -- Systemd
            "tailwindcss-language-server", -- Tailwind CSS
            "taplo", -- TOML
            "tsgo", -- Javascript, Typescript
            "vue-language-server", -- Vue
            "yaml-language-server", -- YAML
            "zls", -- Zig
        }

        local dap_adapters = { --
            "bash-debug-adapter", -- Bash
            "codelldb", -- C/C++/Rust/Zig
            "cpptools", -- C/C++/Rust
            "debugpy", -- Python
            "firefox-debug-adapter", -- Javascript/Typescript
            "go-debug-adapter", -- Go
            "java-debug-adapter", -- Java
            "java-test", -- Java
            "js-debug-adapter", -- Javascript/Typescript
            "mockdebug", -- Mock
            "perl-debug-adapter", -- Perl
            "php-debug-adapter", -- PHP
            "local-lua-debugger-vscode", -- Lua
            "netcoredbg", -- C#
            "vscode-java-decompiler", -- Java
            "uv", -- Python
        }

        local linters = { --
            "actionlint", -- Github Actions
            "bacon", -- Rust
            "checkmake", -- Make
            "checkstyle", -- Java
            "cmakelint", -- CMake
            "gitlint", -- Git
            "dotenv-linter", -- dotenv
            "editorconfig-checker", -- editorconfig
            "eslint_d", -- Javascript/Typescript
            "gitleaks", -- git secrets
            "hadolint", -- Dockerfile
            "htmlhint", -- HTML
            "jsonlint", -- JSON
            "luacheck", -- Lua
            "markdownlint-cli2", -- Markdown
            "npm-groovy-lint", -- Groovy/Gradle
            "phpstan", -- PHP
            "postgres-language-server", -- SQL
            "rubocop", -- Ruby
            "shellcheck", -- Bash
            "staticcheck", -- Go
            "stylelint", -- CSS/SASS/SCSS/Less
            "systemdlint", -- Systemd
            "yamllint", -- YAML
        }

        local formatters = { --
            "clang-format", -- C/C++
            "csharpier", -- C#
            "gersemi", -- CMake
            "goimports", -- Go
            "google-java-format", -- Java
            "jq", -- JQ
            "markdownlint-cli2", -- Markdown
            "npm-groovy-lint", -- Groovy/Gradle
            "phpcbf", -- PHP
            "prettier", -- HTML/CSS/Javascript/Typescript/JSX/TSX/Vue/JSON/JSON5/JSONC/YAML/SASS/SCSS/Less
            "rubocop", -- Ruby
            "rustywind", -- Tailwind CSS
            "shfmt", -- Bash
            "sqlfmt", -- SQL
            "stylua", -- Lua
            "taplo", -- TOML
            "xmlformatter", -- XML
        }

        local optional = {
            "codebook", -- Spellcheck
        }

        local ensure_installed = vim.tbl_keys({})
        vim.list_extend(ensure_installed, language_servers)
        vim.list_extend(ensure_installed, dap_adapters)
        vim.list_extend(ensure_installed, linters)
        vim.list_extend(ensure_installed, formatters)
        vim.list_extend(ensure_installed, optional)

        require("mason-tool-installer").setup({
            ensure_installed = ensure_installed,
        })

        local default_config = {
            capabilities = vim.tbl_deep_extend("force", {}, capabilities, {}),
        }
        for _, name in ipairs(language_servers) do
            vim.lsp.config(name, default_config)
            vim.lsp.enable(name)
        end

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
        vim.lsp.enable("lua_ls")
    end,
}
