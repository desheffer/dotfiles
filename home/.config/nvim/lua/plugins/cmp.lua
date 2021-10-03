vim.opt.completeopt = "menu,menuone,noselect"

require("cmp").setup({
    sources = {
        {name = "nvim_lsp"},
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
