-- Set <Leader> to space.
vim.g.mapleader = " "

-- Create a new buffer with <C-n>.
vim.api.nvim_set_keymap("n", "<C-n>", [[<Cmd>enew<CR>]], {noremap = true, silent = true})

-- Cycle buffers with <Tab> and <S-Tab>.
vim.api.nvim_set_keymap("n", "<Tab>",   [[<Cmd>BufferLineCycleNext<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<S-Tab>", [[<Cmd>BufferLineCyclePrev<CR>]], {noremap = true, silent = true})

-- Cycle buffers with <M-Pageup> and <M-Pagedown> (for consistency with Tmux).
vim.api.nvim_set_keymap("n", "<M-Pageup>",   [[<Cmd>BufferLineCycleNext<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<M-Pagedown>", [[<Cmd>BufferLineCyclePrev<CR>]], {noremap = true, silent = true})

-- Cycle buffers with gt and gT (for consistency with vanilla Vim tabs).
vim.api.nvim_set_keymap("n", "gt", [[<Cmd>BufferLineCycleNext<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gT", [[<Cmd>BufferLineCyclePrev<CR>]], {noremap = true, silent = true})

-- Save a buffer with <C-s>.
vim.api.nvim_set_keymap("n", "<C-s>", [[<Cmd>w<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-s>", [[<Cmd>w<CR>]], {noremap = true, silent = true})

-- Close a buffer with <C-c>.
vim.api.nvim_set_keymap("n", "<C-c>", [[<Cmd>Sayonara<CR>]], {noremap = true, silent = true})

-- Exit Neovim with <C-q>.
vim.api.nvim_set_keymap("n", "<C-q>", [[<Cmd>qa<CR>]], {noremap = true, silent = true})

-- Integrate navigation between Neovim and Tmux.
for _, mode in ipairs({"", "c", "i"}) do
    vim.api.nvim_set_keymap(mode, "<C-w>h", [[<Cmd>TmuxNavigateLeft<CR>]],  {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-w>j", [[<Cmd>TmuxNavigateDown<CR>]],  {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-w>k", [[<Cmd>TmuxNavigateUp<CR>]],    {noremap = true, silent = true})
    vim.api.nvim_set_keymap(mode, "<C-w>l", [[<Cmd>TmuxNavigateRight<CR>]], {noremap = true, silent = true})
end

-- Add intuitive mappings to create window splits.
vim.api.nvim_set_keymap("n", "<C-w>-", [[<Cmd>split<CR>]],  {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-w>|", [[<Cmd>vsplit<CR>]], {noremap = true, silent = true})

-- Allow j/k and <Down>/<Up> to navigate wrapped lines.
vim.api.nvim_set_keymap("n", "j",       [[gj]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "k",       [[gk]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gj",      [[j]],  {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gk",      [[k]],  {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Down>",  [[gj]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Up>",    [[gk]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "g<Down>", [[j]],  {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "g<Up>",   [[k]],  {noremap = true, silent = true})

-- Bind a smart fuzzy finder to <C-p>.
vim.api.nvim_set_keymap("n", "<C-p>", [[<Cmd>lua require("utilities.finder").find_files()<CR>]], {noremap = true, silent = true})

-- Bind various Telescope file commands.
vim.api.nvim_set_keymap("n", "<Leader>fa", [[<Cmd>lua require("telescope.builtin").find_files({hidden = true})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]],                   {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]],                {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]],                 {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require("telescope.builtin").help_tags()<CR>]],                 {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require("telescope.builtin").oldfiles()<CR>]],                  {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fp", [[<Cmd>lua require("telescope").extensions.project.project({})<CR>]],      {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fr", [[<Cmd>lua require("telescope.builtin").resume()<CR>]],                    {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fw", [[<Cmd>lua require("telescope.builtin").grep_string()<CR>]],               {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<Leader>fw", [[<Cmd>lua require("telescope.builtin").grep_string()<CR>]],               {noremap = true, silent = true})

-- Bind various Telescope Git commands.
vim.api.nvim_set_keymap("n", "<Leader>gc", [[<Cmd>lua require("telescope.builtin").git_bcommits()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>gf", [[<Cmd>lua require("telescope.builtin").git_files()<CR>]],    {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>gs", [[<Cmd>lua require("telescope.builtin").git_status()<CR>]],   {noremap = true, silent = true})

-- Find spelling suggestions with z=.
vim.api.nvim_set_keymap("n", "z=", [[<Cmd>lua require("telescope.builtin").spell_suggest()<CR>]], {noremap = true, silent = true})

-- Focus the file tree with <Leader>n.
vim.api.nvim_set_keymap("n", "<Leader>n", [[<Cmd>NvimTreeFocus<CR>]],  {noremap = true, silent = true})

-- Hop to a character with <Leader><Leader>{char}.
vim.api.nvim_set_keymap("", "<Leader><Leader>", [[<Cmd>HopChar1<CR>]], {noremap = true})

-- Bind various LSP navigation commands.
vim.api.nvim_set_keymap("n", "gd", [[<Cmd>lua require("telescope.builtin").lsp_definitions({jump_type = "never"})<CR>]],     {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gD", [[<Cmd>lua require("telescope.builtin").lsp_declarations({jump_type = "never"})<CR>]],    {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gi", [[<Cmd>lua require("telescope.builtin").lsp_implementations({jump_type = "never"})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gr", [[<Cmd>lua require("telescope.builtin").lsp_references({jump_type = "never"})<CR>]],      {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[d", [[<Cmd>lua vim.diagnostic.goto_prev({popup_opts = {focusable = false}})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]d", [[<Cmd>lua vim.diagnostic.goto_next({popup_opts = {focusable = false}})<CR>]], {noremap = true, silent = true})

-- Bind various code actions under <Leader>c.
vim.api.nvim_set_keymap("n", "<Leader>ca", [[<Cmd>lua require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor())<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>cd", [[<Cmd>lua require("telescope.builtin").lsp_document_diagnostics()<CR>]],                                 {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>cf", [[<Cmd>lua vim.lsp.buf.formatting()<CR>]],       {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>cr", [[<Cmd>lua vim.lsp.buf.rename()<CR>]],           {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<Leader>cf", [[<Cmd>lua vim.lsp.buf.range_formatting()<CR>]], {noremap = true, silent = true})

-- Add more details when highlighting search matches.
vim.api.nvim_set_keymap("",  "*",  [[<Plug>(asterisk-z*)<Cmd>lua require("hlslens").start()<CR>]],  {})
vim.api.nvim_set_keymap("",  "#",  [[<Plug>(asterisk-z#)<Cmd>lua require("hlslens").start()<CR>]],  {})
vim.api.nvim_set_keymap("",  "g*", [[<Plug>(asterisk-zg*)<Cmd>lua require("hlslens").start()<CR>]], {})
vim.api.nvim_set_keymap("",  "g#", [[<Plug>(asterisk-zg#)<Cmd>lua require("hlslens").start()<CR>]], {})
vim.api.nvim_set_keymap("n", "n",  [[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("hlslens").start()<CR>]], {noremap = true})
vim.api.nvim_set_keymap("n", "N",  [[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("hlslens").start()<CR>]], {noremap = true})

-- Turn off search highlighting with <C-l>.
vim.api.nvim_set_keymap("n", "<C-l>", [[:nohlsearch<CR>]], {noremap = true, silent = true})

-- Disable ex mode.
vim.api.nvim_set_keymap("n", "Q", [[<Nop>]], {noremap = true, silent = true})

-- Make Y yank to end of line.
vim.api.nvim_set_keymap("n", "Y", [[y$]], {noremap = true, silent = true})

-- Prevent p from replacing the buffer by copying the pasted text.
vim.api.nvim_set_keymap("v", "p", [[pgvy]], {noremap = true, silent = true})

-- Preserve selection on indent.
vim.api.nvim_set_keymap("v", "<", [[<gv]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", ">", [[>gv]], {noremap = true, silent = true})

-- Invoke EasyAlign with ga{char}.
vim.api.nvim_set_keymap("x", "ga", [[<Plug>(EasyAlign)]], {})
vim.api.nvim_set_keymap("n", "ga", [[<Plug>(EasyAlign)]], {})

-- Toggle a floating terminal with <F5>.
vim.api.nvim_set_keymap("n", "<F5>", [[<Cmd>lua require("FTerm").toggle()<CR>]],           {noremap = true, silent = true})
vim.api.nvim_set_keymap("t", "<F5>", [[<C-\><C-n><Cmd>lua require("FTerm").toggle()<CR>]], {noremap = true, silent = true})
