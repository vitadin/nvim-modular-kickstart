# A plugin is causing errors. How do I troubleshoot?

When a plugin causes errors, follow this systematic debugging process.

## Step 1: Identify the Error

### Check Error Messages

```vim
:messages
" Shows all recent error messages
" Use :messages clear to clear them
```

### Check Health

```vim
:checkhealth
" General health check

:checkhealth plugin-name
" Check specific plugin health
```

## Step 2: Verify Plugin Status

```vim
:Lazy
" Opens Lazy.nvim UI
" Look for your plugin:
"   - Green icon = loaded successfully
"   - Red icon = error during load
"   - Gray icon = not loaded yet (lazy-loaded)
```

### Check Plugin Logs

```vim
:Lazy log
" Shows detailed loading logs
" Look for errors or warnings
```

## Step 3: Enable Debug Mode

Add debug mode to see detailed loading information:

```lua
-- lua/config/lazy.lua
require('lazy').setup({
	{ import = 'plugins.ui' },
	{ import = 'plugins.editor' },
	-- ... your imports
}, {
	debug = true,  -- Enable debug logging
})
```

Restart Neovim and check `:Lazy log` again.

## Step 4: Isolate the Problem

### Disable the Plugin

```lua
-- In the plugin's file
return {
	'author/problem-plugin',
	enabled = false,  -- Temporarily disable
	-- ... rest of config
}
```

Restart Neovim. If errors disappear, the plugin is the cause.

### Check Dependencies

```vim
:Lazy
" Find the plugin
" Check its dependencies
" Make sure all dependencies are installed
```

Common missing dependencies:
- `nvim-lua/plenary.nvim` - Required by many plugins
- `nvim-tree/nvim-web-devicons` - For icons
- `nvim-treesitter` - For syntax features

## Step 5: Verify Configuration

### Check for Typos

```sh
# Lint your config
cd ~/.config/nvim
make lint
```

### Validate Lua Syntax

```sh
# Check syntax errors
make test
```

### Common Configuration Errors

**Missing setup call:**
```lua
-- ❌ Wrong
return {
	'author/plugin',
	config = function()
		-- No setup call
	end,
}

-- ✅ Correct
return {
	'author/plugin',
	config = function()
		require('plugin').setup()
	end,
}
```

**Wrong module name:**
```lua
-- Check plugin docs for correct require name
-- Not always the same as the repo name!
require('plugin-name')      -- ❌ Might be wrong
require('plugin_name')      -- ✅ Check plugin docs
```

## Step 6: Reinstall the Plugin

```vim
:Lazy clean
" Removes plugin from disk

:Lazy install
" Reinstalls all plugins

" Or reinstall specific plugin:
:Lazy clean plugin-name
:Lazy install plugin-name
```

## Step 7: Check Plugin Compatibility

### Verify Neovim Version

```vim
:version
" or
:lua print(vim.version())
```

Check plugin requirements in its GitHub README:
- Some plugins require Neovim 0.10+
- Some require nightly builds

### Check for Conflicting Plugins

Some plugins conflict with each other:
- Multiple colorschemes setting colors
- Multiple completion plugins
- Multiple statusline plugins

## Common Plugin Issues

### Issue: "Module not found"

**Error:** `module 'plugin-name' not found`

**Fix:**
1. Check if plugin is installed: `:Lazy`
2. Verify correct module name in plugin docs
3. Install dependencies: `:Lazy install`

### Issue: Plugin Not Loading

**Symptoms:** Plugin seems installed but doesn't work

**Fix:**
```lua
-- Check lazy-loading settings
return {
	'author/plugin',
	-- Maybe it's lazy-loaded?
	-- Try disabling lazy-loading temporarily:
	lazy = false,  -- Force load at startup
}
```

### Issue: Keymaps Not Working

**Symptoms:** Plugin keymaps don't respond

**Fix:**
```vim
" Check if keymap exists
:map <leader>x

" Check if plugin loaded
:Lazy

" Manually load if needed
:Lazy load plugin-name
```

### Issue: LSP Not Starting

**Symptoms:** No LSP features (autocomplete, diagnostics)

**Check:**
```vim
:LspInfo
" Shows active LSP clients

:Mason
" Check if language server is installed

:checkhealth lsp
" Diagnose LSP issues
```

**Fix:**
1. Install language server: `:Mason` → search → press `i` to install
2. Check server configuration in `lua/plugins/lsp/servers.lua`
3. Restart Neovim

### Issue: Telescope Not Finding Files

**Symptoms:** Telescope opens but shows no files

**Fix:**
```sh
# Check if ripgrep is installed
which rg

# Install if missing
# Mac:
brew install ripgrep
# Linux:
sudo apt install ripgrep
```

### Issue: Icons Not Showing

**Symptoms:** Seeing squares or broken characters

**Fix:**
1. Install a [Nerd Font](https://www.nerdfonts.com/)
2. Set terminal to use the Nerd Font
3. Enable in config:
```lua
-- init.lua
vim.g.have_nerd_font = true
```

## Advanced Debugging

### Enable Verbose Logging

```vim
:set verbose=9
:Lazy load plugin-name
" See detailed logs

:set verbose=0
" Disable verbose mode
```

### Start Neovim in Minimal Mode

Create a minimal test config:

```lua
-- /tmp/minimal.lua
vim.cmd [[set runtimepath=$VIMRUNTIME]]
vim.cmd [[set packpath=/tmp/nvim/site]]

local package_root = '/tmp/nvim/site/pack'
local install_path = package_root .. '/packer/start/packer.nvim'

-- Install lazy.nvim
local lazypath = install_path
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- Test single problem plugin
require('lazy').setup {
	{ 'author/problem-plugin' },
}
```

Run with:
```sh
nvim -u /tmp/minimal.lua
```

### Check GitHub Issues

1. Visit plugin's GitHub page
2. Check Issues tab
3. Search for your error message
4. Check if it's a known bug

### Ask for Help

If still stuck, create a minimal reproduction:

```vim
:Lazy log > /tmp/lazy.log
:messages > /tmp/messages.log
```

Share:
- Error messages
- Your plugin configuration
- Neovim version (`:version`)
- OS and terminal info

## Prevention

### Keep Plugins Updated

```vim
:Lazy update
" Regular updates often fix bugs
```

### Pin Critical Plugins

```lua
return {
	'critical/plugin',
	version = '*',  -- Use latest stable
	-- or pin to specific version:
	tag = 'v1.2.3',
}
```

### Regular Health Checks

```vim
:checkhealth
" Run periodically to catch issues early
```

### Version Control Your Config

```sh
cd ~/.config/nvim
git add .
git commit -m "Working configuration"
# If issues arise, you can revert
```

## Quick Reference: Debugging Commands

| Command | Purpose |
|---------|---------|
| `:messages` | Show error messages |
| `:Lazy` | Show plugin status |
| `:Lazy log` | Show detailed logs |
| `:Lazy clean` | Remove plugin |
| `:Lazy install` | Reinstall plugins |
| `:checkhealth` | System health check |
| `:LspInfo` | LSP status |
| `:Mason` | Manage LSP servers |
| `:Telescope diagnostics` | View all diagnostics |
| `:set verbose=9` | Enable verbose logging |

[Back to FAQ](../../README.md#faq)
