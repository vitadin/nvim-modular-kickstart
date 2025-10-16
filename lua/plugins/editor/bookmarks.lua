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
	event = 'VimEnter', -- Load on startup
	config = function()
		local ok, bookmarks = pcall(require, 'bookmarks')
		if not ok then
			vim.notify('Failed to load bookmarks.nvim plugin', vim.log.levels.ERROR)
			return
		end

		local setup_ok, err = pcall(bookmarks.setup, {
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
				map('n', 'mm', bm.bookmark_toggle, { buffer = bufnr, desc = 'Toggle bookmark' })
				map('n', 'mi', bm.bookmark_ann, { buffer = bufnr, desc = 'Annotate bookmark' })
				map('n', 'mc', bm.bookmark_clean, { buffer = bufnr, desc = 'Clean bookmarks' })
				map('n', 'mn', bm.bookmark_next, { buffer = bufnr, desc = 'Next bookmark' })
				map('n', 'mp', bm.bookmark_prev, { buffer = bufnr, desc = 'Previous bookmark' })
				map('n', 'ml', bm.bookmark_list, { buffer = bufnr, desc = 'List bookmarks' })
				map('n', 'mx', bm.bookmark_clear_all, { buffer = bufnr, desc = 'Clear all bookmarks' })
			end,
		})

		if not setup_ok then
			vim.notify('Bookmarks setup failed: ' .. tostring(err), vim.log.levels.ERROR)
			return
		end

		vim.notify('Bookmarks.nvim loaded successfully', vim.log.levels.INFO)
	end,
}
