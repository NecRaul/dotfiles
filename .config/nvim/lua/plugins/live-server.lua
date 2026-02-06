return {
    "barrettruth/live-server.nvim",
    build = "npm install -g live-server",
    cmd = "LiveServerToggle",
    config = function()
        vim.g.live_server = {
            args = {
                "--port=5555",
            },
        }
    end,
}
