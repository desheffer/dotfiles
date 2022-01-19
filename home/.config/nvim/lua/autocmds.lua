-- Set colorcolumn dynamically if textwidth is set.
vim.cmd([[autocmd BufEnter * lua if vim.bo.textwidth > 0 then vim.wo.colorcolumn = "+0" end]])

-- Hide certain buffers in the buffer list.
vim.cmd([[autocmd FileType qf lua vim.opt.buflisted = false]])
