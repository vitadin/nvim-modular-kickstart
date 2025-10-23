# Using Local Lua Plugins

This tutorial explains how to configure your Neovim setup to use local Lua plugins during development or testing, instead of installing them from GitHub.

## Table of Contents
- [When to Use Local Plugins](#when-to-use-local-plugins)
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

## Basic Configuration

### Method 1: Using the `dir` Parameter

The simplest way to use a local plugin is with Lazy.nvim's `dir` parameter:

```lua
-- In lua/plugins/your-category/your-plugin.lua
return {
  dir = '~/test/my-plugin',  -- Path to your local plugin
  name = 'my-plugin',        -- Optional: specify plugin name
  lazy = false,              -- Load immediately (or use lazy loading)
  config = function()
    -- Your plugin configuration here
    require('my-plugin').setup({
      -- options
    })
  end,
}
```

### Method 2: Absolute Path

You can use an absolute path for clarity:

```lua
return {
  dir = '/Users/username/test/my-plugin',
  name = 'my-plugin',
  config = function()
    require('my-plugin').setup()
  end,
}
```

### Method 3: Using `vim.fn.expand()`

For more flexibility with home directory expansion:

```lua
return {
  dir = vim.fn.expand('~/test/my-plugin'),
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

### Setting Up a Local Plugin for Development

1. **Create your plugin directory:**
   ```bash
   mkdir -p ~/test/my-awesome-plugin/lua/my-awesome-plugin
   ```

2. **Create the plugin structure:**
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

3. **Write your plugin code** (`~/test/my-awesome-plugin/lua/my-awesome-plugin/init.lua`):
   ```lua
   local M = {}

   M.setup = function(opts)
     opts = opts or {}
     -- Plugin initialization code
     print("My awesome plugin loaded!")
   end

   return M
   ```

4. **Configure in your Neovim setup** (`lua/plugins/testing/my-awesome-plugin.lua`):
   ```lua
   return {
     dir = '~/test/my-awesome-plugin',
     name = 'my-awesome-plugin',
     lazy = false,  -- Load immediately during development
     config = function()
       require('my-awesome-plugin').setup({
         -- your options
       })
     end,
   }
   ```

5. **Reload Neovim** to test changes:
   - Restart Neovim: `:qa` then reopen
   - Or use `:Lazy reload my-awesome-plugin` (if plugin supports hot reload)

### Testing Changes

When developing a local plugin:

1. **Make changes** to your plugin files in `~/test/my-awesome-plugin/`
2. **Reload the plugin:**
   - Quick reload: `:Lazy reload my-awesome-plugin`
   - Full reload: Restart Neovim
3. **Check for errors:** `:messages` or `:checkhealth`

### Switching Between Local and Remote

To switch between a local development version and the GitHub version:

**During Development (Local):**
```lua
return {
  dir = '~/test/my-awesome-plugin',
  name = 'my-awesome-plugin',
  config = function()
    require('my-awesome-plugin').setup()
  end,
}
```

**After Publishing (GitHub):**
```lua
return {
  'username/my-awesome-plugin',  -- GitHub repo
  config = function()
    require('my-awesome-plugin').setup()
  end,
}
```

**Tip:** Use a comment to track both versions:
```lua
return {
  -- 'username/my-awesome-plugin',  -- Production version (GitHub)
  dir = '~/test/my-awesome-plugin',  -- Development version (local)
  name = 'my-awesome-plugin',
  config = function()
    require('my-awesome-plugin').setup()
  end,
}
```

## Common Patterns

### Pattern 1: Testing Plugin Modifications

You want to test changes to an existing plugin:

```lua
-- Original plugin from GitHub
-- return { 'nvim-telescope/telescope.nvim' }

-- Modified local version
return {
  dir = '~/test/telescope.nvim',  -- Your fork
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

Managing several local plugins:

```lua
-- lua/plugins/local/init.lua
local local_plugins = {
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
}

return local_plugins
```

### Pattern 3: Conditional Loading

Load local plugin only in specific circumstances:

```lua
-- Load local version only on development machine
local is_dev_machine = vim.fn.hostname() == 'dev-laptop'

return {
  is_dev_machine and '~/test/my-plugin' or 'username/my-plugin',
  dir = is_dev_machine and '~/test/my-plugin' or nil,
  name = 'my-plugin',
  config = function()
    require('my-plugin').setup()
  end,
}
```

### Pattern 4: Environment-Based Configuration

Use environment variables to switch between local and remote:

```lua
-- Set in your shell: export NVIM_LOCAL_PLUGINS=1
local use_local = vim.env.NVIM_LOCAL_PLUGINS == '1'

return {
  use_local and vim.fn.expand('~/test/my-plugin') or 'username/my-plugin',
  dir = use_local and vim.fn.expand('~/test/my-plugin') or nil,
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
   Should print the full path. Then check if directory exists.

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

### Module Not Found Error

**Error:** `module 'my-plugin' not found`

**Cause:** Plugin structure doesn't match `require()` statement

**Solution:** Ensure directory structure matches:
- If using `require('my-plugin')` → need `~/test/my-plugin/lua/my-plugin/init.lua`
- If using `require('my-plugin.config')` → need `~/test/my-plugin/lua/my-plugin/config.lua`

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

3. **Restart Neovim:**
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
- Using `~` without quotes: `dir = ~/test/plugin` (WRONG)
- Correct: `dir = '~/test/plugin'` (RIGHT)
- Trailing slash: `dir = '~/test/plugin/'` (may cause issues, avoid)

### Plugin Dependencies

**Symptom:** Local plugin works but dependencies don't load

**Solution:** Explicitly specify dependencies:
```lua
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

## Summary

**Quick Reference:**

| Task | Command |
|------|---------|
| Add local plugin | Create file in `lua/plugins/` with `dir = '~/test/plugin'` |
| Reload plugin | `:Lazy reload plugin-name` |
| Check plugin status | `:Lazy` |
| View errors | `:messages` |
| Clear module cache | `:lua package.loaded['plugin'] = nil` |
| Switch to GitHub version | Replace `dir` with GitHub URL string |

**Best Practices:**
- Use `~/test/` directory for local plugin development
- Keep original GitHub URL in comments for easy switching
- Use `lazy = false` during development for immediate feedback
- Enable lazy loading before publishing
- Test plugin with `:checkhealth` before publishing
- Document plugin structure in README.md

## Related Tutorials
- [Lazy Loading and Plugin Organization](./13-lazy-loading.md)
- [Creating Custom Keymaps](./05-custom-keymaps.md)
