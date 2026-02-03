return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local theta = require("alpha.themes.theta")
        alpha.setup(theta.config)
    end,
}
