vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_palette = "original"

vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "gruvbox-material",
    callback = require("utilities.colorscheme").gruvbox_material_custom,
})

vim.cmd([[colorscheme gruvbox-material]])
