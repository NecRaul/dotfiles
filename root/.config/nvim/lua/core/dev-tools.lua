-- lua/core/dev-tools.lua
local M = {}

M.language_servers = {
    ["bash-language-server"] = "bashls", -- Bash
    ["docker-compose-language-service"] = "docker_compose_language_service", -- Docker-Compose
}

M.linters = { --
    "editorconfig-checker", -- editorconfig
    "shellcheck", -- Bash
}

M.formatters = { --
    "prettier", -- HTML/CSS/Javascript/Typescript/JSX/TSX/Vue/JSON/JSON5/JSONC/YAML/SASS/SCSS/Less
    "shfmt", -- Bash
}

M.optional = {
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
