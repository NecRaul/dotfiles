return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            highlight = "GitSignsAdd",
        },
        whitespace = {
            highlight = "GitSignsAdd",
            remove_blankline_trail = false,
        },
        scope = {
            enabled = true,
            highlight = "GitSignsDelete",
        },
    },
}
