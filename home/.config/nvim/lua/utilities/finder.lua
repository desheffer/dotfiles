_M = {}

function _M.find_files()
    if pcall(require("telescope.builtin").git_files) then
        return
    end

    require("telescope.builtin").find_files()
end

return _M
