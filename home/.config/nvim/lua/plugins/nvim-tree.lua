require("nvim-tree").setup({
    update_focused_file = {
        enable = true,
    },
    view = {
        mappings = {
            list = {
                {key = {"<Esc>"}, cb = "<C-w>l", mode = "n"},
            },
        },
    },
})

vim.api.nvim_set_keymap("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>e", "<Cmd>NvimTreeFocus<CR>", {noremap = true, silent = true})
