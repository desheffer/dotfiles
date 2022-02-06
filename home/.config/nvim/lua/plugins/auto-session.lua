local is_git = vim.fn.system("[ -d .git ] && echo -n .git") == ".git"

require("auto-session").setup({
    auto_session_create_enabled = is_git,
    log_level = "error",
})
