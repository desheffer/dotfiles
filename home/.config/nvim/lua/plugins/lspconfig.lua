vim.fn.sign_define("LspDiagnosticsSignError", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = ""})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
        focusable = false,
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
        focusable = false,
    }
)

vim.api.nvim_set_keymap("n", "gd", [[<Cmd>lua require("telescope.builtin").lsp_definitions({jump_type = "never"})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gD", [[<Cmd>lua require("telescope.builtin").lsp_declarations({jump_type = "never"})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gi", [[<Cmd>lua require("telescope.builtin").lsp_implementations({jump_type = "never"})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gr", [[<Cmd>lua require("telescope.builtin").lsp_references({jump_type = "never"})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gt", [[<Cmd>lua require("telescope.builtin").lsp_type_definitions({jump_type = "never"})<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "K", [[<Cmd>lua vim.lsp.buf.hover({focusable = false})<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "[d", [[<Cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {focusable = false}})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]d", [[<Cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {focusable = false}})<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<Leader>ca", [[<Cmd>lua require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor())<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>cd", [[<Cmd>lua require("telescope.builtin").lsp_document_diagnostics()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>cf", [[<Cmd>lua vim.lsp.buf.formatting()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>cr", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("v", "<Leader>cf", [[<Cmd>lua vim.lsp.buf.range_formatting()<CR>]], {noremap = true, silent = true})
