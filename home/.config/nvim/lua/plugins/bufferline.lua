require("bufferline").setup({
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                highlight = "BufferLineFill",
                padding = 1,
            },
        },
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
    },
})

vim.api.nvim_set_keymap("n", "]<Tab>", [[<Cmd>BufferLineCycleNext<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[<Tab>", [[<Cmd>BufferLineCyclePrev<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "><Tab>", [[<Cmd>BufferLineMoveNext<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<<Tab>", [[<Cmd>BufferLineMovePrev<CR>]], {noremap = true, silent = true})

vim.cmd([[autocmd FileType neoterm,qf set nobuflisted]])
