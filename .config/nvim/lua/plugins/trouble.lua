return {
    "folke/trouble.nvim",
    lazy = false,
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
        vim.keymap.set("n", "<leader>dt", function()
            trouble.toggle("diagnostics")
        end, { desc = "Open [D]iagnostics with [T]rouble" })
    end,
}
