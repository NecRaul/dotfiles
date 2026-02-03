return {
    "rbong/vim-flog",
    config = function()
        --
    end,
    vim.keymap.set("n", "<C-g><C-l>", ":Flog<CR>", { silent = true, desc = "[G]it [L]og" }),
}
