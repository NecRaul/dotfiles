return {
    {
        "folke/lazydev.nvim",
        opts = {
            library = {
                {
                    path = "${3rd}/luv/library",
                    words = { "vim%.uv" },
                },
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0,
            })
        end,
    },
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            keymap = {
                preset = "default",
                ["<Tab>"] = { "select_and_accept", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            },
            signature = {
                enabled = true,
            },
        },
    },
}
