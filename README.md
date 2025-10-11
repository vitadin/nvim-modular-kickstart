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
git clone https://github.com/vitadin/nvim-modular-kickstart.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim-modular
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
git clone https://github.com/vitadin/nvim-modular-kickstart.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
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
git clone https://github.com/vitadin/nvim-modular-kickstart.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
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
git clone https://github.com/vitadin/nvim-modular-kickstart.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
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
git clone https://github.com/vitadin/nvim-modular-kickstart.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary>Arch Linux</summary>

```sh
# Install dependencies
sudo pacman -S --noconfirm --needed neovim git make gcc ripgrep fd unzip

# Optional: Install development tools
sudo pacman -S stylua lua51-luacheck

# Clone config
git clone https://github.com/vitadin/nvim-modular-kickstart.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
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

Comprehensive guides for common questions and configuration tasks.

### General Questions

- **[How is this different from kickstart.nvim?](docs/faq/differences-from-kickstart.md)**

  Learn about the modular architecture, professional tooling, and code quality
  improvements.

- **[Why tabs instead of spaces?](#q-why-tabs-instead-of-spaces)**

  Personal preference. You can easily change this in `.stylua.toml` and
  `.luarc.json`, then run `make format-fix`.

- **[How do I uninstall?](#q-how-do-i-uninstall)**

  Delete the config and data directories:
  ```sh
  rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
  ```

- **[Where can I get help?](#q-where-can-i-get-help)**

  Check the original [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
  documentation and Neovim's `:help` system.

### Plugin Management

#### Adding and Removing Plugins

- **[How do I add a new plugin?](docs/faq/add-plugin.md)**

  Complete guide with examples for adding plugins, choosing the right directory,
  configuring options, dependencies, and lazy-loading.

- **[How do I remove an existing plugin?](docs/faq/remove-plugin.md)**

  Multiple methods for removing plugins: delete files, comment out, or
  temporarily disable. Includes cleanup instructions.

- **[How do I temporarily disable a plugin?](docs/faq/disable-plugin.md)**

  Disable plugins without removing them using `enabled = false` or conditional
  enabling. Perfect for testing and troubleshooting.

#### Advanced Plugin Configuration

- **[How do I load a local plugin from my filesystem?](docs/faq/local-plugin.md)**

  Comprehensive guide to developing and loading local plugins. Includes directory
  structure, hot reload, and publishing workflows.

- **[How do I configure lazy-loading for better startup performance?](docs/faq/lazy-loading.md)**

  Master lazy-loading strategies: events, commands, keys, filetypes. Includes
  performance monitoring and best practices.

#### Plugin Troubleshooting

- **[A plugin is causing errors. How do I troubleshoot?](docs/faq/troubleshooting.md)**

  Systematic debugging process: identify errors, check health, enable debug mode,
  isolate problems, and fix common issues.

### Quick Links

- [All FAQ Documents](docs/faq/README.md)
- [Detailed Plugin Examples](docs/faq/add-plugin.md#complete-real-world-example)
- [Lazy-Loading Strategies](docs/faq/lazy-loading.md)
- [Debugging Commands Reference](docs/faq/troubleshooting.md#quick-reference-debugging-commands)

## Credits

This configuration is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
by TJ DeVries and contributors. The modular structure is inspired by best
practices from the Neovim community.

## License

MIT License - same as the original kickstart.nvim project.
