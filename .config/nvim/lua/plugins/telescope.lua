return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    config = function()
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "node_modules", ".git$", ".stfolder", ".stversions" },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                    n = {
                        ["j"] = actions.move_selection_next,
                        ["k"] = actions.move_selection_previous,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                git_files = {
                    show_untracked = true,
                },
            },
        })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("telescope-lsp-attach", {
                clear = true,
            }),
            callback = function(event)
                local buf = event.buf
                vim.keymap.set("n", "grr", builtin.lsp_references, {
                    buffer = buf,
                    desc = "[G]oto [R]eferences",
                })
                vim.keymap.set("n", "gri", builtin.lsp_implementations, {
                    buffer = buf,
                    desc = "[G]oto [I]mplementation",
                })
                vim.keymap.set("n", "grd", builtin.lsp_definitions, {
                    buffer = buf,
                    desc = "[G]oto [D]efinition",
                })
                vim.keymap.set("n", "grt", builtin.lsp_type_definitions, {
                    buffer = buf,
                    desc = "[G]oto [T]ype Definition",
                })
                vim.keymap.set("n", "gW", builtin.lsp_dynamic_workspace_symbols, {
                    buffer = buf,
                    desc = "Open Workspace Symbols",
                })
                vim.keymap.set("n", "gO", builtin.lsp_document_symbols, {
                    buffer = buf,
                    desc = "Open Document Symbols",
                })
            end,
        })
    end,
}
