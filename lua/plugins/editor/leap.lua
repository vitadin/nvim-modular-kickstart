-- Leap.nvim: Lightning-fast motion plugin
-- See https://github.com/ggandor/leap.nvim

return {
	'ggandor/leap.nvim',
	dependencies = { 'tpope/vim-repeat' },
	config = function()
		local leap = require 'leap'

		-- Set up leap with default settings
		leap.setup {
			-- Maximum number of phase one targets
			max_phase_one_targets = nil,
			-- Highlight group for unlabeled matches
			highlight_unlabeled_phase_one_targets = false,
			-- Maximum number of highlighted phase two targets
			max_highlighted_traversal_targets = 10,
			-- Case sensitivity
			case_sensitive = false,
			-- Equivalence classes for special characters
			equivalence_classes = { ' \t\r\n' },
			-- Substitute for ambiguous characters
			substitute_chars = {},
			-- Safe labels (letters that are easy to reach)
			safe_labels = 'sfnut/SFNLHMUGTZ?',
			-- Labels to use for targets
			labels = 'sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?',
			-- Special keys
			special_keys = {
				next_target = '<enter>',
				prev_target = '<tab>',
				next_group = '<space>',
				prev_group = '<tab>',
			},
		}

		-- Set default keymaps
		-- Leap forward to a location
		vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)', {
			desc = 'Leap forward',
		})

		-- Leap backward to a location
		vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)', {
			desc = 'Leap backward',
		})

		-- Leap from windows (leap to any visible window)
		vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)', {
			desc = 'Leap from window',
		})
	end,
}
