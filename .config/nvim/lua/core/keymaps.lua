-- Disable arrow keys
local directions = { "<left>", "<right>", "<up>", "<down>" }
local modes = { "n", "v" }
for _, dir in ipairs(directions) do
    for _, mode in ipairs(modes) do
        vim.keymap.set(mode, dir, ':echo "Use hjkl!"<CR>', { silent = true, desc = "Use hjkl!" })
    end
end

vim.keymap.set("n", "<C-c>", "<silent> <C-c>", { noremap = true, desc = "Pass Ctrl+C through (no quit prompt)" })

-- Basic keymaps
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode" })
vim.keymap.set("n", "c", [["_c]], { desc = "Change without yank" })
vim.keymap.set("n", "x", [["_x]], { desc = "Delete without yank" })
vim.keymap.set("n", "<C-n>", ":edit ", { desc = "Create/Open file" })
vim.keymap.set("n", "<leader>s", [[:%s//<Left>]], { desc = "Search and replace" })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlights" })

-- NOTE: Comment and Uncomment
-- gc{motion}
-- Comment or uncomment lines covered by {motion}.
-- gcc
-- Comment or uncomment [count] lines starting at cursor.
-- {Visual}gc
-- Comment or uncomment the selected line(s).
-- gc
-- Text object for the largest contiguous block of
-- non-blank commented lines around the cursor (e.g.
-- `gcgc` uncomments a comment block; `dgc` deletes it).
-- Works only in Operator-pending mode.

-- Indent and Dedent
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true, desc = "Indent line" })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true, desc = "Dedent line" })
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true, desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true, desc = "Dedent selection" })
vim.keymap.set("i", "<Tab>", "<Tab>", { noremap = true, desc = "Insert tab" })
vim.keymap.set("i", "<S-Tab>", "<C-d>", { noremap = true, desc = "Dedent in insert" })

-- Line and Block Movement
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move block down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move block up" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true, desc = "Move line down (Insert)" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true, desc = "Move line up (Insert)" })

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
    desc = "[T]oggle NvimTree",
})

-- Spellcheck
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
        vim.lsp.enable(name, true)
    end
end, {
    desc = "Toggle Codebook",
})
