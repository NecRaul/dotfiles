-- lua/core/dev-tools.lua
local M = {}

M.language_servers = {
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

M.linters = { --
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

M.formatters = { --
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

M.optional = {
    "codebook", -- Spellcheck
}

-- Returns complete ensure_installed list
function M.get_ensure_installed()
    local ensure_installed = vim.tbl_keys(M.language_servers)
    vim.list_extend(ensure_installed, M.linters)
    vim.list_extend(ensure_installed, M.formatters)
    vim.list_extend(ensure_installed, M.optional)
    return ensure_installed
end

return M
