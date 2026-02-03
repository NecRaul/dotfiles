vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.filetypes")
require("core.dev-tools")
require("config.lazy")
