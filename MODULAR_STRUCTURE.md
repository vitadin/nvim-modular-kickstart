# Kickstart.nvim - Modular Structure

This is a modular restructuring of the popular [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) configuration. All functionality from the original has been preserved while improving organization and maintainability.

## Features

- Minimal `init.lua` entry point (~40 lines)
- Well-organized structure with clear separation of concerns
- Easy to customize individual components
- Industry-standard Neovim configuration layout
- Isolated from your system Neovim configuration
- Professional Lua tooling (formatting, linting, testing)

## Directory Structure

```
kickstart.nvim/
├── init.lua                          # Minimal entry point
├── init.lua.backup                   # Original kickstart init.lua
├── Makefile                          # Code quality automation
├── .stylua.toml                      # Stylua formatter config
├── .luacheckrc                       # Luacheck linter config
├── .luarc.json                       # Lua LSP config
├── lua/
│   ├── config/
│   │   ├── init.lua                 # Config module loader
│   │   ├── options.lua              # Vim options
│   │   ├── keymaps.lua              # Keybindings
│   │   ├── autocmds.lua             # Autocommands
│   │   └── lazy.lua                 # Plugin manager setup
│   ├── plugins/
│   │   ├── ui/
│   │   │   ├── colorscheme.lua     # Color scheme
│   │   │   ├── statusline.lua      # Status line
│   │   │   └── which-key.lua       # Key hints
│   │   ├── editor/
│   │   │   ├── telescope.lua       # Fuzzy finder
│   │   │   ├── treesitter.lua      # Syntax highlighting
│   │   │   ├── mini.lua            # Text objects & surroundings
│   │   │   ├── todo-comments.lua   # TODO highlighting
│   │   │   └── guess-indent.lua    # Auto-detect indentation
│   │   ├── lsp/
│   │   │   ├── init.lua            # LSP setup
│   │   │   ├── servers.lua         # Language server configs
│   │   │   ├── keymaps.lua         # LSP keybindings
│   │   │   └── lazydev.lua         # Lua LSP for Neovim
│   │   ├── coding/
│   │   │   ├── completion.lua      # Autocompletion (blink.cmp)
│   │   │   └── formatting.lua      # Code formatting (conform.nvim)
│   │   └── git/
│   │       └── gitsigns.lua        # Git decorations
│   ├── kickstart/                   # Optional kickstart plugins
│   └── custom/                      # Your custom plugins
└── MODULAR_STRUCTURE.md             # This file
```

## How to Use Without Polluting Your System Neovim

### Option 1: Using NVIM_APPNAME (Recommended)

The `NVIM_APPNAME` environment variable allows you to run a completely isolated Neovim configuration:

```bash
# One-time launch
NVIM_APPNAME=kickstart nvim

# Or create an alias in your shell config (~/.zshrc, ~/.bashrc, etc.)
alias nvim-kickstart='NVIM_APPNAME=kickstart nvim'

# Then use it
nvim-kickstart myfile.lua
```

When using `NVIM_APPNAME=kickstart`, Neovim will use these directories:
- Config: `~/.config/kickstart/` (instead of `~/.config/nvim/`)
- Data: `~/.local/share/kickstart/` (instead of `~/.local/share/nvim/`)
- State: `~/.local/state/kickstart/` (instead of `~/.local/state/nvim/`)
- Cache: `~/.cache/kickstart/` (instead of `~/.cache/nvim/`)

#### Setup Steps:

1. **Clone this repo to the kickstart config directory:**
   ```bash
   # First, backup if you already have a kickstart config
   mv ~/.config/kickstart ~/.config/kickstart.backup 2>/dev/null || true

   # Clone or copy your kickstart configuration
   cp -r /Users/sunyaojin/test/nvim_setup/kickstart.nvim ~/.config/kickstart
   ```

2. **Create a convenient alias** (add to `~/.zshrc` or `~/.bashrc`):
   ```bash
   alias nvim-kickstart='NVIM_APPNAME=kickstart nvim'
   ```

3. **Launch and install plugins:**
   ```bash
   nvim-kickstart
   # Plugins will automatically install on first launch
   ```

### Option 2: Temporary XDG Override

For one-off testing:

```bash
XDG_CONFIG_HOME=/tmp/test-config \
XDG_DATA_HOME=/tmp/test-data \
XDG_STATE_HOME=/tmp/test-state \
XDG_CACHE_HOME=/tmp/test-cache \
nvim
```

### Option 3: Replace Your Current Config

If you want to make this your primary configuration:

```bash
# Backup your current config
mv ~/.config/nvim ~/.config/nvim.backup

# Copy this config
cp -r /Users/sunyaojin/test/nvim_setup/kickstart.nvim ~/.config/nvim

# Launch nvim normally
nvim
```

## Customization

### Adding a New Plugin

Create a new file in the appropriate category under `lua/plugins/`:

```lua
-- lua/plugins/editor/my-plugin.lua
return {
  'author/plugin-name',
  opts = {
    -- plugin configuration
  },
}
```

### Modifying Options

Edit `lua/config/options.lua`:

```lua
-- Enable relative line numbers
vim.o.relativenumber = true
```

### Adding Keymaps

Edit `lua/config/keymaps.lua`:

```lua
vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = '[W]rite file' })
```

### Configuring LSP Servers

Edit `lua/plugins/lsp/servers.lua`:

```lua
return {
  lua_ls = { ... },
  -- Add your language servers here
  pyright = {},
  gopls = {},
  ts_ls = {},
}
```

## Development & Code Quality

This configuration follows professional Lua development practices with integrated tooling.

### Quick Start

```bash
# Check everything (format + lint)
make check

# Format all Lua files
make format

# Lint all Lua files
make lint

# Test configuration loads
make test

# See all available targets
make help
```

### Required Tools

Install these tools for full development support:

**1. StyLua** (Code Formatter)
```bash
# With Cargo
cargo install stylua

# With Homebrew
brew install stylua
```

**2. Luacheck** (Code Linter)
```bash
# With LuaRocks
luarocks install luacheck

# With Homebrew
brew install luacheck
```

Check installation status:
```bash
make verify-tools
```

### Configuration Files

- **`.stylua.toml`**: Format rules (2 spaces, single quotes, 160 char width)
- **`.luacheckrc`**: Linting rules (Neovim globals, complexity limits)
- **`.luarc.json`**: Lua LSP configuration (for better IDE support)

### Makefile Targets

| Target | Description |
|--------|-------------|
| `make check` | Run format + lint checks (recommended before commits) |
| `make format` | Check if files are formatted correctly |
| `make format-fix` | Format all Lua files |
| `make lint` | Run luacheck on all Lua files |
| `make test` | Verify Neovim can load the configuration |
| `make test-health` | Run Neovim health checks |
| `make clean` | Remove backup files and caches |
| `make pre-commit` | Run all checks (use as git pre-commit hook) |
| `make verify-tools` | Check if all required tools are installed |
| `make install-tools` | Show installation instructions |

### Pre-commit Hook (Optional)

Add this to `.git/hooks/pre-commit` to enforce quality:

```bash
#!/bin/sh
# Pre-commit hook for code quality
cd "$(git rev-parse --show-toplevel)"
make pre-commit
```

Make it executable:
```bash
chmod +x .git/hooks/pre-commit
```

### IDE Integration

The `.luarc.json` file configures Lua LSP (lua_ls) for optimal IDE support:
- Neovim API awareness (`vim` global)
- Proper module resolution
- LuaJIT compatibility
- Format-on-save support

## Benefits Over Monolithic init.lua

1. **Easy to Navigate**: Find settings quickly - know exactly where each configuration lives
2. **Modular**: Enable/disable entire feature groups by renaming folders
3. **Maintainable**: Changes are localized - modify one plugin without affecting others
4. **Scalable**: Add new plugins without cluttering a single file
5. **Collaborative**: Team members can work on different modules without conflicts
6. **Best Practices**: Follows community-standard Neovim configuration patterns
7. **Code Quality**: Automated formatting, linting, and testing ensure consistency

## Restoration

If you need to revert to the original kickstart:

```bash
# The original init.lua is backed up
mv init.lua init.lua.modular
mv init.lua.backup init.lua

# Remove the modular structure
rm -rf lua/config lua/plugins
```

## Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Kickstart.nvim Original](https://github.com/nvim-lua/kickstart.nvim)
- [Lazy.nvim Plugin Manager](https://github.com/folke/lazy.nvim)
- [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html)

## Troubleshooting

### Plugins Not Loading

```bash
# Check for syntax errors
nvim --headless -c "luafile ~/.config/kickstart/init.lua" -c "quit"

# View lazy.nvim status
:Lazy
```

### LSP Not Working

```bash
# Check health
:checkhealth

# Check Mason status
:Mason
```

### Keymaps Not Working

```bash
# Search for conflicting keymaps
:Telescope keymaps
```

---

Enjoy your modular Neovim configuration!
