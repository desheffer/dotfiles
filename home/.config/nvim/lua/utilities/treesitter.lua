_M = {}

_M.languages = {
    "bash",
    "c",
    "c_sharp",
    "comment",
    "css",
    "dockerfile",
    "go",
    "gomod",
    "html",
    "http",
    "java",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "php",
    "python",
    "regex",
    "yaml",
}

function _M.install_sync()
    local treesitter_install = require("nvim-treesitter.install")

    for _, language_name in ipairs(_M.languages) do
        treesitter_install.ensure_installed_sync({language_name, with_sync = true})
    end
end

return _M
