return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
        local trouble = require("trouble")
        trouble.setup({
            modes = {
                diagnostics = {
                    auto_open = false,
                    auto_close = false,
                    auto_preview = false,
                    auto_refresh = true,
                    focus = false,
                    restore = false,
                    follow = true,
                    indent_guides = true,
                    sort = false,
                    group = false,
                },
            },
        })
    end,
}
