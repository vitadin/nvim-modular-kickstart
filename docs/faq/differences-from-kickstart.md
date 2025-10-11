# How is this different from kickstart.nvim?

This configuration uses the same plugins and functionality as the original
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), but restructures
the code with several key improvements:

## Modular Architecture

**Original kickstart.nvim:**
- Single `init.lua` file (~1000+ lines)
- All configuration in one place
- Difficult to navigate and customize

**This configuration:**
- Minimal `init.lua` entry point (40 lines)
- Organized into logical modules:
  - `lua/config/` - Core settings (options, keymaps, autocmds)
  - `lua/plugins/` - Plugin specifications organized by category
- Easy to find and modify specific functionality

## Professional Tooling

Added development tools not present in kickstart:
- **Makefile** - Build automation with targets:
  - `make check` - Run formatting and linting
  - `make format-fix` - Auto-format all files
  - `make lint` - Lint with luacheck
  - `make test` - Validate Lua syntax
  - `make pre-commit` - Full validation pipeline

- **Code Quality Configuration:**
  - `.stylua.toml` - Consistent code formatting
  - `.luacheckrc` - Lua linting rules
  - `.luarc.json` - Lua LSP configuration

## Code Standards

- Consistent indentation: tabs with 4-space width
- Line length limit: 80 characters for readability
- All code passes formatting and linting checks

## Easier Customization

With the modular structure, you can:
- Add a plugin by creating a single file in the appropriate directory
- Remove a plugin by deleting its file
- Modify settings by editing the specific module file
- See at a glance what plugins are installed by browsing `lua/plugins/`

## Trade-offs

**What you gain:**
- Better organization and maintainability
- Professional development workflow
- Easier to understand and customize
- Scales well as you add more plugins

**What you lose:**
- Not a direct sync with upstream kickstart.nvim
- Slightly more files to navigate (though organized logically)
- Need to manually port new kickstart features

## Bottom Line

If you want a **learning tool** that's a single file you can read top to
bottom, use the original kickstart.nvim.

If you want a **professional foundation** that's easy to maintain and
customize as your configuration grows, use this modular version.

[Back to FAQ](../../README.md#faq)
