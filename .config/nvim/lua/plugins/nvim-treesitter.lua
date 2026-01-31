return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
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
    },
}
