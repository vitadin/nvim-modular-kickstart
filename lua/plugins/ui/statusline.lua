-- Statusline Configuration using mini.statusline
-- Part of the mini.nvim collection

return {
	'echasnovski/mini.nvim',
	config = function()
		-- Simple and easy statusline with mode indicator
		--
		-- Shows current mode (NORMAL, INSERT, VISUAL, etc.) on the left
		local statusline = require 'mini.statusline'
		statusline.setup {
			use_icons = vim.g.have_nerd_font,
			-- Default content shows:
			-- - Mode name (NORMAL/INSERT/VISUAL/etc.) on the left
			-- - Git branch and diff stats
			-- - Diagnostics (errors, warnings)
			-- - File info (filename, modified status)
			-- - Location (line:column) on the right
		}

		-- Customize the location section to show LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return '%2l:%-2v'
		end

		-- Check out more mini.nvim modules:
		-- https://github.com/echasnovski/mini.nvim
	end,
}
