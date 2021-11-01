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

function _G.smart_hover()
    local _, cmp = pcall(require, "cmp")
    if cmp then
        cmp.close()
    end

    local params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(0, "textDocument/signatureHelp", params, function(_, result, ctx, config)
        if result then
            vim.lsp.handlers["textDocument/signatureHelp"](_, result, ctx, config)
        else
            vim.lsp.buf_request(0, "textDocument/hover", params, function(_, result, ctx, config)
                if result then
                    vim.lsp.handlers["textDocument/hover"](_, result, ctx, config)
                end
            end)
        end
    end)
end

vim.api.nvim_set_keymap("n", "gd", [[<Cmd>lua require("telescope.builtin").lsp_definitions()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gD", [[<Cmd>lua require("telescope.builtin").lsp_declarations()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gi", [[<Cmd>lua require("telescope.builtin").lsp_implementations()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gr", [[<Cmd>lua require("telescope.builtin").lsp_references()<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "K", [[<Cmd>lua smart_hover()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-k>", [[<Cmd>lua smart_hover()<CR>]], {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "[d", [[<Cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {focusable = false}})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]d", [[<Cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {focusable = false}})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ca", [[<Cmd>lua require("telescope.builtin").lsp_code_actions()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>cr", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], {noremap = true, silent = true})
