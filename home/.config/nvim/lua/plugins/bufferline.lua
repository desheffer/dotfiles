local present, bufferline = pcall(require, "bufferline")
if not present then
    return
end

bufferline.setup({
    options = {
        buffer_close_icon = " ",
        close_icon = "",
        separator_style = "slant",
    },
})

vim.api.nvim_set_keymap("n", "]<Tab>", "<Cmd>BufferLineCycleNext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[<Tab>", "<Cmd>BufferLineCyclePrev<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "><Tab>", "<Cmd>BufferLineMoveNext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<<Tab>", "<Cmd>BufferLineMovePrev<CR>", {noremap = true, silent = true})

vim.cmd("autocmd FileType neoterm set nobuflisted")
vim.cmd("autocmd FileType qf set nobuflisted")
