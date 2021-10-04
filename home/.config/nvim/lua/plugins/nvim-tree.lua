local present, nvim_tree = pcall(require, "nvim-tree")
if not present then
    return
end

nvim_tree.setup({
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
vim.api.nvim_set_keymap("n", "<Leader>E", "<Cmd>NvimTreeFindFile<CR>", {noremap = true, silent = true})
