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
                "diff", --
                "dockerfile", --
                "editorconfig", --
                "ini", --
                "json", --
                "json5", --
                "ssh_config", --
                "toml", --
                "yaml", --
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
