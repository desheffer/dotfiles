-- Add mappings to easily close windows.
vim.cmd([[autocmd FileType help nnoremap <buffer> <silent> <Tab>q <Cmd>close<CR>]])
vim.cmd([[autocmd FileType qf nnoremap <buffer> <silent> <Tab>q <Cmd>close<CR>]])

-- Enable spellcheck for Git commit messages.
vim.cmd([[autocmd FileType gitcommit lua vim.opt.spell = true]])

-- Hide certain buffers in the buffer list.
vim.cmd([[autocmd FileType qf lua vim.opt.buflisted = false]])
