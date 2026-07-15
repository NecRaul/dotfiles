return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local nvim_tree_sitter_configs = require("nvim-treesitter.configs")
        nvim_tree_sitter_configs.setup({
            ensure_installed = { --
                "bash", --
                "c", --
                "c_sharp", --
                "cmake", --
                "comment", --
                "cpp", --
                "css", --
                "desktop", --
                "diff", --
                "dockerfile", --
                "editorconfig", --
                "git_config", --
                "git_rebase", --
                "gitattributes", --
                "gitcommit", --
                "gitignore", --
                "go", --
                "gomod", --
                "gosum", --
                "html", --
                "ini", --
                "java", --
                "javascript", --
                "jq", --
                "json", --
                "json5", --
                "lua", --
                "make", --
                "markdown", --
                "markdown_inline", --
                "perl", --
                "php", --
                "python", --
                "requirements", --
                "ruby", --
                "rust", --
                "sql", --
                "ssh_config", --
                "toml", --
                "tsx", --
                "typescript", --
                "vue", --
                "xml", --
                "yaml", --
                "zig", --
            },
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        })
    end,
}
