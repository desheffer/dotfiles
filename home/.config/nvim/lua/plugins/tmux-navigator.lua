vim.g.tmux_navigator_no_mappings = 1

for _, mode in ipairs({"", "c", "i"}) do
    vim.api.nvim_set_keymap(mode, "<C-a><Left>", [[<Cmd>TmuxNavigateLeft<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-a><Down>", [[<Cmd>TmuxNavigateDown<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-a><Up>", [[<Cmd>TmuxNavigateUp<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-a><Right>", [[<Cmd>TmuxNavigateRight<CR>]], {noremap = true, silent = true})

    vim.api.nvim_set_keymap(mode, "<C-a>h", [[<Cmd>TmuxNavigateLeft<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-a>j", [[<Cmd>TmuxNavigateDown<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-a>k", [[<Cmd>TmuxNavigateUp<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-a>l", [[<Cmd>TmuxNavigateRight<CR>]], {noremap = true, silent = true})
end
