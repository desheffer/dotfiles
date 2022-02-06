vim.g.dashboard_default_executive = "telescope"

vim.g.dashboard_custom_header = {
    " ███╗   ██╗ ██╗   ██╗ ██╗ ███╗   ███╗",
    " ████╗  ██║ ██║   ██║ ██║ ████╗ ████║",
    " ██╔██╗ ██║ ██║   ██║ ██║ ██╔████╔██║",
    " ██║╚██╗██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
    " ██║ ╚████║  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
    " ╚═╝  ╚═══╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

vim.g.dashboard_custom_section = {
    a = {
        description = {"ﱐ  New                             <C-n>"},
        command = function() vim.cmd([[enew]]) end,
    },
    b = {
        description = {"  Files                           <C-p>"},
        command = function() require("utilities.finder").find_files() end,
    },
    c = {
        description = {"﬿  Sessions                    <Space>fs"},
        command = function() require("session-lens").search_session() end,
    },
    d = {
        description = {"ﮦ  Recent Files                <Space>fo"},
        command = function() require("telescope.builtin").oldfiles() end,
    },
    e = {
        description = {"  Grep                        <Space>fg"},
        command = function() require("telescope.builtin").live_grep() end,
    },
}

vim.g.dashboard_custom_footer = {
    vim.fn.printf(
        "Loaded in %.3f seconds",
        vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
    )
}
