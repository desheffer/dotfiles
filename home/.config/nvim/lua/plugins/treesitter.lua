require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

function _G.ts_install_sync()
    vim.cmd([[TSInstallSync maintained]])
end
