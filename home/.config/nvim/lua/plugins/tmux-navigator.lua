vim.g.tmux_navigator_no_mappings = 1

for _, mode in ipairs({"", "c", "i"}) do
    vim.api.nvim_set_keymap(mode, "<C-w>h", [[<Cmd>TmuxNavigateLeft<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-w>j", [[<Cmd>TmuxNavigateDown<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-w>k", [[<Cmd>TmuxNavigateUp<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-w>l", [[<Cmd>TmuxNavigateRight<CR>]], {noremap = true, silent = true})
end
