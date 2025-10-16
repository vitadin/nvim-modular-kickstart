-- Neovim Options Configuration
-- See `:help vim.o` and `:help option-list`

-- Make line numbers default
vim.o.number = true

-- Enable relative line numbers for easier jumping
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Show wrapped line prefix
vim.o.showbreak = '⇢  '

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- See `:help 'list'` and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = {
	tab = '» ',
	space = '·',
	trail = '␣',
	nbsp = '⍽',
	extends = '›',
	precedes = '‹',
}

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- If performing an operation that would fail due to unsaved changes,
-- raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Set line spacing (only works in GUI clients like neovide)
vim.o.linespace = 2

-- Text wrapping width (for gq command)
-- Set to 80 characters by default (common standard)
-- Use :set textwidth=100 to change temporarily
vim.o.textwidth = 80
