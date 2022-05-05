-- Set <Leader> to space.
vim.g.mapleader = " "

-- Create a new buffer with <C-n>.
vim.keymap.set("n", "<C-n>", function () vim.cmd([[enew]]) end)

-- Cycle buffers with <M-Pageup> and <M-Pagedown> (for consistency with Tmux).
vim.keymap.set("n", "<M-Pageup>",   require("utilities.buffer").next)
vim.keymap.set("n", "<M-Pagedown>", require("utilities.buffer").prev)

-- Cycle buffers with gt and gT (for consistency with vanilla Vim tabs).
vim.keymap.set("n", "gt", require("utilities.buffer").next)
vim.keymap.set("n", "gT", require("utilities.buffer").prev)

-- Save a buffer with <C-s>.
vim.keymap.set({"i", "n"}, "<C-s>", function () vim.cmd([[write]]) end)

-- Close a buffer with <C-c>.
vim.keymap.set("n", "<C-c>", require("utilities.buffer").delete)

-- Quit Neovim with <C-q>.
vim.keymap.set("n", "<C-q>", function () vim.cmd([[qall]]) end)

-- Integrate navigation between Neovim and Tmux.
vim.keymap.set({"", "c", "i"}, "<C-w>h", function () vim.cmd([[TmuxNavigateLeft]])  end)
vim.keymap.set({"", "c", "i"}, "<C-w>j", function () vim.cmd([[TmuxNavigateDown]])  end)
vim.keymap.set({"", "c", "i"}, "<C-w>k", function () vim.cmd([[TmuxNavigateUp]])    end)
vim.keymap.set({"", "c", "i"}, "<C-w>l", function () vim.cmd([[TmuxNavigateRight]]) end)

-- Add intuitive mappings to create window splits.
vim.keymap.set("n", "<C-w>-", function () vim.cmd([[split]])  end)
vim.keymap.set("n", "<C-w>|", function () vim.cmd([[vsplit]]) end)

-- Allow j/k and <Down>/<Up> to navigate wrapped lines.
vim.keymap.set("n", "j",       [[gj]])
vim.keymap.set("n", "k",       [[gk]])
vim.keymap.set("n", "gj",      [[j]])
vim.keymap.set("n", "gk",      [[k]])
vim.keymap.set("n", "<Down>",  [[gj]])
vim.keymap.set("n", "<Up>",    [[gk]])
vim.keymap.set("n", "g<Down>", [[j]])
vim.keymap.set("n", "g<Up>",   [[k]])

-- Bind a smart fuzzy finder to <C-p>.
vim.keymap.set("n", "<C-p>", require("utilities.finder").find_files)

-- Bind Telescope file commands.
vim.keymap.set("n", "<Leader>fa", function () require("telescope.builtin").find_files({hidden = true}) end)
vim.keymap.set("n", "<Leader>fb", function () require("telescope.builtin").buffers() end)
vim.keymap.set("n", "<Leader>ff", function () require("telescope.builtin").find_files() end)
vim.keymap.set("n", "<Leader>fg", function () require("telescope.builtin").live_grep() end)
vim.keymap.set("n", "<Leader>fh", function () require("telescope.builtin").help_tags() end)
vim.keymap.set("n", "<Leader>fo", function () require("telescope.builtin").oldfiles() end)
vim.keymap.set("n", "<Leader>fr", function () require("telescope.builtin").resume() end)
vim.keymap.set("n", "<Leader>fw", function () require("telescope.builtin").grep_string() end)
vim.keymap.set("v", "<Leader>fw", function () require("telescope.builtin").grep_string() end)

-- Bind Telescope session commands.
vim.keymap.set("n", "<Leader>fs", function () require("session-lens").search_session() end)

-- Bind Telescope Git commands.
vim.keymap.set("n", "<Leader>gc", function () require("telescope.builtin").git_bcommits() end)
vim.keymap.set("n", "<Leader>gf", function () require("telescope.builtin").git_files() end)
vim.keymap.set("n", "<Leader>gs", function () require("telescope.builtin").git_status() end)

-- Find spelling suggestions with z=.
vim.keymap.set("n", "z=", function () require("telescope.builtin").spell_suggest() end)

-- Focus the file tree with <Leader>n.
vim.keymap.set("n", "<Leader>n", function () require("nvim-tree").find_file(true) require("nvim-tree").focus() end)

-- Hop to a character with <Leader><Leader>{char}.
vim.keymap.set("", "<Leader><Leader>", function () require("hop").hint_char1() end)

-- Bind various LSP commands.
vim.keymap.set("n", "gd", function () require("telescope.builtin").lsp_definitions({jump_type = "never"}) end)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", function () require("telescope.builtin").lsp_implementations({jump_type = "never"}) end)
vim.keymap.set("n", "gr", function () require("telescope.builtin").lsp_references({jump_type = "never"}) end)
vim.keymap.set("n", "K",  vim.lsp.buf.hover)
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("v", "<Leader>ca", vim.lsp.buf.range_code_action)
vim.keymap.set("n", "<Leader>cf", vim.lsp.buf.formatting)
vim.keymap.set("v", "<Leader>cf", vim.lsp.buf.range_formatting)
vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename)

-- Bind various diagnostic commands.
vim.keymap.set("n", "[d", function () vim.diagnostic.goto_prev({popup_opts = {focusable = false}}) end)
vim.keymap.set("n", "]d", function () vim.diagnostic.goto_next({popup_opts = {focusable = false}}) end)
vim.keymap.set("n", "<Leader>cd", function () require("telescope.builtin").diagnostics() end)

-- Add more details when highlighting search matches.
vim.keymap.set("",  "*",  [[<Plug>(asterisk-z*)<Cmd>lua require("hlslens").start()<CR>]])
vim.keymap.set("",  "#",  [[<Plug>(asterisk-z#)<Cmd>lua require("hlslens").start()<CR>]])
vim.keymap.set("",  "g*", [[<Plug>(asterisk-zg*)<Cmd>lua require("hlslens").start()<CR>]])
vim.keymap.set("",  "g#", [[<Plug>(asterisk-zg#)<Cmd>lua require("hlslens").start()<CR>]])
vim.keymap.set("n", "n",  [[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("hlslens").start()<CR>]])
vim.keymap.set("n", "N",  [[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("hlslens").start()<CR>]])

-- Turn off search highlighting with <C-l>.
-- This syntax is special to maintain compatibility with the hlslens plugin.
vim.keymap.set("n", "<C-l>", [[:nohlsearch<CR>]], {silent = true})

-- Disable ex mode.
vim.keymap.set("n", "Q", [[]])

-- Make Y yank to end of line.
vim.keymap.set("n", "Y", [[y$]])

-- Prevent p from replacing the buffer by copying the pasted text.
vim.keymap.set("v", "p", [[pgvy]])

-- Preserve selection on indent.
vim.keymap.set("v", "<", [[<gv]])
vim.keymap.set("v", ">", [[>gv]])

-- Invoke EasyAlign with ga{char}.
vim.keymap.set({"n", "x"}, "ga", [[<Plug>(EasyAlign)]])

-- Toggle a floating terminal with <F5>.
vim.keymap.set({"n", "t"}, "<F5>", function () require("FTerm").toggle() end)
