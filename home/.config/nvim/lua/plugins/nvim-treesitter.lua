return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter").setup()
        require("nvim-treesitter").install({ --
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
        })
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
