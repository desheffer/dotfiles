require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            node_incremental = ".",
            node_decremental = ",",
        },
    },
})

function _G.ts_install_sync()
    vim.cmd([[TSInstallSync maintained]])
end
