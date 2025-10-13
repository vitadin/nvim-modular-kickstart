-- Lua Language Server Configuration
-- Repository: https://github.com/LuaLS/lua-language-server
-- Documentation: https://luals.github.io/wiki/settings/
--
-- This LSP provides:
-- - Code completion for Lua
-- - Go to definition
-- - Find references
-- - Type checking and diagnostics
-- - Neovim API support (vim.*, vim.fn.*, etc.)

return {
	-- cmd = {...},  -- Override command if needed
	-- filetypes = { 'lua' },  -- Default filetypes
	-- capabilities = {},  -- Override capabilities if needed
	settings = {
		Lua = {
			completion = {
				callSnippet = 'Replace',
			},
			-- Uncomment to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
}
