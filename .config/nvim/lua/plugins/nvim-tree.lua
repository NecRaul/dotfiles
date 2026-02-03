return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local nvim_tree = require("nvim-tree")
        nvim_tree.setup({
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
                vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>", {
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true,
                    desc = "[T]oggle Tree",
                })
            end,
        })
    end,
}
