local present, telescope = pcall(require, "telescope")
if not present then
    return
end

telescope.setup({
    defaults = {
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
        },
    },
})

vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope git_files<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Leader>fa", "<cmd>Telescope find_files hidden=true<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fw", "<cmd>Telescope live_grep<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fo", "<cmd>Telescope oldfiles<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>gc", "<cmd>Telescope git_commits<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>gs", "<cmd>Telescope git_status<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Leader>fr", "<cmd>Telescope resume<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("v", "<Leader>fw", "<cmd>Telescope grep_string<CR>", {noremap = true, silent = true})
