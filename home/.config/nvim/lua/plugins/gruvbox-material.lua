vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_palette = "original"

function _G.gruvbox_material_custom()
    -- Tone down the search highlighting.
    vim.cmd([[highlight! IncSearch cterm=reverse gui=reverse guifg=#FE811B guibg=#29292]])
    vim.cmd([[highlight! Search ctermfg=0 ctermbg=11 gui=reverse guifg=#FABD2E guibg=#29292]])

    -- Darken the NvimTree window.
    vim.cmd([[highlight! NvimTreeNormal ctermfg=223 ctermbg=235 guifg=#EBDBB2 guibg=#1E1E1E]])
    vim.cmd([[highlight! NvimTreeEndOfBuffer ctermfg=239 ctermbg=235 guifg=#1E1E1E guibg=#1E1E1E]])
    vim.cmd([[highlight! NvimTreeVertSplit ctermfg=239 guifg=#1E1E1E guibg=#1E1E1E]])
end

vim.cmd([[autocmd ColorScheme gruvbox-material lua gruvbox_material_custom()]])

vim.cmd([[colorscheme gruvbox-material]])
