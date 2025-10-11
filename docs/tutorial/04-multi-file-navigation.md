# Multi-File Navigation

How to efficiently jump back and forth between multiple files in Neovim.

## Table of Contents

- [The Problem](#the-problem)
- [Solution 1: Jump List](#solution-1-jump-list)
- [Solution 2: Buffer Navigation](#solution-2-buffer-navigation)
- [Solution 3: Telescope](#solution-3-telescope)
- [Solution 4: Marks](#solution-4-marks)
- [Solution 5: Bookmarks Plugin](#solution-5-bookmarks-plugin)
- [Best Practices](#best-practices)

---

## The Problem

You're editing multiple files and need to:
- Jump back to where you were before
- Switch between specific files quickly
- Navigate through recently opened files
- Remember important locations across files

---

## Solution 1: Jump List

**Best for:** Going back to previous locations (even across files)

### Commands

```
Ctrl-o    - Jump to previous location in jump list
Ctrl-i    - Jump to next location in jump list (forward)
```

### How It Works

Neovim automatically tracks every jump you make (motions like `gg`, `G`,
search, etc.). Use `Ctrl-o` to go back and `Ctrl-i` to go forward.

### Example Workflow

```
1. Edit file1.lua at line 50
2. Open file2.lua and jump to line 100
3. Open file3.lua
4. Press Ctrl-o → back to file2.lua:100
5. Press Ctrl-o → back to file1.lua:50
6. Press Ctrl-i → forward to file2.lua:100
```

### View Your Jump List

```vim
:jumps
```

This shows you a numbered list of all your jumps:

```
 jump line  col file/text
   3    45    0 lua/config/options.lua
   2   100   10 lua/plugins/lsp/init.lua
   1    20    5 init.lua
>  0    15    0 lua/config/keymaps.lua
   1    50   12 README.md
```

**Understanding the output:**
- `>` marks your current position (jump 0)
- Negative numbers are older jumps (press `Ctrl-o` to go back)
- Positive numbers are forward jumps (press `Ctrl-i` to go forward)
- Shows line number, column, and filename

### How to Jump to a Specific Entry

You **cannot** jump directly to a specific entry in the list. Instead:

**Option 1: Press `Ctrl-o` multiple times**
```
:jumps shows you're at position 0
Want to go to jump 3 (3 positions back)?
Press Ctrl-o three times
```

**Option 2: Use count with `Ctrl-o`**
```
3 Ctrl-o    - Jump back 3 positions
5 Ctrl-i    - Jump forward 5 positions
```

**Example:**
```
1. Run :jumps and see you're at position 0
2. See lua/config/options.lua is at jump 3
3. Press 3 followed by Ctrl-o
4. You're now at lua/config/options.lua
```

### Tips

- Jumps are NOT recorded for motions like `h`, `j`, `k`, `l`
- Great for "I just need to go back to where I was"
- Works across buffers automatically
- The jump list has a maximum size (default 100 entries)
- Use `:clearjumps` to clear the jump list if it gets cluttered

---

## Solution 2: Buffer Navigation

**Best for:** Cycling through open files

### Commands

This configuration includes these buffer commands:

```
:bnext or :bn     - Next buffer
:bprev or :bp     - Previous buffer
:buffer N or :b N - Jump to buffer number N
:ls or :buffers   - List all buffers
```

### Recommended Keymaps

Add these to `lua/config/keymaps.lua`:

```lua
-- Buffer navigation
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>',
	{ desc = 'Previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>',
	{ desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>',
	{ desc = 'Delete buffer' })
```

### Example Workflow

```
1. Open multiple files: nvim file1.lua file2.lua file3.lua
2. :ls to see all buffers
3. ]b to cycle forward through buffers
4. [b to cycle backward
5. :b 2 to jump directly to buffer 2
```

### Tips

- Buffers stay loaded even when not visible
- Use `:ls` to see buffer numbers
- Hidden buffers (not shown in windows) marked with 'h'

---

## Solution 3: Telescope

**Best for:** Fuzzy finding files and recent files

### What is `<leader>`?

The **leader key** is a special prefix key for custom shortcuts in Neovim.

**In this configuration, `<leader>` is the Space bar.**

So when you see:
- `<leader>sf` → Press **Space** then **s** then **f**
- `<leader>sg` → Press **Space** then **s** then **g**
- `<leader><leader>` → Press **Space** twice

Think of Space as your "command mode" key - press it first, then type the
command you want.

### Commands (This Configuration)

```
<leader>sf         - Search files (find by name)
                     → Press: Space s f

<leader>sg         - Live grep (find by content)
                     → Press: Space s g

<leader>sk         - Search keymaps
                     → Press: Space s k

<leader>sh         - Search help
                     → Press: Space s h

<leader><leader>   - Find recent files
                     → Press: Space Space
```

**Mnemonic:** Most commands start with **s** for "search", followed by what
you're searching for (f=files, g=grep, k=keymaps, h=help).

### Find Recent Files

This is the FASTEST way to jump between recently edited files:

```
1. Press <Space><Space> (leader twice)
2. Type a few characters of the filename
3. Press Enter
```

### Find Any File

```
1. Press <Space>sf (search files)
2. Type part of filename
3. Use Ctrl-n/Ctrl-p or arrow keys to navigate
4. Press Enter to open
```

### Search File Content

```
1. Press <Space>sg (live grep)
2. Type what you're looking for
3. Navigate results and press Enter
```

### Telescope Navigation Keys

While in Telescope:
```
Ctrl-n / Down   - Next item
Ctrl-p / Up     - Previous item
Ctrl-u          - Scroll preview up
Ctrl-d          - Scroll preview down
Ctrl-q          - Send to quickfix list
Esc             - Close telescope
```

---

## Solution 4: Marks

**Best for:** Remembering specific locations you'll return to

### Commands

```
m{a-z}    - Set mark (lowercase = local to file)
m{A-Z}    - Set mark (uppercase = global across files)
'{mark}   - Jump to mark (line)
`{mark}   - Jump to mark (exact position)
:marks    - List all marks
```

### Example Workflow

```
1. In file1.lua, line 50: Press mA (global mark A)
2. In file2.lua, line 100: Press mB (global mark B)
3. Open file3.lua
4. Press 'A → jumps to file1.lua:50
5. Press 'B → jumps to file2.lua:100
```

### Special Marks

```
''    - Jump back to position before last jump
'.    - Jump to last change
'^    - Jump to last insert position
```

### Tips

- Use **capital letters** (A-Z) for global marks across files
- Use **lowercase letters** (a-z) for marks within a file
- Marks persist across sessions (with undofile enabled)

---

## Solution 5: Bookmarks Plugin

**Best for:** Visual bookmark management with descriptions

This configuration includes the `bookmarks.nvim` plugin.

### Commands

```
<tab><tab>           - Toggle bookmark at current line
:Telescope bookmarks - View all bookmarks
```

### Features

- Visual indicators in the gutter
- Telescope integration for quick navigation
- Persistent bookmarks

### Example Workflow

```
1. In important function: Press <tab><tab> to bookmark
2. Go to another file and bookmark another location
3. Press <Space> then type "bookmarks"
4. Select from list to jump to bookmarked location
```

---

## Best Practices

### Choose the Right Tool

**Just went somewhere and need to go back?**
→ Use `Ctrl-o` (jump list)

**Cycling through 2-3 open files?**
→ Use `]b` / `[b` (buffer navigation)

**Know the filename?**
→ Use `<Space><Space>` (recent files) or `<Space>sf` (find files)

**Know the content?**
→ Use `<Space>sg` (live grep)

**Important location you'll return to often?**
→ Use global marks (`mA`, `mB`, etc.) or bookmarks (`<tab><tab>`)

### Combining Techniques

Most efficient workflow:
1. Use **marks** for important locations
2. Use **Ctrl-o/Ctrl-i** for recent navigation
3. Use **Telescope** for file switching
4. Use **bookmarks** for long-term reference points

### Example Real-World Workflow

Scenario: Working on a feature across 3 files

```
1. Open main.lua, find the entry point → Press mM (mark M for Main)
2. Open utils.lua, find helper function → Press mU (mark U for Utils)
3. Open config.lua, find settings → Press mC (mark C for Config)

Now you can:
- 'M to jump to main.lua
- 'U to jump to utils.lua
- 'C to jump to config.lua

While working:
- Ctrl-o to go back after exploring
- <Space><Space> to switch between these files quickly
- <tab><tab> to bookmark specific lines for later
```

---

## Practice Exercises

### Exercise 1: Jump List

1. Open this configuration's `init.lua`
2. Jump to line 1 with `gg`
3. Jump to line 37 with `:37` or `37G`
4. Open `lua/config/options.lua` with `:e lua/config/options.lua`
5. Press `Ctrl-o` three times - where do you end up?

### Exercise 2: Marks

1. Open `lua/config/keymaps.lua` and set mark K with `mK`
2. Open `lua/config/options.lua` and set mark O with `mO`
3. Open any other file
4. Press `'K` - did you jump to keymaps.lua?
5. Press `'O` - did you jump to options.lua?

### Exercise 3: Telescope

1. Press `<Space><Space>`
2. Type "keymap"
3. Select the file
4. Press `<Space><Space>` again - notice keymaps.lua is now at the top?

### Exercise 4: Combined Workflow

1. Open `init.lua` and mark it with `mI`
2. Use `<Space>sf` to find and open `telescope.lua`
3. Mark it with `mT`
4. Use `<Space>sg` to search for "leader"
5. Jump to any result
6. Use `Ctrl-o` to go back
7. Use `'I` to return to init.lua
8. Use `'T` to return to telescope.lua

---

## Advanced Tips

### Split Windows

Work with multiple files visible:

```
:split filename   or  :sp filename   - Horizontal split
:vsplit filename  or  :vsp filename  - Vertical split
Ctrl-w h/j/k/l    - Navigate between splits
Ctrl-w w          - Cycle through splits
```

### Tab Pages

Group related files:

```
:tabnew filename  - Open in new tab
gt                - Next tab
gT                - Previous tab
:tabs             - List all tabs
```

### Change List

Like jump list, but only for edit locations:

```
g;    - Go to previous change location
g,    - Go to next change location
```

---

## Troubleshooting

**Q: Ctrl-o doesn't seem to work?**
A: Make sure you've made a "jump" (gg, G, search, etc.), not just movement
   (hjkl)

**Q: Lost track of my buffers?**
A: Run `:ls` to see all open buffers and their numbers

**Q: Mark disappeared?**
A: Lowercase marks (a-z) are file-local. Use uppercase (A-Z) for global marks.

**Q: Too many buffers open?**
A: Close buffers with `:bd` (buffer delete) or `<leader>bd` if you set the keymap

---

## See Also

- [LSP Features](./06-lsp-features.md) - Go to definition/references
- [Telescope Mastery](./08-telescope-mastery.md) - Advanced telescope usage
- [Basic Navigation](./01-basic-navigation.md) - Single-file movement

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
