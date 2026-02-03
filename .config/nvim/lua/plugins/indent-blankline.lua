return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local ibl = require("ibl")
        ibl.setup({
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
        })
    end,
}
