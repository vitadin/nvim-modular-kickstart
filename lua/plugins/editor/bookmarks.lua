-- Bookmarks - Temporary session bookmarks for quick jumping between positions
-- Perfect for: jumping between instruction doc and code file
-- See: https://github.com/crusj/bookmarks.nvim
--
-- Usage:
--   mm          - Toggle bookmark at current position (mark mark)
--   <leader>ma  - Show all bookmarks (Telescope picker)
--   ]b / [b     - Next/previous bookmark
--
-- These are temporary session bookmarks - they disappear when you close Neovim

return {
	'crusj/bookmarks.nvim',
	-- Load on VimEnter to ensure it's always available
	event = 'VimEnter',
	branch = 'main',
	dependencies = { 'nvim-web-devicons', 'nvim-telescope/telescope.nvim' },
	config = function()
		local bookmarks = require 'bookmarks'

		-- Setup bookmarks
		bookmarks.setup {
			-- Save bookmarks in memory only (not persisted to disk)
			-- They disappear when you close Neovim - perfect for temporary workflow
			save_file = vim.fn.stdpath 'data' .. '/bookmarks',
			keywords = {
				['@t'] = '☑️ ', -- Task
				['@w'] = '⚠️ ', -- Warning
				['@f'] = '⭐ ', -- Feature
				['@n'] = '📝 ', -- Note
			},
			on_attach = function(bufnr)
				local bm = require 'bookmarks'
				local map = vim.keymap.set
				-- Toggle bookmark at current line
				map('n', 'mm', bm.bookmark_toggle, { desc = 'Toggle bookmark', buffer = bufnr })
				-- Jump to next/previous bookmark
				map('n', ']b', bm.bookmark_next, { desc = 'Next bookmark', buffer = bufnr })
				map('n', '[b', bm.bookmark_prev, { desc = 'Previous bookmark', buffer = bufnr })
				-- Show all bookmarks in Telescope
				map('n', '<leader>ma', '<cmd>Telescope bookmarks list<cr>', { desc = 'Show [a]ll bookmarks', buffer = bufnr })
				map('n', '<leader>ml', '<cmd>Telescope bookmarks list<cr>', { desc = '[L]ist bookmarks', buffer = bufnr })
				-- Clear all bookmarks in current buffer
				map('n', '<leader>mc', bm.bookmark_clean, { desc = '[C]lear bookmarks in buffer', buffer = bufnr })
			end,
		}

		-- Load Telescope extension
		require('telescope').load_extension 'bookmarks'

		-- Set up global keymaps (in case on_attach doesn't work)
		vim.keymap.set('n', 'mm', bookmarks.bookmark_toggle, { desc = 'Toggle bookmark' })
		vim.keymap.set('n', ']b', bookmarks.bookmark_next, { desc = 'Next bookmark' })
		vim.keymap.set('n', '[b', bookmarks.bookmark_prev, { desc = 'Previous bookmark' })
		vim.keymap.set('n', '<leader>ma', '<cmd>Telescope bookmarks list<cr>', { desc = 'Show [a]ll bookmarks' })
		vim.keymap.set('n', '<leader>ml', '<cmd>Telescope bookmarks list<cr>', { desc = '[L]ist bookmarks' })
		vim.keymap.set('n', '<leader>mc', bookmarks.bookmark_clean, { desc = '[C]lear bookmarks in buffer' })
	end,
}
