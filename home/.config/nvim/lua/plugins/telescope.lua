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
})

function _G.smart_find_files()
    if pcall(require("telescope.builtin").git_files) then
        return
    end

    require("telescope.builtin").find_files()
end
