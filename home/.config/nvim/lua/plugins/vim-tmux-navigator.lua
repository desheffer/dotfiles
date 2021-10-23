vim.g.tmux_navigator_no_mappings = 1

vim.api.nvim_set_keymap("n", "<C-a><Left>", [[<Cmd>TmuxNavigateLeft<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-a><Down>", [[<Cmd>TmuxNavigateDown<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-a><Up>", [[<Cmd>TmuxNavigateUp<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-a><Right>", [[<Cmd>TmuxNavigateRight<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<C-a>h", [[<Cmd>TmuxNavigateLeft<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-a>j", [[<Cmd>TmuxNavigateDown<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-a>k", [[<Cmd>TmuxNavigateUp<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-a>l", [[<Cmd>TmuxNavigateRight<CR>]], {noremap = true, silent = true})
