require("nvim-tree").setup({
    update_focused_file = {
        enable = true,
    },
    view = {
        mappings = {
            list = {
                {key = {"<Esc>"}, cb = "<C-w>l", mode = "n"},
            },
        },
    },
})
