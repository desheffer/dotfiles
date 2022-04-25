require("lualine").setup({
    options = {
        disabled_filetypes = {"NvimTree"},
        section_separators = {left = "", right = ""},
        component_separators = {left = "", right = ""},
        globalstatus = true,
    },
    sections = {
        lualine_b = {
            require("auto-session-library").current_session_name,
            "branch",
            "diff",
            {
                "diagnostics",
                sources = {"nvim_diagnostic"},
                sections = {"error", "warn", "info", "hint"},
                diagnostics_color = {
                    error = {fg = "#fb4934"},
                    warn = {fg = "#fabd2f"},
                    info = {fg = "#83a598"},
                    hint = {fg = "#8ec07c"},
                },
                symbols = {error = " ", warn = " ", info = " ", hint = " "},
            },
        },
    },
})
