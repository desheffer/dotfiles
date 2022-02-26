_M = {}

function _M.gruvbox_material_custom()
    -- Tone down the search highlighting.
    vim.cmd([[highlight! IncSearch cterm=reverse gui=reverse guifg=#fe811b guibg=#29292]])
    vim.cmd([[highlight! Search ctermfg=0 ctermbg=11 gui=reverse guifg=#fabd2e guibg=#29292]])

    -- Darken the NvimTree window.
    vim.cmd([[highlight! NvimTreeNormal ctermfg=223 ctermbg=235 guifg=#ebdbb2 guibg=#1e1e1e]])
    vim.cmd([[highlight! NvimTreeEndOfBuffer ctermfg=239 ctermbg=235 guifg=#1e1e1e guibg=#1e1e1e]])
    vim.cmd([[highlight! NvimTreeVertSplit ctermfg=239 guifg=#1e1e1e guibg=#1e1e1e]])

    -- Make matching braces a little more obvious.
    vim.cmd([[highlight! MatchParen cterm=bold gui=bold]])
end

return _M
