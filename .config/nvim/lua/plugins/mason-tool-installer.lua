return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VimEnter",
    config = function()
        local mason_tool_installer = require("mason-tool-installer")
        local dev_tools = require("core.dev-tools")
        mason_tool_installer.setup({
            ensure_installed = dev_tools.get_ensure_installed(),
        })
    end,
}
