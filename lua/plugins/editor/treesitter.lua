-- Treesitter: Highlight, edit, and navigate code
-- See `:help nvim-treesitter`
--
-- TROUBLESHOOTING:
-- If you see "attempt to call method 'parent' (a nil value)" errors:
-- This usually means OLD PARSER BINARIES are cached from a previous Neovim version.
--
-- IMPORTANT: If you upgraded Neovim (e.g., 0.9 → 0.11), you MUST clear parser cache!
--
-- Quick fix (do these in order):
-- 1. Clear parser cache: rm -rf ~/.local/share/nvim/nvim-treesitter
-- 2. Clear plugin cache: rm -rf ~/.local/share/nvim/lazy/nvim-treesitter
-- 3. Restart Neovim
-- 4. Run :Lazy sync (updates nvim-treesitter)
-- 5. Run :TSUpdate (rebuilds all parsers for your Neovim version)
--
-- The parser binaries are compiled for specific Neovim versions and are NOT compatible
-- across major version upgrades. Always clear cache after upgrading Neovim!

return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	main = 'nvim-treesitter.configs', -- Sets main module to use for opts

	-- Let Lazy.nvim use the default branch (master) for better compatibility
	-- Uncomment below ONLY if you have specific version issues:
	-- branch = 'main',  -- For bleeding-edge Neovim (0.11+)
	-- commit = 'v0.9.2',  -- For pinning to a stable version

	opts = {
		ensure_installed = {
			'bash',
			'c',
			'cpp',
			'diff',
			'go',
			'html',
			'lua',
			'luadoc',
			'markdown',
			'markdown_inline',
			'python',
			'query',
			'vim',
			'vimdoc',
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		-- Prevent installation of these parsers (VimTeX handles LaTeX)
		ignore_install = { 'latex' },
		highlight = {
			enable = true,
			-- Disable treesitter for LaTeX files (VimTeX provides better highlighting)
			disable = { 'latex' },
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { 'ruby' },
		},
		indent = { enable = true, disable = { 'ruby', 'latex' } },

		-- Disable query predicates that may cause compatibility issues
		-- This fixes the "attempt to call method 'parent' (a nil value)" error
		query_linter = {
			enable = false,
		},
	},

	-- Add error handling for treesitter issues
	config = function(_, opts)
		-- Check Neovim version and warn about potential issues
		local nvim_version = vim.version()
		local version_str = string.format('%d.%d.%d', nvim_version.major, nvim_version.minor, nvim_version.patch or 0)

		-- Check if parser cache might be stale from previous Neovim version
		local parser_cache = vim.fn.stdpath 'data' .. '/nvim-treesitter'
		local cache_exists = vim.fn.isdirectory(parser_cache) == 1

		if cache_exists then
			-- Check if any .so files exist (compiled parsers)
			local parsers = vim.fn.glob(parser_cache .. '/parser/*.so', false, true)
			if #parsers > 0 then
				-- Warn user that cache might be from old Neovim version
				vim.notify(
					string.format(
						'nvim-treesitter: Found cached parsers. If you upgraded Neovim, clear cache:\n' ..
						'rm -rf %s',
						parser_cache
					),
					vim.log.levels.WARN,
					{ title = 'Treesitter Cache Warning' }
				)
			end
		end

		-- Warn if using development version (0.11+) which may have API changes
		if nvim_version.major == 0 and nvim_version.minor >= 11 then
			vim.notify(
				string.format(
					'nvim-treesitter: Development Neovim %s detected. Run :TSUpdate after clearing cache',
					version_str
				),
				vim.log.levels.INFO
			)
		elseif nvim_version.major == 0 and nvim_version.minor < 10 then
			vim.notify(
				string.format(
					'nvim-treesitter: Neovim %s detected. Recommend upgrading to 0.10+',
					version_str
				),
				vim.log.levels.WARN
			)
		end

		-- Setup treesitter with error handling
		local ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
		if not ok then
			vim.notify(
				'Failed to load nvim-treesitter. Try:\n' ..
				'1. :Lazy sync\n' ..
				'2. Restart Neovim\n' ..
				'3. :TSUpdate',
				vim.log.levels.ERROR,
				{ title = 'Treesitter Error' }
			)
			return
		end

		-- Setup with another layer of error handling
		local setup_ok, setup_err = pcall(ts_configs.setup, opts)
		if not setup_ok then
			vim.notify(
				'Treesitter setup failed: ' .. tostring(setup_err),
				vim.log.levels.ERROR
			)
			return
		end

		-- Workaround for query predicate compatibility issues
		-- Overrides problematic predicates that may call undefined methods
		local query_ok = pcall(function()
			if vim.treesitter.query and vim.treesitter.query.add_predicate then
				vim.treesitter.query.add_predicate('vim-match?', function()
					return true
				end, { force = true })
			end
		end)

		if not query_ok then
			-- Silent fail - predicate override not critical
		end
	end,
	-- There are additional nvim-treesitter modules that you can use to interact
	-- with nvim-treesitter. You should go explore a few and see what interests you:
	--
	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
