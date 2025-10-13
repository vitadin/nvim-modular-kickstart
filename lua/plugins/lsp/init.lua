-- LSP Configuration
-- See `:help lsp` and `:help lspconfig`

return {
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		-- Mason must be loaded before its dependents so we need to set it up here.
		{ 'mason-org/mason.nvim', opts = {} },
		'mason-org/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',

		-- Useful status updates for LSP.
		-- Shows LSP progress notifications in bottom-right corner
		{
			'j-hui/fidget.nvim',
			opts = {
				notification = {
					window = {
						winblend = 0, -- Background transparency (0 = opaque, 100 = transparent)
						relative = 'editor', -- Position relative to editor
						align = 'bottom', -- Align to bottom of editor
						x_padding = 1,
						y_padding = 1,
					},
				},
				progress = {
					display = {
						done_icon = '✓', -- Icon when task is done
						progress_icon = { pattern = 'dots', period = 1 }, -- Spinner animation
					},
				},
			},
		},

		-- Allows extra capabilities provided by blink.cmp
		'saghen/blink.cmp',
	},
	config = function()
		-- Brief aside: **What is LSP?**
		--
		-- LSP is an initialism you've probably heard, but might not understand what it is.
		--
		-- LSP stands for Language Server Protocol. It's a protocol that helps editors
		-- and language tooling communicate in a standardized fashion.
		--
		-- In general, you have a "server" which is some tool built to understand a particular
		-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
		-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
		-- processes that communicate with some "client" - in this case, Neovim!
		--
		-- LSP provides Neovim with features like:
		--  - Go to definition
		--  - Find references
		--  - Autocompletion
		--  - Symbol Search
		--  - and more!
		--
		-- Thus, Language Servers are external tools that must be installed separately from
		-- Neovim. This is where `mason` and related plugins come into play.
		--
		-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
		-- and elegantly composed help section, `:help lsp-vs-treesitter`

		-- Load LSP keymaps
		require 'plugins.lsp.keymaps'

		-- Diagnostic Config
		-- See :help vim.diagnostic.Opts
		vim.diagnostic.config {
			severity_sort = true,
			float = { border = 'rounded', source = 'if_many' },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = '󰅚 ',
					[vim.diagnostic.severity.WARN] = '󰀪 ',
					[vim.diagnostic.severity.INFO] = '󰋽 ',
					[vim.diagnostic.severity.HINT] = '󰌶 ',
				},
			} or {},
			virtual_text = {
				source = 'if_many',
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		}

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
		local capabilities = require('blink.cmp').get_lsp_capabilities()

		-- Load server configurations
		local servers = require 'lsp.servers'

		-- Ensure the servers and tools are installed
		--
		-- To check the current status of installed tools and/or manually install
		-- other tools, you can run `:Mason`
		--
		-- You can press `g?` for help in this menu.
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			'stylua', -- Used to format Lua code
		})
		require('mason-tool-installer').setup {
			ensure_installed = ensure_installed,
		}

		-- Setup mason-lspconfig with handlers
		-- This bridges mason and lspconfig, ensuring installed servers are configured
		require('mason-lspconfig').setup {
			-- Ensure these servers are installed (mason will install them)
			ensure_installed = vim.tbl_keys(servers or {}),
			-- Automatically setup servers using handlers
			automatic_installation = true,
			-- Register handlers for server setup
			handlers = {
				-- Default handler for all servers
				function(server_name)
					local server = servers[server_name] or {}
					-- Merge capabilities from blink.cmp with server-specific capabilities
					server.capabilities = vim.tbl_deep_extend(
						'force',
						{},
						capabilities,
						server.capabilities or {}
					)
					-- Setup the LSP server with lspconfig
					require('lspconfig')[server_name].setup(server)
				end,
			},
		}
	end,
}
