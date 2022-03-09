require("nvim-tree").setup({
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
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
