require("bufdel").setup({
    quit = false,
})

vim.api.nvim_set_keymap("n", "<Tab>q", [[<Cmd>BufDel<CR>]], {noremap = true, silent = true})
