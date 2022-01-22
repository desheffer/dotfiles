vim.g.nvim_tree_quit_on_open = 1

require("nvim-tree").setup({
    auto_close = true,
    hijack_cursor = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
    },
    view = {
        mappings = {
            list = {
                {key = {"<Esc>"}, cb = "<Cmd>NvimTreeClose<CR>", mode = "n"},
            },
        },
        width = 50,
    },
})
