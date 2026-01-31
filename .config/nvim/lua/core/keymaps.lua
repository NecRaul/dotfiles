-- Disable arrow keys
local directions = { "<left>", "<right>", "<up>", "<down>" }
local modes = { "n", "v" }
for _, dir in ipairs(directions) do
    for _, mode in ipairs(modes) do
        vim.keymap.set(mode, dir, ':echo "Use hjkl!!"<CR>', {
            silent = true,
        })
    end
end

-- Basic keymaps
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "c", [["_c]])
vim.keymap.set("n", "x", [["_x]])
vim.keymap.set("n", "<leader>s", [[:%s//<Left>]])
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", {
    silent = true,
})
vim.keymap.set("n", "<C-n>", ":edit ", {
    silent = true,
    desc = "Create/Open file",
})
vim.keymap.set("n", "<C-o>", function()
    local name = "codebook"
    local clients = vim.lsp.get_clients({
        name = name,
    })

    if #clients > 0 then
        for _, client in ipairs(clients) do
            client.stop()
        end
        vim.lsp.enable(name, false)
    else
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        vim.lsp.config(name, {
            capabilities = capabilities,
        })
        vim.lsp.enable(name, true)
    end
end, {
    desc = "Toggle Codebook",
})

-- Buffer navigation keymaps
vim.keymap.set("n", "<leader><Tab>", "<C-^>", {
    silent = true,
    desc = "Last buffer",
})
vim.keymap.set("n", "<leader>h", ":bp<CR>", {
    silent = true,
    desc = "Previous buffer",
})
vim.keymap.set("n", "<leader>l", ":bn<CR>", {
    silent = true,
    desc = "Next buffer",
})
for i = 1, 9 do
    vim.keymap.set("n", ("<leader>%d"):format(i), function()
        local bufs = vim.fn.getbufinfo({
            buflisted = 1,
        })

        local buf = bufs[i]
        if buf then
            vim.api.nvim_set_current_buf(buf.bufnr)
        end
    end, {
        silent = true,
        desc = ("Buffer index %d"):format(i),
    })
end

-- Window navigation keymaps
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {
    silent = true,
    desc = "Move focus to the left window",
})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {
    silent = true,
    desc = "Move focus to the right window",
})
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {
    silent = true,
    desc = "Move focus to the lower window",
})
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {
    silent = true,
    desc = "Move focus to the upper window",
})

-- Nvim Tree keymaps
vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>", {
    silent = true,
    desc = "Toggle NvimTree",
})

-- Git keymaps
vim.keymap.set("n", "<C-g><C-d>", ":Gitsigns diffthis<CR>", {
    silent = true,
    desc = "Git Diff",
})
vim.keymap.set("n", "<C-g><C-b>", ":Gitsigns blame<CR>", {
    silent = true,
    desc = "Git Blame",
})
vim.keymap.set("n", "<C-g><C-l>", ":Flog<CR>", {
    silent = true,
    desc = "Git Log",
})

-- Telescope keymaps
vim.keymap.set("n", "<C-p>", function()
    local git_ok = pcall(vim.fn.system, "git rev-parse --is-inside-work-tree")
    if git_ok and vim.v.shell_error == 0 then
        vim.cmd("Telescope git_files")
    else
        vim.cmd("Telescope find_files")
    end
end, {
    silent = true,
    desc = "Telescope smart find files",
})
vim.keymap.set("n", "<C-s>", ":Telescope live_grep<CR>", {
    silent = true,
    desc = "Telescope live grep",
})
vim.keymap.set("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<CR>", {
    silent = true,
    desc = "Telescope current buffer fuzzy find",
})
vim.keymap.set("n", "<C-q>", ":Telescope diagnostics<CR>", {
    silent = true,
    desc = "Telescope diagnostics",
})
vim.keymap.set("n", "<C-b>", ":Telescope buffers<CR>", {
    silent = true,
    desc = "Telescope buffers",
})

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
    silent = true,
    desc = "Open diagnostic [Q]uickfix list",
})
