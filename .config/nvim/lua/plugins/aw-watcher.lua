return {
    "lowitea/aw-watcher.nvim",
    event = "VimEnter",
    config = function()
        local aw_watcher = require("aw_watcher")
        aw_watcher.setup({
            aw_server = {
                host = "127.0.0.1",
                port = 5600,
            },
        })
    end,
}
