-- Wilder.nvim: Better command-line with fuzzy completion
-- Shows command-line in center of screen with popup completion
-- Repository: https://github.com/gelguy/wilder.nvim

return {
	'gelguy/wilder.nvim',
	dependencies = {
		'romgrk/fzy-lua-native', -- Fuzzy matching engine
	},
	-- Note: build command removed because it causes issues in headless testing
	-- Wilder will work fine without it for basic fuzzy completion
	config = function()
		local wilder = require 'wilder'

		-- Disable native wildmenu to prevent conflicts with wilder
		vim.opt.wildmenu = false
		vim.opt.wildmode = ''

		-- Enable wilder
		wilder.setup {
			modes = { ':', '/', '?' },
			-- Enable fuzzy matching
			next_key = '<Tab>',
			previous_key = '<S-Tab>',
			accept_key = '<Down>',
			reject_key = '<Up>',
		}

		-- Set up the appearance with fuzzy filtering
		wilder.set_option('pipeline', {
			wilder.branch(
				-- For commands, use cmdline pipeline with fuzzy matching
				wilder.cmdline_pipeline {
					fuzzy = 1,
					fuzzy_filter = wilder.lua_fzy_filter(),
				},
				-- For search, use search pipeline
				wilder.search_pipeline()
			),
		})

		-- Popup menu with palette (centered command-line)
		wilder.set_option(
			'renderer',
			wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
				-- Palette theme centers the command-line and popup together
				border = 'rounded', -- 'single', 'double', 'rounded' or 'solid'
				max_height = '20%', -- Max height of the popup menu
				min_height = 0, -- Minimum height
				prompt_position = 'top', -- 'top' or 'bottom'
				reverse = 0, -- Set to 1 to reverse the order of the list
				pumblend = 20, -- Transparency (0-100, 0 = opaque)
				highlights = {
					border = 'Normal', -- Highlight for border
					accent = 'WilderAccent', -- Highlight for selected item
				},
				-- Decorations
				left = { ' ', wilder.popupmenu_devicons() },
				right = { ' ', wilder.popupmenu_scrollbar() },
			})
		)

		-- Custom highlights for wilder
		vim.api.nvim_set_hl(0, 'WilderAccent', { fg = '#5ea1ff' })
	end,
}
