return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsings = require("gitsigns")
        gitsings.setup({
            current_line_blame = true,
        })
        vim.keymap.set("n", "<C-g><C-d>", gitsings.diffthis, {
            desc = "[G]it [D]iff",
        })
        vim.keymap.set("n", "<C-g><C-b>", gitsings.blame, {
            desc = "[G]it [B]lame",
        })
        vim.keymap.set("n", "<C-g><C-n>", function()
            gitsings.nav_hunk("next")
        end, { desc = "[G]it Hunk [N]ext" })
        vim.keymap.set("n", "<C-g><C-p>", function()
            gitsings.nav_hunk("prev")
        end, { desc = "[G]it Hunk [P]rev" })
    end,
}
