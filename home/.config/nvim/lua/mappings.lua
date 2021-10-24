-- Set <Leader> to space.
vim.g.mapleader = " "

-- Disable ex mode.
vim.api.nvim_set_keymap("n", "Q", [[<Nop>]], {silent = true})

-- Make Y yank to end of line.
vim.api.nvim_set_keymap("n", "Y", [[y$]], {silent = true})

-- Allow j and k to navigate wrapped lines.
vim.api.nvim_set_keymap("n", "j", [[gj]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "k", [[gk]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gj", [[j]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gk", [[k]], {noremap = true, silent = true})

-- Add mappings to create and save buffers.
vim.api.nvim_set_keymap("n", "<Tab><Enter>", [[<Cmd>enew<CR>]], {silent = true})
vim.api.nvim_set_keymap("n", "<C-s>", [[<Cmd>w<CR>]], {silent = true})

-- Add mappings to exit,
vim.api.nvim_set_keymap("n", "<C-c>", [[<Cmd>qa<CR>]], {noremap = true, silent = true})

-- Add mappings to turn off search highlighting.
vim.api.nvim_set_keymap("n", "<C-l>", [[<Cmd>nohlsearch<CR>]], {silent = true})

-- Add intuitive mappings to create window splits.
vim.api.nvim_set_keymap("n", "<C-w>-", [[<Cmd>split<CR>]], {silent = true})
vim.api.nvim_set_keymap("n", "<C-w>|", [[<Cmd>vsplit<CR>]], {silent = true})

-- Prevent p from replacing the buffer by copying the pasted text.
vim.api.nvim_set_keymap("v", "p", [[pgvy]], {silent = true})

-- Preserve selection on indent.
vim.api.nvim_set_keymap("v", "<", [[<gv]], {silent = true})
vim.api.nvim_set_keymap("v", ">", [[>gv]], {silent = true})

-- Add mappings to search for visually selected text.
vim.api.nvim_set_keymap("v", "*", [[y/<C-R>"<CR>]], {silent = true})

-- Add mappings to easily close windows.
vim.cmd([[autocmd FileType help,qf :nnoremap <buffer> <silent> <Tab>q :close<CR>]])