return {
    "mason-org/mason.nvim",
    cmd = "Mason",
    event = "VeryLazy",
    config = function()
        local mason = require("mason")
        mason.setup()
    end,
}
