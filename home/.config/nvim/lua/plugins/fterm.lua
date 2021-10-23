vim.api.nvim_set_keymap("n", "<F5>", [[<Cmd>lua require("FTerm").toggle()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("t", "<F5>", [[<C-\><C-n><Cmd>lua require("FTerm").toggle()<CR>]], {noremap = true, silent = true})
