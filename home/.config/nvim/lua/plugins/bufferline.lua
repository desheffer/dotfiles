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

vim.api.nvim_set_keymap("n", "]<Tab>", "<cmd>BufferLineCycleNext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[<Tab>", "<cmd>BufferLineCyclePrev<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "><Tab>", "<cmd>BufferLineMoveNext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<<Tab>", "<cmd>BufferLineMovePrev<CR>", {noremap = true, silent = true})
