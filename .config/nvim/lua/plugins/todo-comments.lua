return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
        local todo_comments = require("todo-comments")
        todo_comments.setup()
        vim.keymap.set("n", "<leader>tdf", "<cmd>TodoFzfLua<cr>", { desc = "[T]o[D]o [F]zfLua" })
        vim.keymap.set("n", "<leader>tdt", "<cmd>TodoTrouble<cr>", { desc = "[T]o[D]o [T]rouble" })
    end,
}
