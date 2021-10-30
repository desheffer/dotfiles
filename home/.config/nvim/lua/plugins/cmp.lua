vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
cmp.setup({
    mapping = {
        ["<CR>"] = cmp.mapping.confirm(),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    sources = {
        {name = "nvim_lsp"},
        {name = "vsnip"},
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
