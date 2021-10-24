require("hop").setup()

vim.api.nvim_set_keymap("n", "\\", [[<Cmd>HopChar1<CR>]], {})
vim.api.nvim_set_keymap("n", "\\\\", [[<Cmd>HopWord<CR>]], {})
