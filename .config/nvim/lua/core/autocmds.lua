-- Trailing whitespace cleanup
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local curr_pos = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_exec2(
            [[
      %s/\s\+$//e
      %s/\r\+$//e
      %s/\n\+\%$//e
    ]],
            {
                output = false,
            }
        )
        vim.api.nvim_win_set_cursor(0, curr_pos)
    end,
})

-- Xresources filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
    command = "set filetype=Xdefaults",
})

-- Xresources reload
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
    command = "!xrdb %",
})

-- dwmblocks recompile
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "~/Documents/Github/Repos/dwmblocks/config.h",
    command = "!cd ~/Documents/Github/Repos/dwmblocks/ && sudo make install && { killall -q dwmblocks; setsid dwmblocks & }",
})

-- Treesitter parse on buffer read
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
        if ok then
            local bufnr = vim.api.nvim_get_current_buf()
            local lang = ts_parsers.get_buf_lang(bufnr)
            if lang then
                local parser = ts_parsers.get_parser(bufnr, lang)
                if parser then
                    parser:parse()
                end
            end
        end
    end,
})
