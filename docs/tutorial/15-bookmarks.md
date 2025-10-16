# Temporary Bookmarks

A simple bookmark system for quick navigation within and across files during your editing session.

## Overview

The bookmark system uses Vim's native marks (a-z) to create temporary session bookmarks that help you jump between important locations in your code. These bookmarks:

- Are **temporary** - cleared when you close Neovim
- Work **across multiple files** - mark positions in different buffers
- Show **visual indicators** - mark letters appear in the sign column
- Are **automatically managed** - cleaned up when buffers are closed

## Basic Usage

### Setting and Removing Bookmarks

| Keybinding | Action |
|------------|--------|
| `mm` | Toggle bookmark at current position |

When you press `mm`:
- **First time**: Creates a bookmark (you'll see a letter like `a`, `b`, `c` in the sign column)
- **Second time**: Removes the bookmark from that line

The system automatically assigns unique letters (a-z) across all your open files:
- First bookmark anywhere → `a`
- Second bookmark anywhere → `b`
- Third bookmark anywhere → `c`
- And so on...

### Navigating Between Bookmarks

| Keybinding | Action |
|------------|--------|
| `mn` | Jump to next bookmark in current buffer |
| `mp` | Jump to previous bookmark in current buffer |

These commands:
- Only jump between bookmarks **in the current file**
- Wrap around (next from last goes to first, and vice versa)
- Show which bookmark you jumped to

### Viewing All Bookmarks

| Keybinding | Action |
|------------|--------|
| `ml` | List all bookmarks (Vim marks window) |
| `<leader>mb` | Show bookmarks in Telescope picker |

**Using `ml` (Vim marks window):**
```
mark line  col file/text
 a     10    0 function toggle_bookmark()
 b     25    5 local mark_char = nil
```

To jump to a specific bookmark from this list, type:
- `'a` - Jump to bookmark a
- `'b` - Jump to bookmark b
- And so on...

**Using `<leader>mb` (Telescope picker):**

This provides a more interactive interface:
- See all bookmarks with file names, line numbers, and content preview
- Fuzzy search by typing (searches mark letter, filename, or content)
- Navigate with arrow keys or `Ctrl+n`/`Ctrl+p`
- Press `Enter` to jump to selected bookmark
- Preview the file in the right panel

### Clearing Bookmarks

| Keybinding | Action |
|------------|--------|
| `mc` | Clear all bookmarks in current buffer |
| `mx` | Clear all bookmarks across all buffers |

Bookmarks are also automatically cleared when:
- You close a buffer (`:bd`, `:q`) - removes bookmarks in that buffer only
- You exit Neovim (`:qa`) - removes all bookmarks

## Common Workflows

### Workflow 1: Jumping Between Documentation and Implementation

Scenario: Reading API documentation in one file, implementing in another.

```
1. Open docs/api.md
2. Press `mm` on the function signature you're implementing
   → Bookmark 'a' appears
3. Open src/implementation.js
4. Press `mm` where you'll write the code
   → Bookmark 'b' appears
5. Use `'a` to jump back to docs
6. Use `'b` to jump back to implementation
7. Repeat as needed
```

### Workflow 2: Tracking Multiple Related Functions

Scenario: Refactoring code spread across multiple locations in a file.

```
1. Press `mm` at first function
   → Bookmark 'a'
2. Press `mm` at second function
   → Bookmark 'b'
3. Press `mm` at third function
   → Bookmark 'c'
4. Use `mn` and `mp` to cycle through them
5. Or press `<leader>mb` to see all three and jump to any
```

### Workflow 3: Multi-File Debugging

Scenario: Tracking down a bug across several files.

```
1. Set bookmark at error location in logs.txt
2. Set bookmark at suspected cause in utils.js
3. Set bookmark at function call in main.js
4. Set bookmark at configuration in config.json
5. Press `<leader>mb` to see all locations
6. Jump between them to trace the issue
7. Press `mx` to clear all when done
```

### Workflow 4: Code Review Annotations

Scenario: Marking sections during code review.

```
1. Open file for review
2. Press `mm` at each section that needs attention
3. Add more bookmarks as you find issues
4. Press `<leader>mb` to see all marked sections
5. Jump through them to address each item
6. Press `mc` to clear when file is done
```

## Tips and Tricks

### Bookmark Capacity

- You have **26 bookmark slots** (a-z) across all files
- Letters are assigned globally in order
- If all 26 are used, you'll see "No available bookmark slots"
- Use `mx` to clear all and start fresh

### Buffer-Local vs Global

While Vim's lowercase marks (a-z) are technically buffer-local, this bookmark system treats them as **global** - each mark letter is unique across your entire session. This makes it easier to track bookmarks across multiple files.

### Persistence

Bookmarks are **not saved** between sessions - this is intentional! They're designed for temporary workflow navigation, not permanent code annotations. For permanent markers, consider:
- Using comments in your code
- Creating TODO items
- Using version control annotations

### Visual Indicators

The orange letters in the sign column make bookmarks easy to spot:
- Quickly scan to see which lines are bookmarked
- The letter tells you which mark it is (for direct jumping with `'a`, etc.)
- Color can be customized in `lua/plugins/editor/bookmarks.lua`

### Comparison with Vim Marks

This bookmark system is built on top of Vim's native marks but adds:
- Visual sign column indicators
- Automatic cleanup on buffer close and exit
- Global letter assignment across buffers
- Convenient keybindings for common operations
- Telescope integration for visual browsing

You can still use native Vim mark commands:
- `'a` - Jump to bookmark a
- `` `a `` - Jump to exact position of bookmark a
- `:marks` - Show all marks (including system marks)

## Troubleshooting

### "No bookmarks set" when I know I have bookmarks

Make sure you're checking in the right place:
- `mn`/`mp` only show bookmarks in the **current buffer**
- Use `<leader>mb` to see bookmarks across **all buffers**

### Bookmarks disappeared after closing file

This is expected behavior - bookmarks in a buffer are cleared when you close it. If you need to preserve them, keep the buffer open (you can hide it with `:hide` instead of `:bd`).

### Can't see bookmark letters in sign column

Check that:
- The sign column is enabled (`:set signcolumn=yes` or `auto`)
- No other plugin is overriding the sign column
- Your color scheme supports the orange highlight

### Old marks showing up with `'a`

If you manually created marks outside this system, they won't have visual indicators. Either:
- Use `mm` to create bookmarks through this system
- Clear all marks with `:delmarks a-z` to start fresh

## Summary

**Quick Reference:**

```
mm           - Toggle bookmark
mn / mp      - Next/previous bookmark in buffer
ml           - List bookmarks (Vim marks)
<leader>mb   - Browse bookmarks (Telescope)
mc           - Clear bookmarks in current buffer
mx           - Clear all bookmarks
'a / 'b / etc - Jump directly to bookmark
```

The bookmark system is perfect for temporary navigation during development, refactoring, debugging, and code review workflows. Since bookmarks are session-based, you always start fresh when you open Neovim!
