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

vim.api.nvim_set_keymap("n", "<C-p>", "<Cmd>Telescope git_files<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Leader>fa", "<Cmd>Telescope find_files hidden=true<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fw", "<Cmd>Telescope live_grep<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fo", "<Cmd>Telescope oldfiles<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>gc", "<Cmd>Telescope git_commits<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>gs", "<Cmd>Telescope git_status<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Leader>fr", "<Cmd>Telescope resume<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("v", "<Leader>fw", "<Cmd>Telescope grep_string<CR>", {noremap = true, silent = true})
