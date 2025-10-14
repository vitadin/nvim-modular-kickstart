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
	keys = {
		{ 'mm', mode = { 'n' } },
		{ '<leader>ma', mode = { 'n' } },
		{ '<leader>ml', mode = { 'n' } },
		{ '<leader>mc', mode = { 'n' } },
		{ ']b', mode = { 'n' } },
		{ '[b', mode = { 'n' } },
	},
	branch = 'main',
	dependencies = { 'nvim-web-devicons' },
	config = function()
		require('bookmarks').setup {
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
				-- Toggle bookmark at current line (mm = mark mark)
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
		require('telescope').load_extension 'bookmarks'
	end,
}
