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
        command = smart_find_files,
    },
    b = {
        description = {"  Live Grep                   <Space>fg"},
        command = require("telescope.builtin").live_grep,
    },
    c = {
        description = {"  Project                     <Space>fp"},
        command = function() require("telescope").extensions.project.project({}) end,
    },
    d = {
        description = {"ﮦ  Recent File                 <Space>fo"},
        command = require("telescope.builtin").oldfiles,
    },
    e = {
        description = {"ﱐ  New File                 <Tab><Enter>"},
        command = [[enew]],
    },
}

vim.g.dashboard_custom_footer = {
    vim.fn.printf(
        "Loaded in %.3f seconds",
        vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
    )
}
