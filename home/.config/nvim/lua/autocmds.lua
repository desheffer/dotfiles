-- Set colorcolumn dynamically if textwidth is set.
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function ()
        if vim.bo.textwidth > 0 then
            vim.wo.colorcolumn = "+0"
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
