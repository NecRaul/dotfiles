return {
    "pl4gue/no-trouble.nvim",
    lazy = false,
    config = function()
        local no_trouble = require("no-trouble")
        no_trouble.setup({
            cycle = true,
            open_float = false,
            follow_cursor = true,
        })
    end,
}
