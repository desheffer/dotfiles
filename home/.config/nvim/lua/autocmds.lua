-- Remove trailing whitespace on save.
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function ()
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[%s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, pos)
    end,
})

-- Set colorcolumn dynamically if textwidth is set.
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function ()
        if vim.bo.textwidth > 0 then
            vim.wo.colorcolumn = "+1"
        end
    end,
})

-- Hide certain buffers in the buffer list.
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"qf", "vim"},
    callback = function ()
        vim.opt.buflisted = false
    end,
})

-- Initialize Firenvim.
vim.api.nvim_create_autocmd("UIEnter", {
    pattern = "*",
    callback = require("utilities.firenvim").on_ui_enter,
})
