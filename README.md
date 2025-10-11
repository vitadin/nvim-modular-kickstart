# Modular Neovim Configuration

A well-structured, modular Neovim configuration adapted from the excellent
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) project.

## Table of Contents

- [Philosophy](#philosophy)
- [Key Features](#key-features)
- [Requirements](#requirements)
- [Try Before You Commit](#try-before-you-commit)
- [Installation](#installation)
- [Customization](#customization)
- [Key Mappings](#key-mappings)
- [FAQ](#faq)
  - [General Questions](#general-questions)
  - [Plugin Management](#plugin-management)
- [Credits](#credits)
- [License](#license)

## Philosophy

This configuration takes kickstart.nvim's foundation and restructures it with:

* **Modular Architecture** - Clean separation of concerns with organized
  directories
* **Professional Tooling** - Built-in formatting, linting, and testing via
  Makefile
* **Code Quality** - Consistent style with tabs (4-space width), 80-character
  lines
* **Industrial Best Practices** - Easy to maintain, extend, and customize

Unlike the original single-file approach, this configuration splits
functionality into logical modules, making it ideal for those who want a
solid foundation that's easy to customize and maintain.

## Key Features

### Core Functionality
- **LSP Integration** - Built-in language server support with Mason installer
- **Fuzzy Finding** - Telescope for files, grep, diagnostics, and more
- **Syntax Highlighting** - Tree-sitter for superior code highlighting
- **Git Integration** - Gitsigns for inline git decorations and operations
- **Auto-completion** - Blink.cmp with snippet support
- **Auto-formatting** - Conform.nvim with format-on-save

### Development Tooling
- **Makefile** - Professional build automation with targets:
  - `make check` - Run formatting and linting checks
  - `make format-fix` - Auto-format all Lua files
  - `make lint` - Lint with luacheck
  - `make test` - Validate Lua syntax
  - `make pre-commit` - Full pre-commit validation

### Code Organization
```
kickstart.nvim/
├── init.lua                    # Minimal entry point (40 lines)
├── lua/
│   ├── config/                 # Core configuration
│   │   ├── options.lua         # Vim settings
│   │   ├── keymaps.lua         # Key bindings
│   │   ├── autocmds.lua        # Autocommands
│   │   └── lazy.lua            # Plugin manager setup
│   └── plugins/                # Plugin specifications
│       ├── ui/                 # UI enhancements (colorscheme, statusline)
│       ├── editor/             # Editor features (telescope, treesitter)
│       ├── lsp/                # LSP configuration
│       ├── coding/             # Coding tools (completion, formatting)
│       └── git/                # Git integration
├── Makefile                    # Build automation
├── .stylua.toml                # Code formatter config
├── .luacheckrc                 # Linter config
└── .luarc.json                 # Lua LSP config
```

## Requirements

### Neovim
Requires Neovim 0.10+ (stable or nightly). Check your version:
```sh
nvim --version
```

### System Dependencies
- **Basic tools**: `git`, `make`, `unzip`, C compiler (`gcc` or `clang`)
- **ripgrep**: For telescope grep functionality
- **fd-find** (optional): Faster file finding
- **Clipboard tool**: `pbcopy` (Mac), `xclip`/`xsel` (Linux)
- **Nerd Font** (optional): For icons (set `vim.g.have_nerd_font = true` in
  `init.lua`)

### Development Tools (for code quality)
- **stylua**: Lua code formatter
- **luacheck**: Lua linter

Install development tools:
```sh
# Mac
brew install stylua luacheck

# Linux (Ubuntu/Debian)
cargo install stylua
sudo apt install luarocks && luarocks install luacheck

# Or use Mason (built into this config)
# After starting nvim, run: :Mason
# Then install stylua and luacheck from the Mason UI
```

## Try Before You Commit

**The safest way to test this configuration without touching your existing
Neovim setup:**

### Step 1: Clone to a separate directory
```sh
# Clone to ~/.config/nvim-modular (or any name you like)
git clone <your-fork-url> "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim-modular
```

### Step 2: Test with NVIM_APPNAME
```sh
# Run Neovim with the test configuration
NVIM_APPNAME=nvim-modular nvim
```

This creates an isolated environment:
- Config: `~/.config/nvim-modular/`
- Data: `~/.local/share/nvim-modular/`
- Cache: `~/.cache/nvim-modular/`

Your original `~/.config/nvim` remains untouched!

### Step 3: Create an alias (optional)
Add to your `~/.bashrc`, `~/.zshrc`, or `~/.config/fish/config.fish`:

```sh
# Bash/Zsh
alias nv='NVIM_APPNAME=nvim-modular nvim'

# Fish
alias nv='env NVIM_APPNAME=nvim-modular nvim'
```

Now you can use `nv` for the modular config and `nvim` for your original.

### Step 4: First Launch
On first launch, lazy.nvim will automatically install all plugins. This may
take a minute. You can check progress with `:Lazy`.

### Step 5: Adopt Permanently (when ready)
If you like it and want to make it your default:

```sh
# Backup your old config
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup

# Move the modular config to default location
mv ~/.config/nvim-modular ~/.config/nvim
rm -rf ~/.local/share/nvim-modular  # Clean slate for plugins

# Start nvim normally
nvim
```

## Installation

### Quick Install (Mac/Linux)

1. **Backup existing configuration** (if any):
```sh
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. **Clone this repository**:
```sh
git clone <your-fork-url> "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

3. **Start Neovim**:
```sh
nvim
```

Lazy.nvim will automatically install all plugins on first launch.

### Install Recipes

<details><summary>macOS</summary>

```sh
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install neovim git ripgrep fd gcc make

# Optional: Install development tools
brew install stylua luacheck

# Clone config
git clone <your-fork-url> "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary>Ubuntu/Debian</summary>

```sh
# Add Neovim PPA for latest version
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update

# Install dependencies
sudo apt install neovim git make gcc ripgrep unzip xclip fd-find

# Optional: Install development tools
cargo install stylua
sudo apt install luarocks && luarocks install luacheck

# Clone config
git clone <your-fork-url> "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary>Fedora</summary>

```sh
# Install dependencies
sudo dnf install -y neovim git make gcc ripgrep fd-find unzip

# Optional: Install development tools
cargo install stylua
sudo dnf install luarocks && luarocks install luacheck

# Clone config
git clone <your-fork-url> "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary>Arch Linux</summary>

```sh
# Install dependencies
sudo pacman -S --noconfirm --needed neovim git make gcc ripgrep fd unzip

# Optional: Install development tools
sudo pacman -S stylua lua51-luacheck

# Clone config
git clone <your-fork-url> "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

## Customization

### Adding a New Plugin

Create a new file in the appropriate `lua/plugins/` subdirectory:

```lua
-- lua/plugins/editor/my-plugin.lua
return {
	'author/plugin-name',
	event = 'VeryLazy',
	config = function()
		-- Plugin configuration
	end,
}
```

Lazy.nvim will automatically detect and load it.

### Modifying Settings

- **Vim options**: Edit `lua/config/options.lua`
- **Key mappings**: Edit `lua/config/keymaps.lua`
- **LSP servers**: Edit `lua/plugins/lsp/servers.lua`
- **Colorscheme**: Edit `lua/plugins/ui/colorscheme.lua`

### Code Quality Standards

Before committing changes:
```sh
make pre-commit
```

This runs formatting and linting checks to ensure code quality.

## Key Mappings

Leader key: `<Space>`

### General
- `<Esc>` - Clear search highlights
- `<leader>q` - Open diagnostic quickfix list
- `<C-h/j/k/l>` - Navigate between windows

### LSP (when attached)
- `grd` - Go to definition
- `grr` - Find references
- `gri` - Go to implementation
- `grt` - Go to type definition
- `grn` - Rename symbol
- `gra` - Code action

### Telescope
- `<leader>sf` - Search files
- `<leader>sg` - Live grep
- `<leader>sw` - Search current word
- `<leader>sh` - Search help
- `<leader>sk` - Search keymaps
- `<leader>/` - Fuzzy search in current buffer

### Git (via gitsigns)
- `]c` / `[c` - Next/previous git change
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line

See `lua/config/keymaps.lua` and `lua/plugins/lsp/keymaps.lua` for full list.

## FAQ

### General Questions

- [How is this different from kickstart.nvim?](#q-how-is-this-different-from-kickstartnvim)
- [Can I sync this with upstream kickstart.nvim?](#q-can-i-sync-this-with-upstream-kickstartnvim)
- [Why tabs instead of spaces?](#q-why-tabs-instead-of-spaces)
- [How do I uninstall?](#q-how-do-i-uninstall)
- [Where can I get help?](#q-where-can-i-get-help)

### Plugin Management

- [How do I add a new plugin?](#q-how-do-i-add-a-new-plugin)
- [How do I remove an existing plugin?](#q-how-do-i-remove-an-existing-plugin)
- [How do I temporarily disable a plugin without removing it?](#q-how-do-i-temporarily-disable-a-plugin-without-removing-it)
- [How do I load a local plugin from my filesystem?](#q-how-do-i-load-a-local-plugin-from-my-filesystem)
- [How do I load a plugin only for specific filetypes?](#q-how-do-i-load-a-plugin-only-for-specific-filetypes)
- [How do I pin a plugin to a specific version?](#q-how-do-i-pin-a-plugin-to-a-specific-version)
- [How do I update plugins?](#q-how-do-i-update-plugins)
- [How do I see what plugins are installed and their status?](#q-how-do-i-see-what-plugins-are-installed-and-their-status)
- [How do I configure lazy-loading for better startup performance?](#q-how-do-i-configure-lazy-loading-for-better-startup-performance)
- [A plugin is causing errors. How do I troubleshoot?](#q-a-plugin-is-causing-errors-how-do-i-troubleshoot)

---

**Q: How is this different from kickstart.nvim?**

A: This uses the same plugins and functionality, but restructures the code
into a modular architecture with professional tooling (Makefile, linting,
formatting) for easier maintenance and customization.

**Q: Can I sync this with upstream kickstart.nvim?**

A: Not directly, since the structure is different. However, you can manually
port new features by adding them to the appropriate module files.

**Q: Why tabs instead of spaces?**

A: Personal preference. You can change this in `.stylua.toml` and `.luarc.json`,
then run `make format-fix`.

**Q: How do I uninstall?**

A: Delete the config and data directories:
```sh
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
```

**Q: Where can I get help?**

A: Check the original [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
documentation and Neovim's `:help` system. Most configuration is well-commented.

### Plugin Management

**Q: How do I add a new plugin?**

A: Create a new file in the appropriate `lua/plugins/` subdirectory:

```lua
-- Example: lua/plugins/editor/my-new-plugin.lua
return {
	'author/plugin-name',
	event = 'VeryLazy',  -- Lazy load on VeryLazy event
	dependencies = {
		'required/dependency',  -- Optional dependencies
	},
	opts = {
		-- Plugin options here
		setting1 = true,
		setting2 = 'value',
	},
	config = function()
		-- Advanced configuration if needed
		require('plugin-name').setup {
			-- Custom setup
		}
	end,
}
```

Choose the right category:
- `lua/plugins/ui/` - UI enhancements (themes, statusline, etc.)
- `lua/plugins/editor/` - Editor features (fuzzy finders, file trees, etc.)
- `lua/plugins/lsp/` - LSP-related plugins
- `lua/plugins/coding/` - Coding tools (completion, snippets, etc.)
- `lua/plugins/git/` - Git integration

Restart Neovim or run `:Lazy sync` to install the new plugin.

**Q: How do I remove an existing plugin?**

A: Simply delete the plugin's file (or comment out the `return` statement):

```sh
# Option 1: Delete the file
rm lua/plugins/editor/telescope.lua

# Option 2: Or comment out the return in the file
# return {
#   'nvim-telescope/telescope.nvim',
#   ...
# }
```

Then restart Neovim and run `:Lazy clean` to remove the plugin from disk.

For plugins defined in `lua/config/lazy.lua` imports, remove the import line:
```lua
-- Before
require('lazy').setup({
	{ import = 'plugins.ui' },
	{ import = 'plugins.editor' },  -- Remove this line to skip all editor plugins
	{ import = 'plugins.lsp' },
	...
}, { ... })
```

**Q: How do I temporarily disable a plugin without removing it?**

A: Add `enabled = false` to the plugin spec:

```lua
return {
	'author/plugin-name',
	enabled = false,  -- Temporarily disable
	-- ... rest of config
}
```

Or conditionally disable:
```lua
return {
	'author/plugin-name',
	enabled = function()
		-- Only enable for specific filetypes
		return vim.bo.filetype == 'lua'
	end,
}
```

**Q: How do I load a local plugin from my filesystem?**

A: Use the `dir` option instead of the plugin name:

```lua
-- Example: lua/plugins/editor/my-local-plugin.lua
return {
	dir = '~/projects/my-plugin',  -- Path to local plugin directory
	name = 'my-plugin',  -- Give it a name
	config = function()
		require('my-plugin').setup {}
	end,
}
```

The local directory should have the standard plugin structure:
```
~/projects/my-plugin/
├── plugin/
│   └── my-plugin.lua
└── lua/
    └── my-plugin/
        └── init.lua
```

**Q: How do I load a plugin only for specific filetypes?**

A: Use the `ft` option:

```lua
return {
	'author/python-plugin',
	ft = 'python',  -- Load only for Python files
}

-- Or multiple filetypes:
return {
	'author/web-plugin',
	ft = { 'html', 'css', 'javascript' },
}
```

**Q: How do I pin a plugin to a specific version?**

A: Use the `tag`, `branch`, or `commit` option:

```lua
return {
	'author/plugin-name',
	tag = 'v1.2.3',  -- Pin to specific tag
	-- OR
	branch = 'stable',  -- Pin to specific branch
	-- OR
	commit = 'abc123',  -- Pin to specific commit
}
```

**Q: How do I update plugins?**

A: Run `:Lazy update` in Neovim, or from the command line:
```sh
nvim --headless "+Lazy! sync" +qa
```

To update a specific plugin: `:Lazy update plugin-name`

**Q: How do I see what plugins are installed and their status?**

A: Run `:Lazy` in Neovim to open the Lazy.nvim UI. You can:
- Press `I` to install missing plugins
- Press `U` to update plugins
- Press `X` to clean removed plugins
- Press `S` to sync (install + update + clean)
- Press `?` for help

**Q: How do I configure lazy-loading for better startup performance?**

A: Lazy.nvim provides several loading strategies:

```lua
return {
	'author/plugin-name',

	-- Load on specific events
	event = 'VeryLazy',  -- After UI loads
	-- OR
	event = { 'BufReadPre', 'BufNewFile' },  -- On file open

	-- Load on specific commands
	cmd = { 'CommandName', 'AnotherCommand' },

	-- Load on specific keys
	keys = {
		{ '<leader>x', '<cmd>CommandName<cr>', desc = 'Description' },
	},

	-- Load for specific filetypes
	ft = { 'lua', 'python' },

	-- Lazy load by default (manual require)
	lazy = true,
}
```

**Q: A plugin is causing errors. How do I troubleshoot?**

A: Follow these steps:

1. Check the plugin status: `:Lazy`
2. View error messages: `:messages`
3. Check plugin health: `:checkhealth plugin-name`
4. Enable debug mode by adding to `lua/config/lazy.lua`:
```lua
require('lazy').setup({
	-- ... your plugins
}, {
	debug = true,  -- Enable debug logging
})
```
5. Check Lazy logs: `:Lazy log`
6. Try reinstalling: `:Lazy clean` then `:Lazy install`

## Credits

This configuration is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
by TJ DeVries and contributors. The modular structure is inspired by best
practices from the Neovim community.

## License

MIT License - same as the original kickstart.nvim project.
