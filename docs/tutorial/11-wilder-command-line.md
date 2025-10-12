# Wilder.nvim: Enhanced Command-Line Experience

A better command-line interface with fuzzy completion and popup menu displayed in
the center of your screen.

## What is Wilder.nvim?

Wilder.nvim transforms Neovim's command-line experience with a beautiful popup
menu and fuzzy matching. Instead of seeing suggestions in a cramped single line,
you get:

- **Centered popup palette** - Command input and suggestions appear in center of screen
- **Fuzzy matching** - Type partial strings, get smart suggestions
- **Visual feedback** - See all matching commands at once
- **Faster navigation** - Tab through suggestions quickly

**Example:**
```
Type: :qa
See:  :qa, :qall, :quit (in a popup menu)
```

---

## Basic Usage

### Starting a Command

When you type `:` (command mode), `/` (search forward), or `?` (search
backward), wilder automatically shows a popup menu with suggestions.

**Try it:**
1. Press `:` to enter command mode
2. Type `q` - See all commands starting with 'q'
3. Type more letters to narrow down: `qu` → shows :quit, :quitall, etc.

---

## Navigating Suggestions

### Key Bindings

| Key           | Action                                      |
|---------------|---------------------------------------------|
| `<Tab>`       | Move to next suggestion (cycle forward)     |
| `<Shift-Tab>` | Move to previous suggestion (cycle back)    |
| `<Enter>`     | Accept highlighted suggestion and execute   |
| `<Down>`      | Accept suggestion                           |
| `<Up>`        | Reject suggestion                           |
| `<Esc>`       | Cancel and close popup                      |

### Navigation Workflow

**Example 1: Selecting from suggestions**
```
1. Type :q
2. Popup shows: :q, :qa, :qall, :quit
3. Press <Tab> to highlight :qa
4. Press <Enter> to execute :qa
```

**Example 2: Quick execution**
```
1. Type :wq
2. Press <Enter> immediately (no need to select)
```

**Example 3: Cycle through options**
```
1. Type :buf
2. Press <Tab> → :buffer
3. Press <Tab> → :buffers
4. Press <Tab> → :buffer!
5. Press <Enter> when you find the right one
```

---

## Fuzzy Matching

Wilder uses fuzzy matching powered by `fzy` algorithm. You don't need to type
exact strings.

### How Fuzzy Matching Works

**Type partial characters in order:**
```
:sf      → matches :setfiletype
:td      → matches :tabdo, :tabedit
:vsplit  → matches :vsplit (exact match prioritized)
:vs      → matches :vsplit, :visual, :vscmd
```

**Type characters from middle of word:**
```
:map     → matches :nmap, :vmap, :imap, :map
:close   → matches :close, :lclose, :cclose
```

### Fuzzy Search Tips

1. **Type fewer characters** - Let fuzzy matching do the work
   - Instead of `:colorscheme`, type `:cols` or `:color`

2. **Use distinctive characters** - Pick unique letters
   - `:td` quickly gets you to `:tabdo`
   - `:bn` quickly gets you to `:bnext`

3. **Mix start and middle** - Combine patterns
   - `:buf` → buffer commands
   - `:vsp` → :vsplit

---

## Common Commands with Wilder

### File Operations
```
:e        → :edit (open file)
:w        → :write (save file)
:wq       → :wq (save and quit)
:q        → :quit, :qa, :qall
:sav      → :saveas (save as new file)
```

### Buffer Operations
```
:b        → :buffer, :bnext, :bprevious
:bd       → :bdelete (close buffer)
:ls       → :ls (list buffers)
```

### Window Operations
```
:vs       → :vsplit (vertical split)
:sp       → :split (horizontal split)
:on       → :only (close other windows)
```

### Search Commands
```
/pattern  → Search forward (wilder shows search history)
?pattern  → Search backward
:g/       → :global (global command)
```

---

## Configuration

### Where is Wilder Configured?

The wilder.nvim configuration is located at:
```
lua/plugins/ui/wilder.lua
```

### Key Configuration Sections

#### 1. Disabling Native Wildmenu (Lines 15-17)

```lua
-- Disable native wildmenu to prevent conflicts with wilder
vim.opt.wildmenu = false
vim.opt.wildmode = ''
```

**Why this is needed:**
- Neovim has a native command-line completion menu (wildmenu)
- Without disabling it, you'll see TWO menus: native (bottom left) and wilder (center)
- Tab key would control the native menu, not wilder's
- Disabling wildmenu ensures only wilder's centered popup is shown

#### 2. Basic Setup (Lines 19-27)

```lua
wilder.setup {
    modes = { ':', '/', '?' },     -- Enable for command, search forward/back
    next_key = '<Tab>',            -- Navigate to next suggestion
    previous_key = '<S-Tab>',      -- Navigate to previous suggestion
    accept_key = '<Down>',         -- Accept suggestion
    reject_key = '<Up>',           -- Reject suggestion
}
```

**To customize key bindings:**
- Change `next_key` to use a different key for next suggestion
- Change `previous_key` for previous suggestion
- Example: Use `<C-n>` and `<C-p>` like you would in completion menus

#### 3. Fuzzy Matching Pipeline (Lines 29-40)

```lua
wilder.set_option('pipeline', {
    wilder.branch(
        wilder.cmdline_pipeline {
            fuzzy = 1,                              -- Enable fuzzy matching
            fuzzy_filter = wilder.lua_fzy_filter(), -- Use fzy algorithm
        },
        wilder.search_pipeline()
    ),
})
```

**To customize fuzzy matching:**
- Set `fuzzy = 0` to disable fuzzy matching (exact match only)
- Change `fuzzy_filter` to use different algorithm

#### 4. Popup Appearance (Lines 42-61)

```lua
wilder.set_option(
    'renderer',
    wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
        -- Palette theme centers the command-line and popup together
        border = 'rounded',              -- Border style: 'single', 'double', 'rounded'
        max_height = '20%',              -- Maximum popup height
        min_height = 0,                  -- Minimum popup height
        prompt_position = 'top',         -- Prompt at top or bottom
        reverse = 0,                     -- Set to 1 to reverse list order
        pumblend = 20,                   -- Transparency (0-100, 0 = opaque)
        highlights = {
            border = 'Normal',           -- Border color
            accent = 'WilderAccent',     -- Highlighted item color
        },
        left = { ' ', wilder.popupmenu_devicons() },   -- Left decorations
        right = { ' ', wilder.popupmenu_scrollbar() }, -- Right decorations
    })
)
```

**Theme Options:**
- `popupmenu_palette_theme` - Centers both input and popup (current setting)
- `popupmenu_border_theme` - Popup menu only, input stays at bottom

**To customize appearance:**
- Change `border` style: `'single'`, `'double'`, `'rounded'`, `'solid'`
- Adjust `max_height` to control popup size (e.g., `'30%'`, `'50%'`)
- Change `prompt_position` to `'bottom'` to move input to bottom
- Adjust `pumblend` for transparency (0 = opaque, 100 = fully transparent)
- Modify highlight colors (line 60)

#### 5. Custom Highlights (Line 64)

```lua
vim.api.nvim_set_hl(0, 'WilderAccent', { fg = '#5ea1ff' })
```

**To customize colors:**
- Change the hex color `'#5ea1ff'` to your preferred color
- Add more highlight groups if needed

---

## Customization Examples

### Example 1: Use Ctrl+N/P for Navigation

Edit `lua/plugins/ui/wilder.lua`, line 18-19:

```lua
wilder.setup {
    modes = { ':', '/', '?' },
    next_key = '<C-n>',        -- Changed from <Tab>
    previous_key = '<C-p>',    -- Changed from <S-Tab>
    accept_key = '<Down>',
    reject_key = '<Up>',
}
```

### Example 2: Change Border Style to Single Line

Edit `lua/plugins/ui/wilder.lua`, line 46:

```lua
border = 'single',  -- Changed from 'rounded'
```

### Example 3: Make Popup Taller

Edit `lua/plugins/ui/wilder.lua`, line 47:

```lua
max_height = '40%',  -- Changed from '20%'
```

### Example 4: Disable Fuzzy Matching

Edit `lua/plugins/ui/wilder.lua`, line 30:

```lua
wilder.cmdline_pipeline {
    fuzzy = 0,  -- Changed from 1 (disables fuzzy)
},
```

---

## Tips and Tricks

### Tip 1: Partial Command Typing

You rarely need to type full commands. Train yourself to type 2-3 letters:

```
:vs   instead of :vsplit
:bn   instead of :bnext
:so   instead of :source
```

### Tip 2: Use Tab Liberally

When in doubt, press `<Tab>` to see what's available:

```
:buf<Tab>  → See all buffer commands
:tab<Tab>  → See all tab commands
:set<Tab>  → See all settings
```

### Tip 3: Search History

Wilder shows your command history. Start typing a command you used before:

```
:!make<Tab>  → Shows your previous make commands
```

### Tip 4: Combine with File Paths

Wilder also completes file paths:

```
:e ~/.conf<Tab>  → Shows files in ~/.config/
:source ~/.<Tab>  → Shows dotfiles
```

---

## Troubleshooting

### Two Menus Showing (Native + Wilder)

**Problem:** Seeing two completion menus - one at bottom left, one centered

**Solution:** Make sure wildmenu is disabled in the configuration (lines 15-17):
```lua
vim.opt.wildmenu = false
vim.opt.wildmode = ''
```

If you added this but still see two menus, restart Neovim.

### Popup Not Showing

**Problem:** Typed `:q` but no popup appears

**Solutions:**
1. Check if wilder is loaded: `:lua print(require('wilder'))`
2. Verify configuration file exists: `lua/plugins/ui/wilder.lua`
3. Run `:Lazy sync` to ensure plugin is installed

### Fuzzy Matching Not Working

**Problem:** Only exact matches show up

**Solution:** Check that `fuzzy = 1` in configuration (line 30)

### Wrong Key Bindings

**Problem:** `<Tab>` doesn't work, or wrong key moves selection

**Solution:** Check your `next_key` and `previous_key` settings (lines 18-19)

---

## Dependencies

Wilder.nvim depends on:
- `romgrk/fzy-lua-native` - Fuzzy matching engine

Both are automatically installed by Lazy.nvim when you have wilder configured.

---

## Advanced: Disable Wilder Temporarily

If you want to disable wilder without removing the plugin:

**Method 1: Comment out the plugin**

Edit `lua/plugins/ui/wilder.lua`, line 5-6:

```lua
-- return {
--     'gelguy/wilder.nvim',
return {} -- Empty return disables the plugin
```

**Method 2: Disable in config**

Add `enabled = false` to the plugin spec:

```lua
return {
    'gelguy/wilder.nvim',
    enabled = false,  -- Add this line
    dependencies = {
        'romgrk/fzy-lua-native',
    },
    -- ... rest of config
}
```

---

## Related Topics

- [Custom Keymaps](./09-custom-keymaps.md) - Create your own key bindings
- [Plugin Management](./10-plugin-management.md) - Managing plugins with Lazy.nvim
- [Telescope](./08-telescope-basic-usage.md) - Another fuzzy finder for files

---

## Summary

**Essential keybindings:**
- `<Tab>` - Next suggestion
- `<Shift-Tab>` - Previous suggestion
- `<Enter>` - Execute command

**Configuration file:**
- `lua/plugins/ui/wilder.lua`

**Core benefit:**
- Fuzzy command-line completion with visual popup menu

**Quick tip:**
- Type fewer characters, let fuzzy matching do the work!

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
