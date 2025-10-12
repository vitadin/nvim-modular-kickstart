-- Wilder.nvim: Better command-line with fuzzy completion
-- Shows command-line in center of screen with popup completion
-- Repository: https://github.com/gelguy/wilder.nvim

return {
	'gelguy/wilder.nvim',
	config = function()
		local wilder = require 'wilder'

		-- Enable wilder
		wilder.setup {
			modes = { ':', '/', '?' },
			-- Enable fuzzy matching
			next_key = '<Tab>',
			previous_key = '<S-Tab>',
			accept_key = '<Down>',
			reject_key = '<Up>',
		}

		-- Set up the appearance
		wilder.set_option('pipeline', {
			wilder.branch(
				-- For commands, use cmdline pipeline
				wilder.cmdline_pipeline {
					fuzzy = 1,
					fuzzy_filter = wilder.lua_fzy_filter(),
				},
				-- For search, use search pipeline
				wilder.search_pipeline()
			),
		})

		-- Popup menu renderer with centered position
		wilder.set_option(
			'renderer',
			wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
				highlights = {
					border = 'Normal', -- Highlight for border
					accent = 'WilderAccent', -- Highlight for selected item
				},
				border = 'rounded', -- 'single', 'double', 'rounded' or 'solid'
				max_height = '20%', -- Max height of the popup menu
				min_height = 0, -- Minimum height
				prompt_position = 'top', -- 'top' or 'bottom'
				reverse = 0, -- Set to 1 to reverse the order of the list
				-- Position the popup in center of screen
				left = { ' ', wilder.popupmenu_devicons() },
				right = { ' ', wilder.popupmenu_scrollbar() },
			})
		)

		-- Custom highlights for wilder
		vim.api.nvim_set_hl(0, 'WilderAccent', { fg = '#5ea1ff' })
	end,
}
