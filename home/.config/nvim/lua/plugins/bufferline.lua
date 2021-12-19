require("bufferline").setup({
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                highlight = "NvimTreeNormal",
                padding = 1,
            },
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
    },
})

vim.api.nvim_set_keymap("n", "<Tab>",   [[<Cmd>BufferLineCycleNext<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<S-Tab>", [[<Cmd>BufferLineCyclePrev<CR>]], {noremap = true, silent = true})
