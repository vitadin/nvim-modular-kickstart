# User Configuration System

## The Git Pull Conflict Problem

When using a git-based Neovim configuration, users face a common dilemma:

**Scenario:**
1. User clones the repository
2. User enables optional features (like LaTeX) by editing config files
3. Repository gets updated
4. User runs `git pull`
5. **CONFLICT**: Git refuses to pull because local files were modified

**Traditional "solutions" (all problematic):**
- `git stash && git pull && git stash pop` - Manual, error-prone, users forget steps
- Use a personal branch - Complex for most users
- Fork the repository - Loses easy upstream updates
- Hard-code features as enabled - Bloats config for non-users

## Our Solution: Git-Ignored User Config

This repository uses a **user configuration file** that is git-ignored, providing clean separation between:
- **Repository code** (tracked by git, updated with `git pull`)
- **Personal preferences** (not tracked, never conflicts)

### How It Works

1. **Example file is tracked**: `lua/user-config.lua.example`
   - Committed to git
   - Shows all available options
   - Gets updated when new features are added

2. **Actual config is ignored**: `lua/user-config.lua`
   - Added to `.gitignore`
   - User creates it by copying the example
   - User edits to enable/disable features
   - Never tracked by git, never conflicts

3. **Plugins read user config**: Optional features check the user config
   - If `user-config.lua` doesn't exist → features disabled (safe default)
   - If `user-config.lua` exists → respects user's choices

## Setup Process

### For New Users

```bash
# 1. Clone the repository
git clone <repo-url> ~/.config/nvim-modular

# 2. Create your personal config
cd ~/.config/nvim-modular
cp lua/user-config.lua.example lua/user-config.lua

# 3. Edit to enable desired features
nvim lua/user-config.lua
# Change latex = false to latex = true, etc.

# 4. Start Neovim
nvim
```

### Updating the Repository

```bash
# Just pull - no conflicts!
git pull
```

Your `lua/user-config.lua` is ignored, so it's never touched by git.

If new options are added to `user-config.lua.example`, you can:
1. View the example: `cat lua/user-config.lua.example`
2. Manually add new options to your `lua/user-config.lua`

## Current Optional Features

### LaTeX Support

**Configuration:**
```lua
-- lua/user-config.lua
return {
	latex = true,  -- Enables VimTeX + texlab LSP
}
```

**What it controls:**
- `lua/plugins/editor/vimtex.lua` - Reads `user_config.latex` for `enabled` setting
- `lua/lsp/servers.lua` - Skips loading `texlab.lua` if `latex = false`

**Benefits:**
- LaTeX users enable it once, updates never disable it
- Non-LaTeX users never see LaTeX features
- Repository can update VimTeX/texlab config without user conflicts

### Neovide Font Customization

**Configuration:**
```lua
-- lua/user-config.lua
return {
	neovide = {
		-- Option 1: Specify complete font string
		font = "JetBrainsMono Nerd Font:h18",

		-- Option 2: Just change the size (keeps Neovide's default font)
		font_size = 20,

		-- Option 3: Leave both nil to use Neovide's default system font
		font = nil,
		font_size = nil,
	}
}
```

**What it controls:**
- `lua/config/neovide.lua` - Reads `user_config.neovide.font` and `user_config.neovide.font_size`
- Sets `vim.o.guifont` based on user preference
- If nothing is specified, Neovide uses its own default font (usually system monospace)

**Benefits:**
- Font preference saved in git-ignored file
- Easy to try different fonts without editing repository files
- Repository updates won't overwrite your font choice
- Flexible: set full font string, just size, or use system default
- Respects Neovide's defaults when not configured

## For Developers: Adding New Optional Features

When adding a new optional feature:

### Step 1: Add to user-config.lua.example

```lua
-- lua/user-config.lua.example
return {
	latex = false,
	markdown_preview = false,  -- NEW FEATURE (boolean)

	-- Or for nested configuration:
	neovide = {
		font = nil,  -- NEW FEATURE (nested config)
	},
}
```

### Step 2: Make plugin/config conditional

**Example 1: Enable/disable a plugin**
```lua
-- lua/plugins/editor/markdown-preview.lua

-- Load user configuration
local user_config = {}
local ok, config = pcall(require, 'user-config')
if ok then
	user_config = config
end

return {
	'plugin-name',
	enabled = user_config.markdown_preview or false,
	-- ... rest of config
}
```

**Example 2: Use nested config values**
```lua
-- lua/config/neovide.lua

-- Load user configuration
local user_config = {}
local ok, config = pcall(require, 'user-config')
if ok then
	user_config = config
end

-- Use nested config with fallback
local font = 'Fira Code:h19'  -- default
if user_config.neovide and user_config.neovide.font then
	font = user_config.neovide.font
end

vim.o.guifont = font
```

### Step 3: Document in tutorial

Create `docs/tutorial/XX-feature-setup.md` explaining:
- What the feature does
- Prerequisites
- How to enable (edit `user-config.lua`)
- How to use

### Step 4: Update README

Add feature to "Optional Features" section in main README.

## Technical Implementation

### Loading Pattern

All optional features use this pattern:

```lua
-- Load user configuration (git-ignored, prevents git pull conflicts)
local user_config = {}
local ok, config = pcall(require, 'user-config')
if ok then
	user_config = config
end

-- Use with fallback to false (disabled by default)
enabled = user_config.feature_name or false
```

**Why `pcall`?**
- If `user-config.lua` doesn't exist, `pcall` returns `false` instead of error
- Config works out-of-the-box without requiring users to create the file
- Graceful degradation for fresh installs

### Conditional LSP Loading

For LSP servers that should only load with a feature:

```lua
-- lua/lsp/servers.lua
for _, filepath in ipairs(server_files) do
	local filename = vim.fn.fnamemodify(filepath, ':t:r')

	-- Skip certain servers based on user config
	if filename == 'texlab' and not user_config.latex then
		goto continue
	end

	-- Load server...
	::continue::
end
```

## Advantages of This Approach

### For Users

✅ **Simple**: Copy one file, edit one line
✅ **Safe**: `git pull` never conflicts
✅ **Persistent**: Settings survive repository updates
✅ **Clean**: Only see features you actually use
✅ **Discoverable**: `user-config.lua.example` shows what's available

### For Repository Maintainers

✅ **Flexible**: Can update optional features freely
✅ **Scalable**: Easy to add new optional features
✅ **No support burden**: Users can't "break" updates
✅ **Clear separation**: Code vs. user preferences

### For Contributors

✅ **Clear pattern**: Consistent way to add optional features
✅ **Git-friendly**: No need to track user-specific changes
✅ **Testable**: CI can test both enabled/disabled states

## Comparison to Other Approaches

| Approach | Pros | Cons |
|----------|------|------|
| **Edit files directly** | Simple | Git pull conflicts |
| **Git stash workflow** | Works | Manual, error-prone |
| **Personal branch** | Full control | Complex, merge conflicts |
| **Fork repository** | Total freedom | Loses upstream updates |
| **User config file** ✅ | Simple + safe | Requires documentation |

## Future Extensions

This system can be extended for:

- **Per-filetype settings**: `user_config.python.linter = 'ruff'`
- **Theme preferences**: `user_config.theme = 'catppuccin'`
- **Keybinding overrides**: `user_config.keymaps = { leader = ',' }`
- **Plugin choices**: `user_config.completion = 'nvim-cmp'` vs `'blink.cmp'`

## Related Documentation

- [LaTeX Setup Tutorial](./tutorial/12-latex-setup.md) - First feature using this system
- [Contributing Guide](../CONTRIBUTING.md) - Guidelines for adding features

---

[Back to Main README](../README.md)
