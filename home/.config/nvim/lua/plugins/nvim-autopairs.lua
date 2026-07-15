return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local nvim_autopairs = require("nvim-autopairs")
        nvim_autopairs.setup()
    end
}
