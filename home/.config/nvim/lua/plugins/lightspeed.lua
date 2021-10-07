require("lightspeed").setup({
    instant_repeat_fwd_key = ";",
    instant_repeat_bwd_key = ",",
})

vim.cmd("unmap s");
vim.cmd("unmap S");

vim.api.nvim_set_keymap("n", "<Leader>s", "<Plug>Lightspeed_s", {})
vim.api.nvim_set_keymap("n", "<Leader>S", "<Plug>Lightspeed_S", {})
