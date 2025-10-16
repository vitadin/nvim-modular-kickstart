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
	branch = 'main',
	dependencies = { 'nvim-web-devicons' },
	config = function()
		require('bookmarks').setup {
			save_file = vim.fn.expand '$HOME/.bookmarks', -- bookmarks save file path
			keywords = {
				['@t'] = '☑️ ', -- mark annotation startswith @t ,signs this icon as `Todo`
				['@w'] = '⚠️ ', -- mark annotation startswith @w ,signs this icon as `Warn`
				['@f'] = '⛏ ', -- mark annotation startswith @f ,signs this icon as `Fix`
				['@n'] = ' ', -- mark annotation startswith @n ,signs this icon as `Note`
			},
			on_attach = function(bufnr)
				local bm = require 'bookmarks'
				local map = vim.keymap.set
				map('n', 'mm', bm.bookmark_toggle) -- add or remove bookmark at current line
				map('n', 'mi', bm.bookmark_ann) -- add or edit mark annotation at current line
				map('n', 'mc', bm.bookmark_clean) -- clean all marks in local buffer
				map('n', 'mn', bm.bookmark_next) -- jump to next mark in local buffer
				map('n', 'mp', bm.bookmark_prev) -- jump to previous mark in local buffer
				map('n', 'ml', bm.bookmark_list) -- show marked file list in quickfix window
				map('n', 'mx', bm.bookmark_clear_all) -- removes all bookmarks
			end,
		}
	end,
}
