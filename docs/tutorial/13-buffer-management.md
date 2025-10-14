# Buffer Management: Closing Buffers

Learn how to close individual buffers without affecting other open buffers.

## Understanding Buffers vs Windows

- **Buffer** = A file loaded in memory
- **Window** = A viewport showing a buffer
- **Closing a window** (`:q`) doesn't delete the buffer - it stays in memory
- **Closing a buffer** (`:bd`) removes it from memory

When you have multiple buffers open, you want to close the **buffer**, not the window.

---

## Common Scenario

You've opened several files:

```vim
:ls
  1 %a   "init.lua"        line 15
  2  h   "config.lua"      line 42
  3  h   "README.md"       line 1
```

You want to close `config.lua` but keep the others open.

---

## Method 1: Close Current Buffer (Most Common)

**Command:**
```vim
:bd
```

**What it does:**
- Closes the buffer you're currently viewing
- Keeps the window open (shows the next buffer)
- Other buffers remain untouched

**Example workflow:**
1. Navigate to the buffer you want to close (using `:bn`, `:bp`, or `<leader>fb`)
2. Type `:bd` and press Enter
3. The buffer is closed, window shows the next buffer

---

## Method 2: Close Buffer by Number

**Command:**
```vim
:bd 2      " Close buffer number 2
:bd 5 7 9  " Close multiple buffers (5, 7, and 9)
```

**Steps:**
1. View buffer list: `:ls`
2. Note the buffer number you want to close
3. Type `:bd <number>`

**Example:**
```vim
:ls
  1 %a   "init.lua"        line 15
  2  h   "config.lua"      line 42  ← Want to close this
  3  h   "README.md"       line 1

:bd 2   " Closes config.lua
```

---

## Method 3: Close Buffer by Name

**Command:**
```vim
:bd config.lua
:bd init.lua
```

**Benefits:**
- Don't need to remember buffer numbers
- Tab completion works (type `:bd co` then press Tab)
- Partial paths work: `:bd lua/config` closes `lua/config/init.lua`

---

## Method 4: Close All Other Buffers (Keep Current)

**Command:**
```vim
:%bd|e#
```

**What it does:**
- `%bd` = Delete all buffers
- `|` = Then (command separator)
- `e#` = Edit the alternate buffer (brings back the current one)

**Result:** Only the buffer you're viewing remains open.

---

## Method 5: Force Close Unsaved Buffer

**Command:**
```vim
:bd!
```

**Use when:**
- Buffer has unsaved changes
- You want to discard those changes
- Normal `:bd` shows "No write since last change" error

**Warning:** This **discards unsaved changes** - use carefully!

---

## Method 6: Using Telescope (Visual Method)

**Command:**
```vim
<leader>fb
```
(Press Space, then `f`, then `b`)

**Steps:**
1. Opens Telescope buffer picker
2. Navigate to the buffer you want to close
3. Press `<C-x>` (Ctrl + x) to delete it
4. Other buffers remain open

**Benefits:**
- Visual preview of all buffers
- See file contents before closing
- Easy to navigate

---

## Quick Reference Table

| Command | Action |
|---------|--------|
| `:ls` or `:buffers` | List all buffers with numbers |
| `:bd` | Close current buffer |
| `:bd 3` | Close buffer number 3 |
| `:bd config.lua` | Close buffer by name |
| `:bd!` | Force close (discard unsaved changes) |
| `:%bd\|e#` | Close all buffers except current |
| `<leader>fb` then `<C-x>` | Close buffer via Telescope |

---

## Related Buffer Commands

### Navigate Between Buffers

```vim
:bn        " Next buffer
:bp        " Previous buffer
:b init    " Jump to buffer (tab completion works)
```

### View Buffer Information

```vim
:ls        " List all buffers
:buffers   " Same as :ls
```

### Other Buffer Operations

```vim
:bw        " Wipe buffer (removes from list completely)
:e!        " Reload buffer (discard unsaved changes)
```

---

## Common Mistake: Using `:q` Instead

**Wrong:**
```vim
:q    " Closes the window, NOT the buffer
```

**Problem:**
- The buffer stays in memory
- When you open it again later, it's still there
- Can lead to many "hidden" buffers accumulating

**Right:**
```vim
:bd   " Closes the buffer properly
```

---

## Practical Example

**Scenario:** You've opened 5 files while debugging. Now you want to clean up.

```vim
" 1. See what's open
:ls
  1 %a   "main.c"          line 50
  2  h   "utils.c"         line 10
  3  h   "test.c"          line 5
  4  h   "README.md"       line 1
  5  h   "notes.txt"       line 1

" 2. Close the test files (3 and 5)
:bd 3 5

" 3. Verify they're gone
:ls
  1 %a   "main.c"          line 50
  2  h   "utils.c"         line 10
  4  h   "README.md"       line 1

" 4. Now close README by name
:bd README.md

" 5. Left with just main.c and utils.c
```

---

## Tip: Check Before Closing

Before closing a buffer, you might want to check if it has unsaved changes:

```vim
:ls
  1 %a   "init.lua"        line 15
  2  h+  "config.lua"      line 42  ← Notice the "+"
  3  h   "README.md"       line 1
```

**The `+` means unsaved changes!**

- If you see `+`, you should either save (`:w`) or force close (`:bd!`)
- Without `+`, safe to close with `:bd`

---

## Summary

**Most Common Workflow:**
1. Open multiple files during your work
2. When done with one: `:bd` (closes current buffer)
3. Want to close a specific one: `:bd <number>` or `:bd <name>`
4. Want to clean up all but current: `:%bd|e#`

**Key Point:** Use `:bd` to close buffers, not `:q`. The `:q` command closes windows, which is different!

---

[Back to Tutorial Index](./README.md)
