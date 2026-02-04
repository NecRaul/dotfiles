return {
    "rbong/vim-flog",
    dependencies = {
        "tpope/vim-fugitive",
    },
    config = function()
        --
    end,
    vim.keymap.set("n", "<C-g><C-l>", ":Flog<CR>", { silent = true, desc = "[G]it [L]og" }),
}
