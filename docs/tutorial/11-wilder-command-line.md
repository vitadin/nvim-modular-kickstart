# Wilder.nvim: Enhanced Command-Line Experience

A better command-line interface with fuzzy completion and popup menu.

## What is Wilder.nvim?

Wilder.nvim enhances Neovim's command-line with a beautiful popup menu and fuzzy
matching. Instead of seeing suggestions in a cramped single line at the bottom,
you get:

- **Popup menu above command-line** - Clear visual display of all suggestions
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

When you type `:` (command mode), `/` (search forward), or `?` (search backward), you'll see the command-line at the bottom. **The popup menu only appears when you press `<Tab>`**.

**Try it:**
1. Press `:` to enter command mode
2. Type `q` (no popup yet - this is normal!)
3. Press `<Tab>` - NOW the popup appears with suggestions like :quit, :qa, :qall
4. Type more letters to narrow down: `qu<Tab>` → shows :quit, :quitall, etc.

**Important:** The popup is **triggered by Tab**, not by just typing. This gives you control over when you want to see suggestions.

---

## Navigating Suggestions

### Key Bindings

| Key           | Action                                      |
|---------------|---------------------------------------------|
| `<Tab>`       | Move to next suggestion (cycle forward)     |
| `<Shift-Tab>` | Move to previous suggestion (cycle back)    |
| `<Enter>`     | Accept highlighted suggestion and execute   |
| `<Esc>`       | Cancel and close popup                      |

**Note:** There's only ONE popup menu from wilder.nvim. If you see two popups, restart Neovim to clear the native wildmenu cache.

### Navigation Workflow

**Example 1: Selecting from suggestions**
```
1. Type :q
2. Press <Tab> - Popup shows: :q, :qa, :qall, :quit
3. Press <Tab> again to highlight next item (:qa)
4. Press <Enter> to execute :qa
```

**Example 2: Quick execution (no popup needed)**
```
1. Type :wq
2. Press <Enter> immediately (no need to open popup)
```

**Example 3: Cycle through options**
```
1. Type :buf
2. Press <Tab> - Popup opens with :buffer, :buffers, :buffer!, etc.
3. Press <Tab> again → highlights :buffers
4. Press <Tab> again → highlights :buffer!
5. Press <Enter> when you find the right one
```

**Example 4: Fuzzy search workflow**
```
1. Type :vs (want :vsplit)
2. Press <Tab> - Shows :vsplit, :vscmd, :visual
3. First item (:vsplit) is already highlighted
4. Press <Enter> to execute :vsplit
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

#### 1. Basic Setup (Lines 15-29)

```lua
-- Disable native wildmenu to prevent conflicts
vim.opt.wildmenu = false
vim.opt.wildmode = ''

wilder.setup {
    modes = { ':', '/', '?' },     -- Enable for command, search forward/back
    next_key = '<Tab>',            -- Navigate to next suggestion
    previous_key = '<S-Tab>',      -- Navigate to previous suggestion
    accept_key = '<CR>',           -- Enter to accept
    reject_key = '<Esc>',          -- Escape to cancel
    enable_cmdline_enter = 0,      -- Don't show popup on :, only on Tab
}
```

**Key setting:** `enable_cmdline_enter = 0` means the popup only appears when you press Tab, not automatically when you type `:`. This prevents the "two popup" confusion.

**To customize key bindings:**
- Change `next_key` to use a different key for next suggestion
- Change `previous_key` for previous suggestion
- Example: Use `<C-n>` and `<C-p>` like you would in completion menus

#### 2. Fuzzy Matching Pipeline (Lines 25-36)

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

#### 3. Popup Appearance (Lines 38-54)

```lua
wilder.set_option(
    'renderer',
    wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
        highlights = {
            border = 'Normal',           -- Border color
            accent = 'WilderAccent',     -- Highlighted item color
        },
        border = 'rounded',              -- Border style: 'single', 'double', 'rounded'
        max_height = '20%',              -- Maximum popup height
        min_height = 0,                  -- Minimum popup height
        prompt_position = 'top',         -- Prompt at top or bottom of popup
        reverse = 0,                     -- Set to 1 to reverse list order
        left = { ' ', wilder.popupmenu_devicons() },   -- Left decorations
        right = { ' ', wilder.popupmenu_scrollbar() }, -- Right decorations
    })
)
```

**To customize appearance:**
- Change `border` style: `'single'`, `'double'`, `'rounded'`, `'solid'`
- Adjust `max_height` to control popup size (e.g., `'30%'`, `'50%'`)
- Change `prompt_position` to `'bottom'` to show newest items first
- Modify highlight colors (line 57)

#### 4. Custom Highlights (Line 57)

```lua
vim.api.nvim_set_hl(0, 'WilderAccent', { fg = '#5ea1ff' })
```

**To customize colors:**
- Change the hex color `'#5ea1ff'` to your preferred color
- Add more highlight groups if needed

---

## Customization Examples

### Example 1: Use Ctrl+N/P for Navigation

Edit `lua/plugins/ui/wilder.lua`, lines 19-20:

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

### Two Popup Windows Appearing (Most Common Issue)

**Problem:** When typing `:` command, you see a small initial popup, then pressing `<Tab>` shows a DIFFERENT larger popup with more items. This is confusing!

**Root cause:** Either native `wildmenu` is conflicting, OR wilder is showing an auto-popup that you don't want.

**Solution:**

1. **Check the configuration** - Ensure `enable_cmdline_enter = 0` is set:
   ```vim
   " Open the config
   :e lua/plugins/ui/wilder.lua
   " Look for line 28: enable_cmdline_enter = 0
   ```
   This disables the auto-popup on `:`, so popup only appears when you press Tab.

2. **Restart Neovim completely**:
   ```vim
   :qa
   ```
   Then reopen Neovim

3. **Verify wildmenu is disabled**:
   ```vim
   :set wildmenu?
   :set wildmode?
   ```
   Both should show `nowildmenu` and empty `wildmode`.

4. **Expected behavior after fix:**
   - Type `:` → No popup (just command-line)
   - Type `:q` → Still no popup (just text on command-line)
   - Press `<Tab>` → NOW popup appears with suggestions
   - Press `<Tab>` again → Cycles through suggestions in SAME popup

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
