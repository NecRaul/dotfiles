vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = false
vim.opt.scrolloff = 10
vim.opt.laststatus = 0
vim.opt.showtabline = 0
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = false

vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.hlsearch = true
vim.opt.ignorecase = false
vim.opt.smartcase = true
vim.opt.inccommand = "split"

vim.opt.mouse = "a"
vim.opt.confirm = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.background = "dark"
vim.opt.timeoutlen = 1000
vim.opt.undofile = true

vim.opt.updatetime = 2000

vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "utf-8"
vim.opt.compatible = false

vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}

vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "if_many",
    },
    underline = {
        severity = vim.diagnostic.severity.ERROR,
    },
    virtual_text = true,
    virtual_lines = false,
    jump = {
        float = true,
    },
})
