require("telescope").setup({
    defaults = {
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
        },
        path_display = {
            shorten = 1,
        },
        sorting_strategy = "ascending",
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
    },
})

require("telescope").load_extension("ui-select")
