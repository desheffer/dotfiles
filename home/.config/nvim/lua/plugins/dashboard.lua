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
        description = {"  Find File                       <C-p>"},
        command = function() smart_find_files() end,
    },
    b = {
        description = {"  Live Grep                   <Space>fg"},
        command = function() require("telescope.builtin").live_grep() end,
    },
    c = {
        description = {"  Project                     <Space>fp"},
        command = function() require("telescope").extensions.project.project({}) end,
    },
    d = {
        description = {"ﮦ  Recent File                 <Space>fo"},
        command = function() require("telescope.builtin").oldfiles() end,
    },
    e = {
        description = {"ﱐ  New File                 <Tab><Enter>"},
        command = function() vim.cmd([[enew]]) end,
    },
}

vim.g.dashboard_custom_footer = {
    vim.fn.printf(
        "Loaded in %.3f seconds",
        vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
    )
}
