vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
cmp.setup({
    documentation = {
        border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
    },
    mapping = {
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        ["<CR>"] = cmp.mapping.confirm(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<C-d>"] = cmp.mapping.scroll_docs(4, {"i", "c"}),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4, {"i", "c"}),
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
