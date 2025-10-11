# How do I load a local plugin from my filesystem?

Loading a local plugin is useful when developing your own plugin or testing
modifications to an existing plugin.

## Basic Local Plugin

Use the `dir` option to specify a local directory:

```lua
-- lua/plugins/editor/my-local-plugin.lua
return {
	dir = '~/projects/my-plugin',  -- Absolute path to local directory
	name = 'my-plugin',             -- Give it a name
	config = function()
		require('my-plugin').setup {}
	end,
}
```

## Local Plugin Directory Structure

Your local plugin should follow standard Neovim plugin structure:

```
~/projects/my-plugin/
├── plugin/
│   └── my-plugin.lua           # Auto-loaded on startup
├── lua/
│   └── my-plugin/
│       ├── init.lua            # Main module
│       ├── config.lua          # Configuration
│       └── utils.lua           # Utilities
├── doc/
│   └── my-plugin.txt           # Help documentation
└── README.md
```

## Minimal Working Example

Let's create a simple local plugin:

### Step 1: Create the Plugin Structure

```sh
mkdir -p ~/projects/hello-plugin/lua/hello-plugin
mkdir -p ~/projects/hello-plugin/plugin
```

### Step 2: Create the Main Module

```lua
-- ~/projects/hello-plugin/lua/hello-plugin/init.lua
local M = {}

M.config = {
	message = 'Hello from local plugin!',
}

function M.setup(opts)
	M.config = vim.tbl_extend('force', M.config, opts or {})
end

function M.greet()
	print(M.config.message)
end

return M
```

### Step 3: Create Auto-load File (optional)

```lua
-- ~/projects/hello-plugin/plugin/hello-plugin.lua
vim.api.nvim_create_user_command('HelloPlugin', function()
	require('hello-plugin').greet()
end, { desc = 'Greet from hello plugin' })
```

### Step 4: Load in Neovim Config

```lua
-- lua/plugins/editor/hello-plugin.lua
return {
	dir = '~/projects/hello-plugin',
	name = 'hello-plugin',
	config = function()
		require('hello-plugin').setup {
			message = 'Hello from my customized plugin!',
		}
	end,
}
```

### Step 5: Test It

Restart Neovim and run:
```vim
:HelloPlugin
" Should print: Hello from my customized plugin!
```

## Developing with Hot Reload

For faster development, you can reload your local plugin without restarting:

```vim
" Clear the module cache
:lua package.loaded['my-plugin'] = nil

" Reload the plugin
:lua require('my-plugin').setup()

" Test your changes
:YourPluginCommand
```

Or create a quick reload keymap:

```lua
-- lua/config/keymaps.lua
vim.keymap.set('n', '<leader>r', function()
	-- Clear module cache
	for key, _ in pairs(package.loaded) do
		if key:match('^my%-plugin') then
			package.loaded[key] = nil
		end
	end
	-- Reload
	require('my-plugin').setup()
	print('Plugin reloaded!')
end, { desc = 'Reload local plugin' })
```

## Loading Multiple Local Plugins

```lua
-- lua/plugins/editor/local-plugins.lua
return {
	-- First local plugin
	{
		dir = '~/projects/plugin-one',
		name = 'plugin-one',
		config = function()
			require('plugin-one').setup()
		end,
	},

	-- Second local plugin
	{
		dir = '~/projects/plugin-two',
		name = 'plugin-two',
		config = function()
			require('plugin-two').setup()
		end,
	},
}
```

## Local Plugin with Dependencies

Your local plugin can depend on other plugins:

```lua
return {
	dir = '~/projects/my-plugin',
	name = 'my-plugin',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim',
	},
	config = function()
		require('my-plugin').setup {}
	end,
}
```

## Overriding an Existing Plugin

To use a local fork of an existing plugin:

```lua
-- Instead of this:
-- return {
--   'author/original-plugin',
-- }

-- Use this:
return {
	dir = '~/projects/my-fork-of-plugin',
	name = 'original-plugin',  -- Use the original name
	config = function()
		require('original-plugin').setup {
			-- Your custom config
		}
	end,
}
```

## Using Relative Paths

You can use relative paths (relative to your Neovim config):

```lua
return {
	dir = vim.fn.stdpath('config') .. '/local-plugins/my-plugin',
	name = 'my-plugin',
	config = function()
		require('my-plugin').setup()
	end,
}
```

Directory structure:
```
~/.config/nvim/
├── init.lua
├── lua/
│   └── plugins/
│       └── editor/
│           └── local-plugin.lua
└── local-plugins/
    └── my-plugin/
        └── lua/
            └── my-plugin/
                └── init.lua
```

## Debugging Local Plugins

Enable debug mode to see loading issues:

```lua
-- lua/config/lazy.lua
require('lazy').setup({
	-- ... your plugins
}, {
	debug = true,  -- Enable debug logging
})
```

Check logs:
```vim
:Lazy log
:messages
```

## Common Issues

**Q: My local plugin isn't loading**

Check:
1. Path is correct: `:lua print(vim.fn.expand('~/projects/my-plugin'))`
2. Directory structure follows Neovim conventions
3. Module name matches: `require('my-plugin')` needs `lua/my-plugin/init.lua`

**Q: Changes to my local plugin aren't reflected**

A: Neovim caches modules. Either:
- Restart Neovim, or
- Clear the cache: `:lua package.loaded['my-plugin'] = nil`

**Q: Can I publish my local plugin later?**

A: Yes! Once it's working locally:
1. Push to GitHub: `username/my-plugin`
2. Change the config from `dir` to the GitHub URL:
```lua
-- From
return { dir = '~/projects/my-plugin' }

-- To
return { 'username/my-plugin' }
```

[Back to FAQ](../../README.md#faq)
