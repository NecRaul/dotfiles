return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "j-hui/fidget.nvim",
            config = function()
                local fidget = require("fidget")
                fidget.setup({
                    notification = {
                        window = {
                            winblend = 0,
                        },
                    },
                    progress = {
                        suppress_on_insert = true,
                    },
                })
            end,
        },
    },
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    config = function()
        for _, lsp_name in pairs(require("core.dev-tools").language_servers) do
            vim.lsp.enable(lsp_name)
        end
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("nvim-lsp-attach", {
                clear = true,
            }),
            callback = function(event)
                vim.keymap.set("n", "grn", vim.lsp.buf.rename, {
                    buffer = event.buf,
                    desc = "[R]e[n]ame",
                })
                vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, {
                    buffer = event.buf,
                    desc = "Toggle [F]loating Diagnostic",
                })
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method("textDocument/documentHighlight", event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup("nvim-lsp-highlight", {
                        clear = false,
                    })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })
                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("nvim-lsp-detach", {
                            clear = true,
                        }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({
                                group = "nvim-lsp-highlight",
                                buffer = event2.buf,
                            })
                        end,
                    })
                end
                if client and client:supports_method("textDocument/inlayHint", event.buf) then
                    vim.keymap.set("n", "<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({
                            bufnr = event.buf,
                        }))
                    end, {
                        buffer = event.buf,
                        desc = "[T]oggle Inlay [H]ints",
                    })
                end
            end,
        })
    end,
}
