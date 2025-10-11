# How do I configure lazy-loading for better startup performance?

Lazy-loading plugins dramatically improves Neovim startup time by deferring
plugin loading until they're actually needed.

## Why Lazy-Load?

**Without lazy-loading:**
- All plugins load at startup
- Slower startup time (500ms+)
- Unnecessary plugins loaded for every file

**With lazy-loading:**
- Fast startup (50-100ms)
- Plugins load when needed
- Better resource usage

## Loading Strategies

### 1. Load After UI (VeryLazy)

Load plugins after Neovim UI is ready - good for non-essential plugins:

```lua
return {
	'author/plugin-name',
	event = 'VeryLazy',  -- Load after UI renders
}
```

**Use for:** Plugins that don't affect initial UI (git signs, statusline
enhancements, etc.)

### 2. Load on File Events

Load when opening or editing files:

```lua
return {
	'author/plugin-name',
	event = { 'BufReadPre', 'BufNewFile' },
}
```

**Common events:**
- `BufReadPre` - Before reading a file
- `BufNewFile` - Creating a new file
- `BufEnter` - Entering a buffer
- `InsertEnter` - Entering insert mode

### 3. Load on Commands

Load only when a specific command is used:

```lua
return {
	'folke/trouble.nvim',
	cmd = { 'Trouble', 'TroubleToggle' },  -- Load when command runs
}
```

**Use for:** Plugins with commands you don't use immediately

### 4. Load on Keymaps

Load when a keymap is pressed:

```lua
return {
	'nvim-telescope/telescope.nvim',
	keys = {
		{ '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
		{ '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
	},
}
```

**Use for:** Plugins bound to specific keymaps

### 5. Load on Filetypes

Load only for specific file types:

```lua
return {
	'fatih/vim-go',
	ft = 'go',  -- Load only for Go files
}

-- Multiple filetypes:
return {
	'author/web-plugin',
	ft = { 'html', 'css', 'javascript', 'typescript' },
}
```

**Use for:** Language-specific plugins

### 6. Manual Loading

Keep installed but don't auto-load:

```lua
return {
	'author/plugin-name',
	lazy = true,  -- Must be manually required
}

-- Later, load it manually:
-- :lua require('plugin-name').setup()
```

## Real-World Examples

### Example 1: Telescope (Load on Keys)

```lua
-- lua/plugins/editor/telescope.lua
return {
	'nvim-telescope/telescope.nvim',
	cmd = 'Telescope',  -- Load on command
	keys = {
		{
			'<leader>sf',
			'<cmd>Telescope find_files<cr>',
			desc = '[S]earch [F]iles',
		},
		{
			'<leader>sg',
			'<cmd>Telescope live_grep<cr>',
			desc = '[S]earch by [G]rep',
		},
	},
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('telescope').setup {}
	end,
}
```

### Example 2: LSP (Load on File Events)

```lua
-- lua/plugins/lsp/init.lua
return {
	'neovim/nvim-lspconfig',
	event = { 'BufReadPre', 'BufNewFile' },  -- Load on file open
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
	},
	config = function()
		-- LSP configuration
	end,
}
```

### Example 3: Git Signs (Load After UI)

```lua
-- lua/plugins/git/gitsigns.lua
return {
	'lewis6991/gitsigns.nvim',
	event = 'VeryLazy',  -- Non-critical, load after UI
	opts = {
		-- Gitsigns configuration
	},
}
```

### Example 4: Language-Specific (Load on Filetype)

```lua
-- lua/plugins/coding/rust-tools.lua
return {
	'simrat39/rust-tools.nvim',
	ft = 'rust',  -- Only load for Rust files
	dependencies = {
		'neovim/nvim-lspconfig',
		'nvim-lua/plenary.nvim',
	},
	config = function()
		require('rust-tools').setup {}
	end,
}
```

## Combining Strategies

You can combine multiple loading triggers:

```lua
return {
	'author/plugin-name',
	event = 'VeryLazy',
	cmd = { 'Command1', 'Command2' },
	ft = { 'lua', 'python' },
	keys = {
		{ '<leader>x', '<cmd>Command1<cr>' },
	},
}
```

Plugin loads on **any** of these triggers (OR condition).

## Performance Monitoring

### Check Startup Time

```sh
# See plugin load times
nvim --startuptime startup.log
cat startup.log
```

### Profile in Neovim

```vim
:Lazy profile
" Shows load times for each plugin
```

### Benchmark Startup

```sh
# Run 10 times and average
hyperfine 'nvim --headless +qa' --warmup 3
```

## Best Practices

### ✅ DO:
- Lazy-load non-essential plugins with `event = 'VeryLazy'`
- Use `ft` for language-specific plugins
- Use `cmd` for plugins with infrequent commands
- Use `keys` for plugins bound to keymaps
- Load LSP and treesitter on file events

### ❌ DON'T:
- Lazy-load colorschemes (needed immediately)
- Over-optimize (some plugins should load early)
- Lazy-load dependencies of early-loading plugins
- Use `VeryLazy` for critical functionality

## Common Patterns

### Colorscheme (Don't Lazy-Load)

```lua
return {
	'folke/tokyonight.nvim',
	lazy = false,    -- Load immediately
	priority = 1000, -- Load before other plugins
	config = function()
		vim.cmd.colorscheme 'tokyonight'
	end,
}
```

### Essential UI (Load Early)

```lua
return {
	'nvim-lualine/lualine.nvim',
	event = 'VimEnter',  -- Load when Neovim starts
}
```

### Optional Tools (Load Late)

```lua
return {
	'folke/which-key.nvim',
	event = 'VeryLazy',  -- Not critical, load after UI
}
```

## Troubleshooting

**Q: Plugin isn't loading when expected**

Check triggers:
```vim
:Lazy load plugin-name
" Manually trigger loading
```

**Q: Keymap doesn't work on first press**

Add `desc` to keys:
```lua
keys = {
	{ '<leader>x', '<cmd>Command<cr>', desc = 'Description' },
	--                                  ^^^^ Required for lazy-loading
},
```

**Q: How to see what's lazy-loaded?**

```vim
:Lazy
" Green = loaded
" Gray = not loaded yet
```

**Q: Startup still slow**

Profile it:
```vim
:Lazy profile
" Identify slow plugins
" Consider lazy-loading or removing them
```

## Example: Full Lazy-Loading Setup

```lua
-- lua/config/lazy.lua
require('lazy').setup({
	{ import = 'plugins.ui' },
	{ import = 'plugins.editor' },
	{ import = 'plugins.lsp' },
	{ import = 'plugins.coding' },
	{ import = 'plugins.git' },
}, {
	-- Lazy.nvim performance settings
	performance = {
		rtp = {
			disabled_plugins = {
				'gzip',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
			},
		},
	},
})
```

[Back to FAQ](../../README.md#faq)
