local present, _ = pcall(require, "gruvbox")
if not present then
    return
end

vim.cmd([[colorscheme gruvbox]])
