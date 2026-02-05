return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local gitsings = require("gitsigns")
        gitsings.setup({
            current_line_blame = true,
        })
    end,
}
