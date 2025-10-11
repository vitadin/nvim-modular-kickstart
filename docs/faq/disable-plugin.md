# How do I temporarily disable a plugin without removing it?

Sometimes you want to disable a plugin temporarily for testing or
troubleshooting without deleting its configuration.

## Method 1: Using `enabled = false`

The simplest method - add `enabled = false` to the plugin spec:

```lua
-- lua/plugins/editor/telescope.lua
return {
	'nvim-telescope/telescope.nvim',
	enabled = false,  -- Disabled
	event = 'VimEnter',
	-- ... rest of configuration stays the same
}
```

Restart Neovim. The plugin stays installed but won't load.

To re-enable, just remove the `enabled = false` line.

## Method 2: Conditional Enabling

Disable based on conditions:

### Disable for Specific Filetypes

```lua
return {
	'author/plugin-name',
	enabled = function()
		-- Only enable for Lua files
		return vim.bo.filetype == 'lua'
	end,
}
```

### Disable on Certain Systems

```lua
return {
	'author/plugin-name',
	enabled = function()
		-- Disable on Windows
		return vim.fn.has('win32') == 0
	end,
}
```

### Disable Based on Environment Variable

```lua
return {
	'author/plugin-name',
	enabled = function()
		-- Disable in minimal mode
		return vim.env.NVIM_MINIMAL ~= '1'
	end,
}
```

Usage:
```sh
# Normal mode - plugin loads
nvim

# Minimal mode - plugin disabled
NVIM_MINIMAL=1 nvim
```

### Disable for Large Files

```lua
return {
	'nvim-treesitter/nvim-treesitter',
	enabled = function()
		-- Disable for files > 100KB
		local file = vim.fn.expand '%'
		local size = vim.fn.getfsize(file)
		return size < 100000 or size == -1
	end,
}
```

## Method 3: Using Global Flag

Create a central toggle for multiple plugins:

```lua
-- lua/config/options.lua
_G.enable_experimental_plugins = false
```

Then use it in plugin specs:

```lua
-- lua/plugins/editor/experimental-plugin.lua
return {
	'author/experimental-plugin',
	enabled = _G.enable_experimental_plugins,
}
```

## Method 4: Profile-Based Configuration

Create different profiles:

```lua
-- lua/config/profiles.lua
local profile = vim.env.NVIM_PROFILE or 'default'

return {
	default = {
		enable_git = true,
		enable_telescope = true,
		enable_lsp = true,
	},
	minimal = {
		enable_git = false,
		enable_telescope = false,
		enable_lsp = true,  -- Keep LSP only
	},
}
```

Use in plugins:

```lua
-- lua/plugins/editor/telescope.lua
local profile = require('config.profiles')
return {
	'nvim-telescope/telescope.nvim',
	enabled = profile.enable_telescope,
}
```

Run with different profiles:
```sh
# Default profile
nvim

# Minimal profile
NVIM_PROFILE=minimal nvim
```

## Method 5: Comment Out Import

Disable entire plugin category by commenting the import:

```lua
-- lua/config/lazy.lua
require('lazy').setup({
	{ import = 'plugins.ui' },
	-- { import = 'plugins.editor' },  -- All editor plugins disabled
	{ import = 'plugins.lsp' },
	{ import = 'plugins.coding' },
	{ import = 'plugins.git' },
}, { ... })
```

## Practical Examples

### Example 1: Testing Performance

Disable plugins to test startup time:

```lua
-- Temporarily disable to benchmark
return {
	'lewis6991/gitsigns.nvim',
	enabled = false,  -- Test startup without this
}
```

Then:
```sh
nvim --startuptime startup.log +qa
cat startup.log | grep 'TOTAL'
```

### Example 2: Conflict Resolution

Disable one of two conflicting plugins:

```lua
-- Trying out different statusline plugins
-- lua/plugins/ui/lualine.lua
return {
	'nvim-lualine/lualine.nvim',
	enabled = true,  -- Currently active
}

-- lua/plugins/ui/heirline.lua
return {
	'rebelot/heirline.nvim',
	enabled = false,  -- Testing lualine first
}
```

### Example 3: Work vs Personal Config

```lua
return {
	'author/personal-plugin',
	enabled = function()
		-- Only at home
		return vim.env.HOME:match('/Users/username')
	end,
}
```

### Example 4: Disable for SSH

```lua
return {
	'author/plugin-with-gui-features',
	enabled = function()
		-- Disable when connected via SSH
		return vim.env.SSH_CONNECTION == nil
	end,
}
```

## Checking Disabled Plugins

### View in Lazy UI

```vim
:Lazy
" Disabled plugins show as grayed out
" Hover over them to see why they're disabled
```

### List All Disabled

```sh
cd ~/.config/nvim
grep -r "enabled = false" lua/plugins/
```

## Re-enabling Plugins

### Method 1: Change enabled Flag

```lua
-- Change from:
enabled = false,

-- To:
enabled = true,
-- Or just remove the line entirely
```

### Method 2: Force Load Temporarily

```vim
" In running Neovim session
:Lazy load plugin-name
" Forces loading even if enabled = false
```

## Best Practices

### ✅ DO:
- Use `enabled = false` for temporary disabling
- Use conditional enabling for environment-specific behavior
- Document why a plugin is disabled (add comment)
- Keep plugin configuration even when disabled

### ❌ DON'T:
- Delete plugin files when testing (hard to restore)
- Have conflicting plugins both enabled
- Disable critical plugins (colorscheme, LSP core)
- Forget to clean up `enabled = false` after testing

## Debugging Disabled Plugins

**Q: I removed `enabled = false` but plugin still doesn't load**

A: Check:
```vim
:Lazy
" Is it still showing as disabled?

:messages
" Any errors during load?

" Try forcing sync
:Lazy sync
```

**Q: How do I know why a plugin is disabled?**

A: Check the enabled function:
```lua
enabled = function()
	print('Checking if plugin should enable...')
	print('Current filetype:', vim.bo.filetype)
	return true  -- Or false
end,
```

**Q: Can I disable a plugin only in certain buffers?**

A: Yes, but use autocommands instead:
```lua
-- In the plugin's config
config = function()
	require('plugin').setup()

	-- Disable in specific filetypes
	vim.api.nvim_create_autocmd('FileType', {
		pattern = { 'markdown', 'text' },
		callback = function()
			-- Disable plugin features for this buffer
			vim.b.plugin_enabled = false
		end,
	})
end,
```

## Alternative: Lazy-Load Instead

Sometimes lazy-loading is better than disabling:

```lua
-- Instead of disabling:
return {
	'author/plugin',
	enabled = false,
}

-- Consider lazy-loading:
return {
	'author/plugin',
	cmd = 'PluginCommand',  -- Only loads when command is used
	-- or
	keys = {
		{ '<leader>x', '<cmd>Command<cr>' },
	},
}
```

This keeps the plugin available but doesn't slow startup.

[Back to FAQ](../../README.md#faq)
