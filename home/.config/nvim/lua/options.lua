-- Disable swap files.
vim.opt.swapfile = false

-- Enable persistent undo.
vim.opt.undofile = true

-- Allow editing with multiple buffers.
vim.opt.hidden = true

-- Use 4 spaces for indentation.
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.shiftround = true

-- Ignore case unless searching with uppercase letters.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show the effects of a command as it is typed.
vim.opt.inccommand = "nosplit"

-- Use a single space when joining lines.
vim.opt.joinspaces = false

-- Show relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Draw right margin at 80 characters.
vim.opt.colorcolumn = "80"

-- Pad the cursor with 5 lines.
vim.opt.scrolloff = 5

-- Do not display end-of-buffer tildes.
vim.opt.fillchars:append("eob: ")

-- Display hidden characters.
vim.opt.list = true
vim.opt.listchars:append("tab:——▷")
vim.opt.listchars:append("trail:·")

-- Enable spell checking.
vim.opt.spell = true

-- Make completion mode act like Bash.
vim.opt.wildmode = "longest,list"

-- Always show sign column.
vim.opt.signcolumn = "yes"

-- Hide redundant notification of current mode.
vim.opt.showmode = false

-- Split windows below and to the right.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Save most things in the session.
vim.opt.sessionoptions = "buffers,curdir,folds,tabpages,terminal,winpos,winsize"
