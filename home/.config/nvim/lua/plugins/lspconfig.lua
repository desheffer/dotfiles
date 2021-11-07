vim.fn.sign_define("LspDiagnosticsSignError", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = ""})

vim.api.nvim_set_keymap("n", "gd", [[<Cmd>lua require("telescope.builtin").lsp_definitions()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gD", [[<Cmd>lua require("telescope.builtin").lsp_declarations()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gi", [[<Cmd>lua require("telescope.builtin").lsp_implementations()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gr", [[<Cmd>lua require("telescope.builtin").lsp_references()<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "[d", [[<Cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {focusable = false}})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]d", [[<Cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {focusable = false}})<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Leader>ca", [[<Cmd>lua require("telescope.builtin").lsp_code_actions()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>cf", [[<Cmd>lua vim.lsp.buf.formatting()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>cr", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("v", "<Leader>cf", [[<Cmd>lua vim.lsp.buf.range_formatting()<CR>]], {noremap = true, silent = true})
