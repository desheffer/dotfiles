require("telescope").setup({
    defaults = {
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
        },
    },
})

function _G.smart_find_files()
    if pcall(require("telescope.builtin").git_files) then
        return
    end

    require("telescope.builtin").find_files()
end

vim.api.nvim_set_keymap("n", "<C-p>", [[<Cmd>lua smart_find_files()<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Leader>fa", [[<Cmd>lua require("telescope.builtin").find_files({hidden = true})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require("telescope.builtin").help_tags()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require("telescope.builtin").oldfiles()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fr", [[<Cmd>lua require("telescope.builtin").resume()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fw", [[<Cmd>lua require("telescope.builtin").grep_string()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<Leader>fw", [[<Cmd>lua require("telescope.builtin").grep_string()<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Leader>gc", [[<Cmd>lua require("telescope.builtin").git_bcommits()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>gf", [[<Cmd>lua require("telescope.builtin").git_files()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>gs", [[<Cmd>lua require("telescope.builtin").git_status()<CR>]], {noremap = true, silent = true})
