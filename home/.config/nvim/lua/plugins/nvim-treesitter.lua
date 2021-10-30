require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "c_sharp",
        "css",
        "dockerfile",
        "go",
        "html",
        "java",
        "json",
        "lua",
        "python",
        "yaml",
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
})
