return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local api = require("nvim-tree.api")
        require("nvim-tree").setup({
            filters = {
                git_ignored = true,
                custom = { ".git$" },
            },
            view = {
                side = "left",
                width = 40,
            },
            hijack_cursor = true,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                highlight_modified = "all",
                root_folder_modifier = "~",
                indent_markers = {
                    enable = true,
                },
            },
            on_attach = function(bufnr)
                local function opts(desc)
                    return {
                        desc = "NvimTree: " .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true,
                    }
                end
                api.config.mappings.default_on_attach(bufnr)
                vim.keymap.set("n", "<C-t>", api.tree.toggle, opts("Toggle Tree"))
            end,
        })
    end,
}
