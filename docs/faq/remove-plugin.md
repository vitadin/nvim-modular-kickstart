# How do I remove an existing plugin?

There are several ways to remove a plugin depending on how you want to
remove it.

## Method 1: Delete the Plugin File

The simplest method - just delete the file:

```sh
# Example: Remove telescope
rm lua/plugins/editor/telescope.lua

# Restart Neovim and clean up
nvim
# Then in Neovim:
:Lazy clean
```

This permanently removes the plugin from your configuration.

## Method 2: Comment Out the Return Statement

If you might want to re-enable the plugin later:

```lua
-- lua/plugins/editor/telescope.lua

-- Commented out to disable
--[[
return {
	'nvim-telescope/telescope.nvim',
	event = 'VimEnter',
	-- ... rest of config
}
--]]
```

Then run `:Lazy clean` in Neovim to remove the plugin from disk.

## Method 3: Disable Without Removing

Keep the plugin file but disable it (useful for testing):

```lua
-- lua/plugins/editor/telescope.lua
return {
	'nvim-telescope/telescope.nvim',
	enabled = false,  -- Temporarily disable
	event = 'VimEnter',
	-- ... rest of config
}
```

The plugin stays installed but won't load. Re-enable by removing
`enabled = false`.

## Removing an Entire Plugin Category

To disable all plugins in a category, edit `lua/config/lazy.lua`:

```lua
-- Before
require('lazy').setup({
	{ import = 'plugins.ui' },
	{ import = 'plugins.editor' },  -- Remove this line
	{ import = 'plugins.lsp' },
	{ import = 'plugins.coding' },
	{ import = 'plugins.git' },
}, { ... })

-- After - all editor plugins are now disabled
require('lazy').setup({
	{ import = 'plugins.ui' },
	-- { import = 'plugins.editor' },  -- Commented out
	{ import = 'plugins.lsp' },
	{ import = 'plugins.coding' },
	{ import = 'plugins.git' },
}, { ... })
```

## Removing Plugin Dependencies

When removing a plugin, check if other plugins depend on it:

```sh
# Search for references to the plugin
cd ~/.config/nvim
grep -r "plugin-name" lua/
```

For example, if removing `nvim-web-devicons`, check if other plugins
list it as a dependency.

## Cleaning Up After Removal

After removing plugin files:

1. **Restart Neovim**
2. **Clean plugin data:**
   ```vim
   :Lazy clean
   ```
3. **Check for errors:**
   ```vim
   :messages
   :checkhealth
   ```

## Removing Plugin Keymaps

If the plugin added keymaps, you may need to remove them from:
- `lua/config/keymaps.lua` - Global keymaps
- The plugin's own file - Plugin-specific keymaps

## Removing Plugin Configuration

Some plugins create persistent data:

```sh
# Remove plugin data directories (optional)
rm -rf ~/.local/share/nvim/plugin-name
rm -rf ~/.cache/nvim/plugin-name

# Check for config files
ls ~/.local/share/nvim/
ls ~/.cache/nvim/
```

## Example: Removing Telescope

Complete example of removing telescope.nvim:

1. **Delete the plugin file:**
   ```sh
   rm lua/plugins/editor/telescope.lua
   ```

2. **Remove LSP keymaps that use telescope:**
   Edit `lua/plugins/lsp/keymaps.lua` and replace telescope keymaps:
   ```lua
   -- Before
   map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

   -- After (use built-in vim LSP)
   map('grr', vim.lsp.buf.references, '[G]oto [R]eferences')
   ```

3. **Clean up:**
   ```vim
   :Lazy clean
   :messages  " Check for errors
   ```

## Troubleshooting

**Q: I removed a plugin but still see errors about it**

A: The plugin data may still exist. Try:
```vim
:Lazy clean
" Then restart Neovim completely
```

**Q: Can I remove plugins that other plugins depend on?**

A: Yes, but the dependent plugins may break. Check dependencies first:
```vim
:Lazy
" Find the plugin, check what depends on it
```

**Q: How do I remove all plugins and start fresh?**

A: Delete the plugin data directory:
```sh
rm -rf ~/.local/share/nvim/lazy
# Then restart Neovim - plugins will reinstall
```

[Back to FAQ](../../README.md#faq)
