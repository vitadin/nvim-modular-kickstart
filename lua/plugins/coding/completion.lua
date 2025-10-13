-- Autocompletion Configuration
-- Using blink.cmp with LuaSnip for snippet support

return {
	'saghen/blink.cmp',
	event = 'VimEnter',
	version = '1.*',
	dependencies = {
		-- Snippet Engine
		{
			'L3MON4D3/LuaSnip',
			version = '2.*',
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
					return
				end
				return 'make install_jsregexp'
			end)(),
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				-- {
				--   'rafamadriz/friendly-snippets',
				--   config = function()
				--     require('luasnip.loaders.from_vscode').lazy_load()
				--   end,
				-- },
			},
			opts = {},
		},
		-- Note: lazydev.nvim is configured separately in lua/plugins/lsp/lazydev.lua
		-- It loads on ft = 'lua' to provide Lua LSP completions for Neovim config
	},
	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		keymap = {
			-- 'default' (recommended) for mappings similar to built-in completions
			--   <c-y> to accept ([y]es) the completion.
			--    This will auto-import if your LSP supports it.
			--    This will expand snippets if the LSP sent a snippet.
			-- 'super-tab' for tab to accept
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- For an understanding of why the 'default' preset is recommended,
			-- you will need to read `:help ins-completion`
			--
			-- No, but seriously. Please read `:help ins-completion`, it is really good!
			--
			-- All presets have the following mappings:
			-- <tab>/<s-tab>: move to right/left of your snippet expansion
			-- <c-space>: Open menu or open docs if already open
			-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
			-- <c-e>: Hide menu
			-- <c-k>: Toggle signature help
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			preset = 'default',

			-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
			--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono',
		},

		completion = {
			-- Auto-show documentation popup (VSCode-like behavior)
			-- The popup appears automatically after a short delay when hovering over completion items
			-- Press <c-space> to manually toggle documentation if needed
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
		},

		sources = {
			-- Completion sources (order matters for priority)
			-- 'lsp' - Language server completions (functions, variables, etc.)
			-- 'path' - File path completions
			-- 'snippets' - Code snippets
			-- 'buffer' - Words from current buffer (essential for text files!)
			--
			-- Note: lazydev integration removed to avoid plugin loading issues
			-- Lua LSP (lua_ls) already provides Neovim API completions through the LSP source
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		snippets = { preset = 'luasnip' },

		-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
		-- which automatically downloads a prebuilt binary when enabled.
		--
		-- By default, we use the Lua implementation instead, but you may enable
		-- the rust implementation via `'prefer_rust_with_warning'`
		--
		-- See :h blink-cmp-config-fuzzy for more information
		fuzzy = { implementation = 'lua' },

		-- Shows a signature help window while you type arguments for a function
		signature = { enabled = true },
	},
}
