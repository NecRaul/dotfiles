return {
    "uZer/pywal16.nvim",
    lazy = false,
    config = function()
        vim.cmd.colorscheme("pywal16")
        vim.api.nvim_set_hl(0, "Whitespace", {
            bg = "NONE",
        })
    end,
}
