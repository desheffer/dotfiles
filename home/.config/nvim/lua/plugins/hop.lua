require("hop").setup()

vim.api.nvim_set_keymap("", "\\", [[<Cmd>HopChar1<CR>]], {noremap = true})
vim.api.nvim_set_keymap("", "\\\\", [[<Cmd>HopWord<CR>]], {noremap = true})
