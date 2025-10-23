# Using Local Lua Plugins

This tutorial explains how to configure your Neovim setup to use local Lua plugins during development or testing, instead of installing them from GitHub.

## Table of Contents
- [When to Use Local Plugins](#when-to-use-local-plugins)
- [Where to Put Plugin Configurations](#where-to-put-plugin-configurations)
- [Basic Configuration](#basic-configuration)
- [Path Specifications](#path-specifications)
- [Development Workflow](#development-workflow)
- [Common Patterns](#common-patterns)
- [Troubleshooting](#troubleshooting)

## When to Use Local Plugins

Use local plugins when you:
- Are developing your own Neovim plugin
- Want to test modifications to an existing plugin
- Need to debug plugin issues
- Want to fork and customize a plugin locally

## Where to Put Plugin Configurations

**IMPORTANT:** All local plugin configurations should go in `lua/custom/plugins/`

### Why `lua/custom/plugins/`?

1. **Git Ignored:** This directory is in `.gitignore`, so your personal local plugin configurations won't be tracked by git
2. **Personal Development:** Perfect for testing and development without polluting the main repository
3. **Auto-loaded:** Lazy.nvim automatically loads all Lua files from this directory

### Directory Structure

```
~/.config/nvim-modular/
├── lua/
│   ├── plugins/          # Main plugin configurations (tracked by git)
│   │   ├── editor/       # Don't put local plugins here!
│   │   ├── ui/
│   │   └── ...
│   └── custom/           # Your personal customizations (NOT tracked by git)
│       └── plugins/      # Put your local plugin configs HERE ✓
│           ├── my-test-plugin.lua
│           └── forked-plugin.lua
```

### Two Separate Locations

It's important to understand there are **two different locations**:

1. **Plugin configuration file** (in `lua/custom/plugins/`)
   - This is a small file that just **points to** your plugin
   - Example: `lua/custom/plugins/my-plugin.lua`
   - **Not tracked by git** (in `.gitignore`)

2. **Actual plugin code** (anywhere on your system)
   - This is where your plugin's actual code lives
   - Example: `~/test/my-plugin/`, `~/dev/projects/my-plugin/`, etc.
   - Can be anywhere you want!

**The configuration file simply points to where the plugin actually is.**

## Basic Configuration

### Example: Testing a Plugin from `~/test/my-plugin`

**Step 1:** Your plugin exists somewhere (e.g., `~/test/my-plugin/`)

```bash
# Plugin structure at ~/test/my-plugin/
~/test/my-plugin/
├── lua/
│   └── my-plugin/
│       ├── init.lua
│       └── config.lua
└── README.md
```

**Step 2:** Create a configuration file that points to it

```lua
-- File: lua/custom/plugins/my-plugin.lua
-- This file just "points to" your plugin's actual location
return {
  dir = '~/test/my-plugin',  -- Where your plugin actually is
  name = 'my-plugin',        -- Plugin name
  lazy = false,              -- Load immediately (or use lazy loading)
  config = function()
    -- Your plugin configuration here
    require('my-plugin').setup({
      -- options
    })
  end,
}
```

**Step 3:** Restart Neovim - your plugin will be loaded!

### Method 1: Tilde Path (Recommended)

```lua
-- File: lua/custom/plugins/example.lua
return {
  dir = '~/test/my-plugin',  -- Tilde expansion works on all platforms
  name = 'my-plugin',
  config = function()
    require('my-plugin').setup()
  end,
}
```

### Method 2: Absolute Path

```lua
-- File: lua/custom/plugins/example.lua
return {
  dir = '/Users/username/test/my-plugin',  -- Full absolute path
  name = 'my-plugin',
  config = function()
    require('my-plugin').setup()
  end,
}
```

### Method 3: Using `vim.fn.expand()`

```lua
-- File: lua/custom/plugins/example.lua
return {
  dir = vim.fn.expand('~/test/my-plugin'),  -- Explicit expansion
  name = 'my-plugin',
  config = function()
    require('my-plugin').setup()
  end,
}
```

## Path Specifications

### Supported Path Formats

| Format | Example | Notes |
|--------|---------|-------|
| Tilde expansion | `~/test/plugin` | Recommended, works on all platforms |
| Absolute path | `/Users/name/test/plugin` | Explicit, but not portable |
| Relative path | `../../test/plugin` | Relative to Neovim config directory |
| Environment variable | `$HOME/test/plugin` | Use with `vim.fn.expand()` |

### Path Resolution

Lazy.nvim resolves paths in this order:
1. If path starts with `/` → treat as absolute
2. If path starts with `~` → expand home directory
3. Otherwise → treat as relative to Neovim config directory

## Development Workflow

### Complete Example: Creating and Using a Local Plugin

**Step 1:** Create your plugin directory

```bash
mkdir -p ~/test/my-awesome-plugin/lua/my-awesome-plugin
```

**Step 2:** Create the plugin structure

```
~/test/my-awesome-plugin/
├── lua/
│   └── my-awesome-plugin/
│       ├── init.lua      # Main plugin file
│       ├── config.lua    # Configuration
│       └── utils.lua     # Utility functions
├── plugin/
│   └── my-awesome-plugin.lua  # Optional: auto-loaded code
└── README.md
```

**Step 3:** Write your plugin code

```lua
-- File: ~/test/my-awesome-plugin/lua/my-awesome-plugin/init.lua
local M = {}

M.setup = function(opts)
  opts = opts or {}
  -- Plugin initialization code
  print("My awesome plugin loaded!")
end

return M
```

**Step 4:** Create configuration file pointing to it

```lua
-- File: lua/custom/plugins/my-awesome-plugin.lua
return {
  dir = '~/test/my-awesome-plugin',  -- Points to plugin location
  name = 'my-awesome-plugin',
  lazy = false,  -- Load immediately during development
  config = function()
    require('my-awesome-plugin').setup({
      -- your options
    })
  end,
}
```

**Step 5:** Restart Neovim to test

```vim
:qa
# Then reopen Neovim
```

### Testing Changes

When developing a local plugin:

1. **Make changes** to your plugin files in `~/test/my-awesome-plugin/`
2. **Reload the plugin:**
   - Quick reload: `:Lazy reload my-awesome-plugin`
   - Full reload: Restart Neovim (`:qa` then reopen)
3. **Check for errors:** `:messages` or `:checkhealth`

### Switching Between Local and Remote

To switch between a local development version and the GitHub version:

**During Development (Local):**
```lua
-- File: lua/custom/plugins/my-plugin.lua
return {
  dir = '~/test/my-plugin',  -- Local version
  name = 'my-plugin',
  config = function()
    require('my-plugin').setup()
  end,
}
```

**After Publishing (GitHub):**

Option 1: Delete the local config file
```bash
rm lua/custom/plugins/my-plugin.lua
```

Option 2: Create a regular plugin config
```lua
-- File: lua/plugins/editor/my-plugin.lua  (or any category)
return {
  'username/my-plugin',  -- GitHub repo
  config = function()
    require('my-plugin').setup()
  end,
}
```

**Tip:** Keep both versions with comments:
```lua
-- File: lua/custom/plugins/my-plugin.lua
return {
  -- GitHub version (uncomment when published):
  -- 'username/my-plugin',

  -- Local development version:
  dir = '~/test/my-plugin',
  name = 'my-plugin',

  config = function()
    require('my-plugin').setup()
  end,
}
```

## Common Patterns

### Pattern 1: Testing Plugin Modifications

You want to test changes to an existing plugin (e.g., forked from GitHub):

```lua
-- File: lua/custom/plugins/telescope.lua
-- Testing modifications to Telescope
return {
  dir = '~/dev/forks/telescope.nvim',  -- Your forked version
  name = 'telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      -- your custom config
    })
  end,
}
```

### Pattern 2: Multiple Local Plugins

Managing several local plugins at once:

```lua
-- File: lua/custom/plugins/all-my-local-plugins.lua
-- One file can return multiple plugin specs
return {
  {
    dir = '~/test/plugin-one',
    name = 'plugin-one',
    config = function()
      require('plugin-one').setup()
    end,
  },
  {
    dir = '~/test/plugin-two',
    name = 'plugin-two',
    config = function()
      require('plugin-two').setup()
    end,
  },
  {
    dir = '~/dev/plugin-three',
    name = 'plugin-three',
    config = function()
      require('plugin-three').setup()
    end,
  },
}
```

### Pattern 3: Conditional Loading

Load local plugin only on your development machine:

```lua
-- File: lua/custom/plugins/conditional.lua
local is_dev_machine = vim.fn.hostname() == 'my-laptop'

if not is_dev_machine then
  return {}  -- Don't load on other machines
end

return {
  dir = '~/test/my-plugin',
  name = 'my-plugin',
  config = function()
    require('my-plugin').setup()
  end,
}
```

### Pattern 4: Environment-Based Configuration

Use environment variables to control local plugin loading:

```lua
-- File: lua/custom/plugins/env-based.lua
-- Set in your shell: export NVIM_USE_LOCAL_PLUGINS=1
local use_local = vim.env.NVIM_USE_LOCAL_PLUGINS == '1'

if not use_local then
  return {}  -- Skip local plugin
end

return {
  dir = vim.fn.expand('~/test/my-plugin'),
  name = 'my-plugin',
  config = function()
    require('my-plugin').setup()
  end,
}
```

## Troubleshooting

### Plugin Not Loading

**Symptom:** Your local plugin doesn't load or shows errors

**Checks:**

1. **Verify the path exists:**
   ```vim
   :lua print(vim.fn.expand('~/test/my-plugin'))
   ```
   Should print the full path. Then check if directory exists:
   ```bash
   ls -la ~/test/my-plugin
   ```

2. **Check Lazy.nvim status:**
   ```vim
   :Lazy
   ```
   Look for your plugin in the list. If missing, check file syntax.

3. **Verify plugin structure:**
   ```bash
   ls -la ~/test/my-plugin/lua/my-plugin/
   ```
   Should contain `init.lua` or named module files.

4. **Check for Lua errors:**
   ```vim
   :messages
   ```

5. **Verify config file location:**
   ```bash
   ls -la ~/.config/nvim-modular/lua/custom/plugins/
   ```
   Your config file should be here.

### Module Not Found Error

**Error:** `module 'my-plugin' not found`

**Cause:** Plugin structure doesn't match `require()` statement

**Solution:** Ensure directory structure matches:
- If using `require('my-plugin')` → need `~/test/my-plugin/lua/my-plugin/init.lua`
- If using `require('my-plugin.config')` → need `~/test/my-plugin/lua/my-plugin/config.lua`

**Example:**
```
# Plugin location: ~/test/my-plugin/
~/test/my-plugin/
└── lua/
    └── my-plugin/        # This directory name matters!
        └── init.lua      # require('my-plugin') loads this
```

### Changes Not Reflecting

**Symptom:** You made changes but they don't appear

**Solutions:**

1. **Reload the plugin:**
   ```vim
   :Lazy reload my-plugin
   ```

2. **Clear Lua module cache:**
   ```vim
   :lua package.loaded['my-plugin'] = nil
   :lua require('my-plugin').setup()
   ```

3. **Restart Neovim (most reliable):**
   ```vim
   :qa
   ```
   Then reopen.

### Path Resolution Issues

**Symptom:** Path not found or wrong directory

**Debug:**
```vim
:lua print(vim.inspect(require('lazy.core.config').plugins['my-plugin']))
```

This shows Lazy.nvim's parsed configuration for your plugin.

**Common mistakes:**
- Using `~` without quotes: `dir = ~/test/plugin` ❌
- Correct: `dir = '~/test/plugin'` ✅
- Trailing slash: `dir = '~/test/plugin/'` (may cause issues, avoid)
- Wrong config location: file not in `lua/custom/plugins/` ❌

### Plugin Dependencies

**Symptom:** Local plugin works but dependencies don't load

**Solution:** Explicitly specify dependencies:
```lua
-- File: lua/custom/plugins/my-plugin.lua
return {
  dir = '~/test/my-plugin',
  name = 'my-plugin',
  dependencies = {
    'nvim-lua/plenary.nvim',  -- Required dependency
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('my-plugin').setup()
  end,
}
```

### Performance Issues

**Symptom:** Neovim starts slowly with local plugin

**Cause:** Plugin loaded too early without lazy loading

**Solution:** Enable lazy loading:
```lua
-- File: lua/custom/plugins/my-plugin.lua
return {
  dir = '~/test/my-plugin',
  name = 'my-plugin',
  lazy = true,  -- Don't load immediately
  event = 'VeryLazy',  -- Load after startup
  -- Or use other lazy loading triggers:
  -- cmd = 'MyPluginCommand',
  -- keys = '<leader>mp',
  -- ft = 'markdown',
  config = function()
    require('my-plugin').setup()
  end,
}
```

### Git Tracking Warning

**Symptom:** Git shows `lua/custom/plugins/my-plugin.lua` as untracked

**Expected Behavior:** This is normal! The `lua/custom/` directory is in `.gitignore`

**Verify:**
```bash
git status
# Should NOT show files in lua/custom/
```

If it does show up:
```bash
# Check .gitignore
cat .gitignore | grep custom
# Should show: lua/custom/
```

## Summary

**Quick Reference:**

| Task | Location | Command |
|------|----------|---------|
| Create config file | `lua/custom/plugins/my-plugin.lua` | Create file with `dir = '~/test/my-plugin'` |
| Plugin actual code | Anywhere (e.g., `~/test/my-plugin/`) | Your plugin development location |
| Reload plugin | N/A | `:Lazy reload my-plugin` |
| Check plugin status | N/A | `:Lazy` |
| View errors | N/A | `:messages` |
| Clear module cache | N/A | `:lua package.loaded['plugin'] = nil` |
| Git tracking | `lua/custom/` is ignored | Won't be committed to git |

**Key Points:**
1. **Config files go in:** `lua/custom/plugins/` (not tracked by git)
2. **Plugin code goes:** Anywhere you want (e.g., `~/test/`, `~/dev/`)
3. **Config file just points to plugin location** using `dir = '~/path/to/plugin'`
4. **No git pollution:** Your personal configs won't be committed
5. **Easy switching:** Delete config file to use GitHub version instead

**Best Practices:**
- Use `lua/custom/plugins/` for all local plugin configs
- Use `~/test/` or `~/dev/` for plugin development
- Keep plugin name in config file matching actual plugin name
- Use `lazy = false` during development for immediate feedback
- Enable lazy loading before publishing
- Test with `:checkhealth` before publishing
- Document plugin structure in README.md

## Related Tutorials
- [Lazy Loading and Plugin Organization](./13-lazy-loading.md)
- [Creating Custom Keymaps](./09-custom-keymaps.md)
- [Plugin Management](./10-plugin-management.md)
