-- Set <Leader> to space.
vim.g.mapleader = " "

-- Disable ex mode.
vim.api.nvim_set_keymap("n", "Q", [[<Nop>]], {noremap = true, silent = true})

-- Make Y yank to end of line.
vim.api.nvim_set_keymap("n", "Y", [[y$]], {noremap = true, silent = true})

-- Allow j and k to navigate wrapped lines.
vim.api.nvim_set_keymap("n", "j", [[gj]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "k", [[gk]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gj", [[j]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gk", [[k]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Down>", [[gj]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Up>", [[gk]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "g<Down>", [[j]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "g<Up>", [[k]], {noremap = true, silent = true})

-- Add mappings to create and save buffers.
vim.api.nvim_set_keymap("n", "<Leader><Tab>", [[<Cmd>enew<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-s>", [[<Cmd>w<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-s>", [[<Cmd>w<CR>]], {noremap = true, silent = true})

-- Add mappings to exit,
vim.api.nvim_set_keymap("n", "<C-q>", [[<Cmd>qa<CR>]], {noremap = true, silent = true})

-- Add mappings to turn off search highlighting.
vim.api.nvim_set_keymap("n", "<C-l>", [[:nohlsearch<CR>]], {noremap = true, silent = true})

-- Add intuitive mappings to create window splits.
vim.api.nvim_set_keymap("n", "<C-w>-", [[<Cmd>split<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-w>|", [[<Cmd>vsplit<CR>]], {noremap = true, silent = true})

-- Prevent p from replacing the buffer by copying the pasted text.
vim.api.nvim_set_keymap("v", "p", [[pgvy]], {noremap = true, silent = true})

-- Preserve selection on indent.
vim.api.nvim_set_keymap("v", "<", [[<gv]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", ">", [[>gv]], {noremap = true, silent = true})
