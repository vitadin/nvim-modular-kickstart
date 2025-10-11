# How do I add a new plugin?

Adding a new plugin is simple: create a new Lua file in the appropriate
`lua/plugins/` subdirectory.

## Basic Example

```lua
-- lua/plugins/editor/my-plugin.lua
return {
	'author/plugin-name',  -- GitHub username/repo
	event = 'VeryLazy',    -- Lazy load after UI loads
}
```

Restart Neovim or run `:Lazy sync` to install.

## Full Example with Configuration

```lua
-- lua/plugins/editor/nvim-surround.lua
return {
	'kylechui/nvim-surround',
	version = '*',  -- Use latest stable release
	event = 'VeryLazy',
	dependencies = {
		'nvim-treesitter/nvim-treesitter',  -- Optional dependencies
	},
	opts = {
		-- Plugin options passed to setup()
		keymaps = {
			normal = 'ys',
			delete = 'ds',
			change = 'cs',
		},
	},
	-- OR use config function for more control:
	config = function()
		require('nvim-surround').setup {
			-- Custom configuration
		}
	end,
}
```

## Choosing the Right Directory

Place your plugin file in the appropriate category:

| Directory | Purpose | Examples |
|-----------|---------|----------|
| `lua/plugins/ui/` | UI enhancements | Colorschemes, statusline, bufferline, indent guides |
| `lua/plugins/editor/` | Editor features | Fuzzy finders, file trees, terminal, sessions |
| `lua/plugins/lsp/` | LSP-related | Language servers, diagnostics, code actions |
| `lua/plugins/coding/` | Coding tools | Completion, snippets, auto-pairs, comments |
| `lua/plugins/git/` | Git integration | Gitsigns, fugitive, diffview |

## Common Plugin Options

### Lazy Loading (recommended for performance)

```lua
return {
	'author/plugin',

	-- Load after UI is ready
	event = 'VeryLazy',

	-- Load on specific Neovim events
	event = { 'BufReadPre', 'BufNewFile' },

	-- Load when command is used
	cmd = { 'CommandName', 'AnotherCommand' },

	-- Load when key is pressed
	keys = {
		{ '<leader>x', '<cmd>CommandName<cr>', desc = 'Description' },
	},

	-- Load for specific filetypes
	ft = { 'lua', 'python', 'javascript' },
}
```

### Dependencies

```lua
return {
	'author/plugin',
	dependencies = {
		'required/dependency',
		{ 'another/dependency', opts = { ... } },
	},
}
```

### Version Pinning

```lua
return {
	'author/plugin',
	version = '*',        -- Use latest stable release
	-- OR
	tag = 'v1.2.3',       -- Pin to specific tag
	-- OR
	branch = 'stable',    -- Pin to specific branch
	-- OR
	commit = 'abc123',    -- Pin to specific commit
}
```

## Complete Real-World Example

Here's how to add `trouble.nvim` for better diagnostics:

```lua
-- lua/plugins/editor/trouble.lua
return {
	'folke/trouble.nvim',
	cmd = { 'Trouble' },  -- Lazy load on command
	dependencies = {
		'nvim-tree/nvim-web-devicons',  -- For icons
	},
	opts = {
		position = 'bottom',
		height = 10,
		icons = true,
		mode = 'workspace_diagnostics',
		fold_open = '',
		fold_closed = '',
		action_keys = {
			close = 'q',
			refresh = 'r',
		},
	},
	keys = {
		{
			'<leader>xx',
			'<cmd>Trouble diagnostics toggle<cr>',
			desc = 'Diagnostics (Trouble)',
		},
		{
			'<leader>xd',
			'<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
			desc = 'Buffer Diagnostics (Trouble)',
		},
	},
}
```

## Verifying Installation

After adding the plugin:

1. Restart Neovim or run `:Lazy sync`
2. Check installation: `:Lazy`
3. Look for your plugin in the list
4. Check for errors: `:messages`

## Running Code Quality Checks

After adding a new plugin file:

```sh
# Format the new file
make format-fix

# Verify it passes checks
make check
```

[Back to FAQ](../../README.md#faq)
