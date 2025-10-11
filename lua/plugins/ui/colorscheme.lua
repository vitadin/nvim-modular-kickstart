-- Colorscheme Configuration
-- You can easily change to a different colorscheme.
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

return {
	'folke/tokyonight.nvim',
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require('tokyonight').setup {
			styles = {
				comments = { italic = false }, -- Disable italics in comments
			},
		}

		-- Load the colorscheme here.
		-- Like many other themes, this one has different styles, and you could load
		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.cmd.colorscheme 'tokyonight-night'
	end,
}
