require("bufdel").setup({
    quit = false,
})

vim.api.nvim_set_keymap("n", "<Tab>q", "<Cmd>BufDel<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-c>", "<Cmd>BufDel<CR>", {noremap = true, silent = true})
