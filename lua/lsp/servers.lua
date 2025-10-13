-- LSP Server Configurations Entry Point
-- This file automatically loads all server configurations from lua/lsp/servers/
--
-- To add a new LSP server:
-- 1. Create a new file: lua/lsp/servers/<server_name>.lua
-- 2. Return a configuration table with server-specific settings
-- 3. The server will be automatically loaded and installed by Mason
--
-- Each server file can contain:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes
--  - capabilities (table): Override fields in capabilities
--  - settings (table): Server-specific settings (e.g., lua_ls settings)
--  - init_options (table): Initialization options passed to the server
--
-- See `:help lspconfig-all` for a list of all available LSP servers
-- See existing files in lua/lsp/servers/ for examples

local M = {}

-- Automatically load all server configs from lua/lsp/servers/
local servers_path = vim.fn.stdpath 'config' .. '/lua/lsp/servers'
local server_files = vim.fn.glob(servers_path .. '/*.lua', false, true)

for _, filepath in ipairs(server_files) do
	local filename = vim.fn.fnamemodify(filepath, ':t:r')
	local ok, server_config = pcall(require, 'lsp.servers.' .. filename)
	if ok and server_config then
		M[filename] = server_config
	else
		vim.notify(
			string.format('Failed to load LSP server config: %s', filename),
			vim.log.levels.WARN
		)
	end
end

return M
