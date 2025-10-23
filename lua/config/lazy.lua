-- Bootstrap lazy.nvim plugin manager
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'--branch=stable',
		lazyrepo,
		lazypath,
	}
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Setup lazy.nvim
-- To check the current status of your plugins, run `:Lazy`
-- To update plugins you can run `:Lazy update`
require('lazy').setup({
	-- Import all plugin specifications from the plugins directory
	{ import = 'plugins.ui' },
	{ import = 'plugins.editor' },
	{ import = 'plugins.lsp' },
	{ import = 'plugins.coding' },
	{ import = 'plugins.git' },

	-- Import user's custom plugins (local plugin development)
	-- Files in lua/custom/ are git-ignored, perfect for personal plugins
	{ import = 'custom.plugins' },
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = '⌘',
			config = '🛠',
			event = '📅',
			ft = '📂',
			init = '⚙',
			keys = '🗝',
			plugin = '🔌',
			runtime = '💻',
			require = '🌙',
			source = '📄',
			start = '🚀',
			task = '📌',
			lazy = '💤 ',
		},
	},
})
