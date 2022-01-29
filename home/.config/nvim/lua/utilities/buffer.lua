_M = {}

PLACEHOLDER = "placeholder"

function _M.next()
    local buflisted = vim.api.nvim_buf_get_option(0, "buflisted")

    local windows = vim.tbl_filter(function (window)
        return vim.api.nvim_win_is_valid(window)
    end, vim.api.nvim_list_wins())

    -- Avoid getting stuck on an unlisted buffer.
    if not buflisted and #windows <= 1 then
        pcall(vim.cmd, [[bnext]])
        return
    end

    require("bufferline").cycle(1)
end

function _M.prev()
    local buflisted = vim.api.nvim_buf_get_option(0, "buflisted")

    local windows = vim.tbl_filter(function (window)
        return vim.api.nvim_win_is_valid(window)
    end, vim.api.nvim_list_wins())

    -- Avoid getting stuck on an unlisted buffer.
    if not buflisted and #windows <= 1 then
        pcall(vim.cmd, [[bprev]])
        return
    end

    require("bufferline").cycle(-1)
end

-- Delete the current buffer. If the buffer is listed, then swap in another
-- buffer to preserve the window layout. If the buffer is unlisted, then close
-- its window before deleting it (which mirrors how unlisted buffers are
-- typically created in new windows).
function _M.delete()
    local current_buffer = vim.api.nvim_get_current_buf()
    local buflisted = vim.api.nvim_buf_get_option(current_buffer, "buflisted")
    local filetype = vim.api.nvim_buf_get_option(current_buffer, "filetype")

    local buffers = vim.tbl_filter(function (buffer)
        return vim.api.nvim_buf_is_valid(buffer)
    end, vim.api.nvim_list_bufs())

    local listed_buffers = vim.tbl_filter(function (buffer)
        return vim.api.nvim_buf_get_option(buffer, "buflisted")
    end, buffers)

    local windows = vim.tbl_filter(function (window)
        return vim.api.nvim_win_is_valid(window)
    end, vim.api.nvim_list_wins())

    if filetype == PLACEHOLDER then
        return
    end

    -- If the buffer is unlisted (e.g. help, quickfix, tree) and is acting like
    -- a sidebar, then close its window before deleting the buffer.
    if not buflisted and #windows > 1 then
        vim.api.nvim_win_close(0, {})
    end

    -- Find a replacement buffer to swap in for the buffer being deleted.
    local replacement_buffer = current_buffer
    for index, buffer in ipairs(listed_buffers) do
        if buffer == current_buffer then
            replacement_buffer = listed_buffers[index % #listed_buffers + 1]
            break
        end
    end

    -- If a suitable buffer was not found, then create an empty one.
    if replacement_buffer == current_buffer then
        replacement_buffer = vim.api.nvim_create_buf(false, false)
        vim.api.nvim_buf_set_option(replacement_buffer, "filetype", PLACEHOLDER)
        vim.api.nvim_buf_set_option(replacement_buffer, "modifiable", false)
    end

    -- Perform the replacement buffer swap.
    for _, window in ipairs(windows) do
        if vim.api.nvim_win_is_valid(window)
            and vim.api.nvim_win_get_buf(window) == current_buffer then
            vim.api.nvim_win_set_buf(window, replacement_buffer)
        end
    end

    -- Delete the buffer with confirmation for any unsaved changes.
    pcall(vim.cmd, string.format([[confirm bdelete %d]], current_buffer))
end

return _M
