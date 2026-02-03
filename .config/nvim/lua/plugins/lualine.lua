return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        local lualine = require("lualine")
        lualine.setup({
            options = {
                theme = "pywal16-nvim",
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename", "lsp_status" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = {
                    {
                        "location",
                        fmt = function(location)
                            local line = vim.fn.line(".")
                            local total = vim.fn.line("$")
                            local col = vim.fn.charcol(".")
                            return string.format("¶%d/%d㏑ :%d", line, total, col)
                        end,
                    },
                },
            },
            tabline = {
                lualine_a = {
                    {
                        "buffers",
                        mode = 2,
                        filetype_names = {
                            TelescopePrompt = "Telescope",
                            fzf = "FZF",
                            NvimTree = "NvimTree",
                        },
                        symbols = {
                            modified = " ●",
                            alternate_file = "",
                            directory = "  ",
                        },
                    },
                },
            },
        })
    end,
}
