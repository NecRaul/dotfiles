return {
    "jake-stewart/multicursor.nvim",
    lazy = false,
    config = function()
        local multicursor = require("multicursor-nvim")
        multicursor.setup()

        vim.keymap.set("n", "<Esc><C-k>", function()
            multicursor.lineAddCursor(-1)
        end, { desc = "Add cursor above" })

        vim.keymap.set("n", "<Esc><C-j>", function()
            multicursor.lineAddCursor(1)
        end, { desc = "Add cursor below" })

        vim.keymap.set("n", "<C-k>", function()
            multicursor.lineSkipCursor(-1)
        end, { desc = "Skip cursor above" })

        vim.keymap.set("n", "<C-j>", function()
            multicursor.lineSkipCursor(1)
        end, { desc = "Skip cursor below" })

        vim.keymap.set("n", "<leader>mn", function()
            multicursor.matchAddCursor(1)
        end, { desc = "Add cursor: next match" })

        vim.keymap.set("n", "<leader>ms", function()
            multicursor.matchSkipCursor(1)
        end, { desc = "Skip cursor: next match" })

        vim.keymap.set("n", "<leader>mN", function()
            multicursor.matchAddCursor(-1)
        end, { desc = "Add cursor: prev match" })

        vim.keymap.set("n", "<leader>mS", function()
            multicursor.matchSkipCursor(-1)
        end, { desc = "Skip cursor: prev match" })

        vim.keymap.set("n", "<C-c>", multicursor.toggleCursor, { desc = "Toggle cursor" })

        vim.keymap.set("n", "<C-leftmouse>", multicursor.handleMouse, { desc = "Multicursor: mouse click" })
        vim.keymap.set("n", "<C-leftdrag>", multicursor.handleMouseDrag, { desc = "Multicursor: mouse drag" })
        vim.keymap.set("n", "<C-leftrelease>", multicursor.handleMouseRelease, { desc = "Multicursor: mouse release" })

        multicursor.addKeymapLayer(function(layerSet)
            layerSet("n", "h", multicursor.prevCursor, { desc = "Select prev cursor" })
            layerSet("n", "l", multicursor.nextCursor, { desc = "Select next cursor" })
            layerSet("n", "<leader>x", multicursor.deleteCursor, { desc = "Delete main cursor" })
            layerSet("n", "<esc>", function()
                if not multicursor.cursorsEnabled() then
                    multicursor.enableCursors()
                else
                    multicursor.clearCursors()
                end
            end, { desc = "Enable/clear cursors" })
        end)

        vim.api.nvim_set_hl(0, "MultiCursorCursor", { reverse = true })
        vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
        vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
        vim.api.nvim_set_hl(0, "MultiCursorMatchPreview", { link = "Search" })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { reverse = true })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
}
