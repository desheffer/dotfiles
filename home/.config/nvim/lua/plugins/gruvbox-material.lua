vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_palette = "original"

vim.cmd([[autocmd ColorScheme gruvbox-material lua require("utilities.colorscheme").gruvbox_material_custom()]])

vim.cmd([[colorscheme gruvbox-material]])
