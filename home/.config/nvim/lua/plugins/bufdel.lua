require("bufdel").setup({})

vim.api.nvim_set_keymap("n", "<C-c>", [[<Cmd>BufDel<CR>]], {noremap = true, silent = true})
