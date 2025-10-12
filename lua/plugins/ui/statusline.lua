-- Mini.nvim: Collection of various small independent plugins/modules
-- Consolidated configuration for all mini.nvim modules
-- See https://github.com/echasnovski/mini.nvim

return {
	'echasnovski/mini.nvim',
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require('mini.ai').setup { n_lines = 500 }

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require('mini.surround').setup()

		-- Simple and easy statusline with mode indicator
		--
		-- Shows current mode (NORMAL, INSERT, VISUAL, etc.) on the left
		local statusline = require 'mini.statusline'
		statusline.setup {
			use_icons = vim.g.have_nerd_font,
			-- Explicitly set content to show mode
			content = {
				active = nil, -- Use default active content (includes mode)
				inactive = nil, -- Use default inactive content
			},
			-- Default active content shows:
			-- - Mode name (NORMAL/INSERT/VISUAL/etc.) on the left
			-- - Git branch and diff stats
			-- - Diagnostics (errors, warnings)
			-- - File info (filename, modified status)
			-- - Location (line:column) on the right
			set_vim_settings = true, -- Enable vim.opt.laststatus = 3
		}

		-- Customize the location section to show LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return '%2l:%-2v'
		end

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}
