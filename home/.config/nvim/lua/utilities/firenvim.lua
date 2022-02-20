_M = {}

function _M.on_ui_enter()
    if vim.g.started_by_firenvim then
       vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h20"
       vim.opt.laststatus = 0
       vim.opt.showtabline = 0
    end
end

return _M
