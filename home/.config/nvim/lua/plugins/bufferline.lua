require("bufferline").setup({
    options = {
        buffer_close_icon = " ",
        close_icon = "",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and "" or ""
            return " " .. icon .. " " .. count
        end,
        separator_style = "slant",
    },
})

vim.api.nvim_set_keymap("n", "]<Tab>", [[<Cmd>BufferLineCycleNext<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[<Tab>", [[<Cmd>BufferLineCyclePrev<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "><Tab>", [[<Cmd>BufferLineMoveNext<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<<Tab>", [[<Cmd>BufferLineMovePrev<CR>]], {noremap = true, silent = true})

vim.cmd([[autocmd FileType neoterm,qf set nobuflisted]])
