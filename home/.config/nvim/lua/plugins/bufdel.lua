local present, bufdel = pcall(require, "bufdel")
if not present then
    return
end

bufdel.setup({
    quit = false,
})

vim.api.nvim_set_keymap("n", "<Tab>q", "<cmd>BufDel<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-c>", "<cmd>BufDel<CR>", {noremap = true, silent = true})
