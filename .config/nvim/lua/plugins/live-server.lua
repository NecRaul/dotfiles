return {
    "barrettruth/live-server.nvim",
    build = "npm install -g live-server",
    cmd = "LiveServerToggle",
    config = function()
        local live_server = require("live-server")
        live_server.setup()
    end,
}
