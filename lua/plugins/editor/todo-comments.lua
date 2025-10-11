-- Todo Comments: Highlight todo, notes, etc in comments
-- See `:help todo-comments.nvim`

return {
	'folke/todo-comments.nvim',
	event = 'VimEnter',
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts = { signs = false },
}
