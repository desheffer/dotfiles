vim.api.nvim_set_keymap("", "*", [[<Plug>(asterisk-z*)<Cmd>lua require("hlslens").start()<CR>]], {})
vim.api.nvim_set_keymap("", "#", [[<Plug>(asterisk-z#)<Cmd>lua require("hlslens").start()<CR>]], {})
vim.api.nvim_set_keymap("", "g*", [[<Plug>(asterisk-zg*)<Cmd>lua require("hlslens").start()<CR>]], {})
vim.api.nvim_set_keymap("", "g#", [[<Plug>(asterisk-zg#)<Cmd>lua require("hlslens").start()<CR>]], {})

vim.api.nvim_set_keymap("n", "n", [[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("hlslens").start()<CR>]], {noremap = true})
vim.api.nvim_set_keymap("n", "N", [[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("hlslens").start()<CR>]], {noremap = true})
