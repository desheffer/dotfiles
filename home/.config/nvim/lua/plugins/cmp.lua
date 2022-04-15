vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        ["<CR>"] = cmp.mapping.confirm(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<C-d>"] = cmp.mapping.scroll_docs(4, {"i", "c"}),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4, {"i", "c"}),
        ["<Tab>"] = cmp.mapping(function (fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function (fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {"i", "s"}),
    }),
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    sources = {
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "buffer"},
    },
    window = {
        documentation = {
            border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
        },
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
