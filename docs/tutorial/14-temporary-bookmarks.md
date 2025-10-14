# Temporary Bookmarks: Quick Jumping Between Positions

Learn how to use temporary bookmarks to jump between positions in different files during your workflow.

## The Problem

You're working on a task that requires jumping between multiple positions:
- Reading section A in an instruction doc
- Implementing it in section B of your code
- Checking back to section D in the doc
- Updating section X in another file

You need **temporary markers** that:
- Let you jump quickly between positions
- Work across different files
- Clear automatically when you're done
- Don't clutter your file with permanent marks

## The Solution: bookmarks.nvim

This configuration includes `bookmarks.nvim` which provides **session-based temporary bookmarks**.

---

## Quick Start

### Basic Workflow

**Your scenario: Working with instruction doc + code file**

1. **Open instruction.md**, go to section A you're reading
   ```vim
   " Press Tab twice to bookmark this position
   mm
   ```
   You'll see a bookmark indicator in the sign column

2. **Open your code file**, go to the function you're implementing
   ```vim
   " Press Tab twice to bookmark
   mm
   ```

3. **Jump between bookmarks**
   ```vim
   ]b    " Jump to next bookmark (goes to code file)
   [b    " Jump to previous bookmark (goes back to doc)
   ```

4. **When done with this section**, move to the next part
   - Bookmark new positions with `mm`
   - Old bookmarks stay until you toggle them off or close Neovim

---

## All Commands

### Toggle Bookmarks

```vim
mm    " Toggle bookmark at current line
              " Press once to add, press again to remove
```

**Visual feedback:**
- Bookmark indicator appears in sign column (left side)
- Line is highlighted

### Jump Between Bookmarks

```vim
]b    " Next bookmark (jump forward)
[b    " Previous bookmark (jump backward)
```

**How it works:**
- Cycles through ALL bookmarks across ALL open buffers
- Automatically switches to the file containing the bookmark
- Perfect for instruction doc ↔ code file workflow

### View All Bookmarks

```vim
<leader>ma    " Show all bookmarks in Telescope picker
              " (Space + m + a)
```

**What you see:**
- List of all bookmarks across all files
- File path and line number
- Preview of the bookmarked line
- Navigate with `j`/`k`, press Enter to jump

### Clear Bookmarks

```vim
<leader>mc    " Clear all bookmarks in current buffer
              " (Space + m + c)
```

Useful when you finish working on a file and want to clean up.

### Annotate Bookmark (Optional)

```vim
<leader>mm    " Add description to bookmark
              " (Space + m + m)
```

Add a note like "Check this implementation" or "Reference for X"

---

## Complete Example Workflow

**Scenario:** Implementing a feature based on API documentation

### Step 1: Set Up Bookmarks

```vim
" 1. Open API doc
:e docs/api.md

" 2. Find the endpoint description (line 45)
/POST /users
" Bookmark it
mm

" 3. Find the response format (line 120)
/Response Schema
" Bookmark it
mm

" 4. Open your code file
:e src/api/users.js

" 5. Find the function you're implementing (line 30)
/createUser
" Bookmark it
mm
```

### Step 2: Work Flow

```vim
" You're in users.js, need to check endpoint URL
[b    " Jumps back to api.md line 45

" Read the URL, go back to code
]b    " Jumps to users.js line 30

" Need to check response format
]b    " Jumps to api.md line 120

" Go back to coding
]b    " Cycles back to users.js line 30
```

### Step 3: See All Bookmarks

```vim
" View all bookmarks at once
<leader>ma

" Telescope shows:
" docs/api.md:45    POST /users endpoint
" docs/api.md:120   Response Schema
" src/api/users.js:30   function createUser()

" Navigate and press Enter to jump to any
```

### Step 4: Clean Up

```vim
" When done with API doc
:e docs/api.md
<leader>mc    " Clear all bookmarks in this file

" Or toggle them off individually
mm    " On each bookmarked line
```

---

## Key Features

### Temporary by Design

Bookmarks are **session-based**:
- ✅ Exist only while Neovim is open
- ✅ Automatically cleared when you close Neovim
- ✅ Don't pollute your files with persistent marks
- ✅ Perfect for temporary workflows

### Cross-File Navigation

Unlike Vim's built-in marks (`ma`, `'a`):
- ✅ `]b` / `[b` work across ALL files
- ✅ Telescope view shows bookmarks from all files
- ✅ Visual indicators in each file

### No Limit

- Create as many bookmarks as you need
- Spread across multiple files
- Jump between them freely

---

## Comparison with Vim Built-in Marks

| Feature | Bookmarks.nvim | Vim Marks (`ma`) |
|---------|----------------|------------------|
| Toggle on/off | `mm` | Can't toggle, must delete |
| Jump next/prev | `]b` / `[b` | Need to remember mark letters |
| Cross-file jump | ✅ Yes | Only `A-Z` marks (26 max) |
| Visual list | Telescope view | `:marks` (text only) |
| Temporary | ✅ Session-based | `a-z` temporary, `A-Z` persistent |
| Annotations | ✅ Yes | ❌ No |

**When to use each:**
- **Bookmarks.nvim**: Temporary workflow, multiple positions, cross-file
- **Vim marks**: Quick single-file navigation, when you remember letters

---

## Tips

### 1. Bookmark "Reference Points"

When reading documentation:
```vim
" Bookmark the sections you need to reference frequently
mm   " On each important section

" Then code without switching windows
" Jump back when needed with ]b / [b
```

### 2. Use Telescope View for Overview

```vim
<leader>ma   " See all your bookmarked "reference points"
```

Great for "where did I bookmark that explanation?"

### 3. Strategic Bookmark Placement

Instead of bookmarking everywhere:
- Bookmark the **main reference sections** in docs
- Bookmark the **main implementation points** in code
- Keep it to 3-5 bookmarks for a clean workflow

### 4. Annotate Important Ones

```vim
mm   " Bookmark line
<leader>mm   " Add note: "API auth header format"
```

Later in Telescope view, you'll see your note!

---

## Quick Reference

| Command | Action |
|---------|--------|
| `mm` | Toggle bookmark on current line |
| `]b` | Next bookmark (all files) |
| `[b` | Previous bookmark (all files) |
| `<leader>ma` | Show all bookmarks (Telescope) |
| `<leader>mc` | Clear bookmarks in current buffer |
| `<leader>mm` | Annotate bookmark |

---

## Common Workflow Patterns

### Pattern 1: Doc + Code

```
1. Open doc, bookmark key sections
2. Open code, bookmark implementation points
3. Jump between with ]b / [b
4. When done, close Neovim (bookmarks auto-clear)
```

### Pattern 2: Multiple File Refactoring

```
1. Bookmark function definition in file A
2. Bookmark call sites in files B, C, D
3. Jump through all with ]b
4. Make changes at each location
```

### Pattern 3: Learning New Codebase

```
1. Bookmark entry points (main functions)
2. Bookmark important utility functions
3. Use <leader>ma to see your "map" of the codebase
4. Jump between to understand flow
```

---

## Troubleshooting

### Bookmark Not Showing

**Problem:** Pressed `mm` but no visual indicator

**Solution:**
- Check sign column is enabled: `:set signcolumn?` (should show `yes` or `auto`)
- Try toggling twice: `mm` `mm`
- Restart Neovim if plugin didn't load

### Can't Jump Between Bookmarks

**Problem:** `]b` / `[b` don't work

**Solution:**
- Make sure you have at least 2 bookmarks set
- Check bookmarks exist: `<leader>ma`
- Verify you're in normal mode

### Bookmarks Disappeared

**Expected:** Bookmarks are session-based
- They disappear when you close Neovim
- This is **by design** - they're meant to be temporary!
- For persistent marks, use Vim's built-in marks (`mA`, `'A`)

---

## Summary

**Perfect for:**
- Reading docs while coding
- Jumping between related code sections
- Temporary reference points during a task
- Multi-file workflows

**Key Commands:**
- `mm` - Bookmark this spot
- `]b` / `[b` - Jump between spots
- `<leader>ma` - See all spots

**Remember:** These are temporary bookmarks for your current work session. They vanish when you close Neovim, keeping your workflow clean!

---

[Back to Tutorial Index](./README.md)
