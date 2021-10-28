require("hop").setup()

vim.api.nvim_set_keymap("n", "\\", [[<Cmd>HopChar1<CR>]], {noremap = true})
vim.api.nvim_set_keymap("n", "\\\\", [[<Cmd>HopWord<CR>]], {noremap = true})
