# Basic Telescope Usage

Learn the essential Telescope commands and how to navigate within Telescope.

## Prerequisites

Read [What is Telescope and Search Scope](./08-telescope-what-and-scope.md) first to understand where Telescope searches.

---

## What is `<leader>`?

**In this configuration, `<leader>` is the Space bar.**

So `<leader>sf` means: **Press Space, then s, then f**

---

## The Telescope Window

When you open Telescope, you'll see three parts:

```
┌─────────────────────────────────────┐
│ > init.lua                          │ ← Input prompt (type here)
├─────────────────────────────────────┤
│ > init.lua                    3     │ ← Results list
│   README.md                   2     │
│   lua/config/options.lua      1     │
├─────────────────────────────────────┤
│ Preview of selected file            │ ← Preview window
│ ...file contents...                 │
└─────────────────────────────────────┘
```

**Three sections:**
1. **Prompt** (top) - Where you type your search
2. **Results** (middle) - Matching files/items
3. **Preview** (bottom) - Shows the selected item

---

## Essential Commands

### Remember: `<leader>` = Space bar

```
<leader>sf         Search files by name
                   → Press: Space s f

<leader>sg         Live grep (search file contents)
                   → Press: Space s g

<leader><leader>   Recent files
                   → Press: Space Space

<leader>sw         Search current word under cursor
                   → Press: Space s w

<leader>sh         Search help documentation
                   → Press: Space s h

<leader>sk         Search keymaps
                   → Press: Space s k

<leader>sd         Search diagnostics (errors/warnings)
                   → Press: Space s d

<leader>sr         Resume last search
                   → Press: Space s r

<leader>/          Search in current buffer
                   → Press: Space /
```

**Mnemonic:** Most commands start with **s** for "search"
- `sf` = search files
- `sg` = search grep
- `sw` = search word
- `sh` = search help
- `sk` = search keymaps
- `sd` = search diagnostics
- `sr` = search resume

---

## Navigation Inside Telescope

Once Telescope is open, use these keys:

### Moving Through Results

```
Ctrl-n  or  Down arrow     Next item
Ctrl-p  or  Up arrow       Previous item
Ctrl-u                     Scroll preview up
Ctrl-d                     Scroll preview down
```

### Actions

```
Enter             Open selected file
Ctrl-x            Open in horizontal split
Ctrl-v            Open in vertical split
Ctrl-t            Open in new tab

Ctrl-q            Send all results to quickfix list
Tab               Toggle selection (mark multiple items)
Shift-Tab         Deselect item

Esc  or  Ctrl-c   Close Telescope
```

---

## Your First Telescope Search

### Example 1: Find a File

```
1. Press Space s f (search files)
2. Type "init"
3. See list of matching files
4. Press Ctrl-n to move down
5. Press Enter to open selected file
```

**What happens:**
- Telescope searches all filenames in your project
- Shows matches as you type
- Preview shows file contents
- Enter opens the file

---

### Example 2: Search File Contents

```
1. Press Space s g (live grep)
2. Type "function"
3. See all lines containing "function"
4. Press Ctrl-n/Ctrl-p to browse
5. Press Enter to jump to that line
```

**What happens:**
- Telescope searches inside all files
- Shows matching lines with file names
- Preview shows surrounding code
- Enter jumps to that exact line

---

### Example 3: Open in Split

```
1. Press Space s f
2. Type "option"
3. Navigate to "options.lua" with Ctrl-n
4. Press Ctrl-v (opens in vertical split)
```

**Result:** File opens in a vertical split, keeping your current file visible!

---

## Fuzzy Matching Explained

**You don't need to type the exact name!**

### Example: Finding "config.lua"

**What you can type:**
- `config` - Straightforward
- `cfg` - Abbreviation
- `cnfg` - Missing vowels
- `conf.lua` - Partial with extension
- `lua/config` - With path

**All of these will find "config.lua"!**

### How Fuzzy Matching Works

Telescope matches characters **in order**, but they don't need to be **consecutive**.

```
Type: "rcnf"

Matches:
✓ README.md        (R...C...N...F)
✓ config.lua       (c..n..f)
✓ refactoring.lua  (R.e.c.n.f)

Does not match:
✗ file.lua         (no 'c', 'n', 'f' in order)
```

---

## Tips for Efficient Searching

### Tip 1: Use Specific Characters

**Bad:** Type "a" (too many matches)

**Good:** Type "admin" (specific)

**Better:** Type "adm" (faster to type, still specific)

---

### Tip 2: Include Path for Disambiguation

**Example:** Two files named "utils.lua"
- `src/utils.lua`
- `tests/utils.lua`

**Solution:** Include path in search
- Type `src utils` → finds only src/utils.lua
- Type `test utils` → finds only tests/utils.lua

---

### Tip 3: Case Doesn't Matter

```
Type: "readme"
Matches: README.md, readme.txt, ReadMe.md

Telescope is case-insensitive by default!
```

---

### Tip 4: Add More Characters to Narrow

**Too many results?**
```
Type: "con" (shows 20 files)
Type: "conf" (shows 5 files)
Type: "config" (shows 2 files)
```

---

## Practice Exercises

### Exercise 1: Basic Search

```
Task: Find and open init.lua

Steps:
1. Press Space s f
2. Type "init"
3. Press Enter
```

---

### Exercise 2: Navigate Results

```
Task: Browse through multiple matches

Steps:
1. Press Space s f
2. Type "lua"
3. Press Ctrl-n to go down
4. Press Ctrl-p to go up
5. Press Ctrl-u/Ctrl-d to scroll preview
6. Press Esc to close without opening
```

---

### Exercise 3: Open in Split

```
Task: Open a file in vertical split

Steps:
1. Press Space s f
2. Type any filename
3. Press Ctrl-v (vertical split)
```

**Try also:**
- Ctrl-x for horizontal split
- Ctrl-t for new tab

---

### Exercise 4: Content Search

```
Task: Find all occurrences of "telescope"

Steps:
1. Press Space s g (live grep)
2. Type "telescope"
3. See all files containing "telescope"
4. Press Enter to jump to one
```

---

### Exercise 5: Recent Files

```
Task: Quickly switch between recent files

Steps:
1. Open init.lua (Space s f, type "init", Enter)
2. Open options.lua (Space s f, type "opt", Enter)
3. Now press Space Space
4. Type "init"
5. Press Enter (instant jump!)
```

---

## Troubleshooting

### Q: Telescope isn't showing any results?

**A:** Check:
1. Are you in the right directory? (`:pwd`)
2. Is the file in your current working directory?
3. Is the file excluded by `.gitignore`?

---

### Q: Too many results showing up?

**A:** Solutions:
1. Type more specific characters
2. Include path in search
3. Use exact match (see advanced features)

---

### Q: Preview window is empty?

**A:** This usually happens when:
1. Selected item is a directory (not a file)
2. File is binary (images, etc.)
3. File is very large

---

### Q: How do I close Telescope?

**A:** Press `Esc` or `Ctrl-c`

---

## Quick Reference

```
╔════════════════════════════════════════════════════╗
║           TELESCOPE BASIC COMMANDS                 ║
╠════════════════════════════════════════════════════╣
║ OPENING TELESCOPE:                                ║
║ Space s f       Find files by name                ║
║ Space s g       Search file contents (live grep)  ║
║ Space Space     Recent files                      ║
║ Space s w       Search current word               ║
║ Space /         Search current buffer             ║
║                                                   ║
║ NAVIGATION:                                       ║
║ Ctrl-n / ↓      Next result                       ║
║ Ctrl-p / ↑      Previous result                   ║
║ Ctrl-u          Scroll preview up                 ║
║ Ctrl-d          Scroll preview down               ║
║                                                   ║
║ ACTIONS:                                          ║
║ Enter           Open file                         ║
║ Ctrl-v          Open in vertical split            ║
║ Ctrl-x          Open in horizontal split          ║
║ Ctrl-t          Open in new tab                   ║
║ Esc             Close Telescope                   ║
╚════════════════════════════════════════════════════╝
```

---

## Next Steps

Now that you know the basics:

- **[Search Modes](./08-telescope-search-modes.md)** - Detailed guide to each search type
- [Advanced Features](./08-telescope-advanced-features.md) - Filtering, quickfix, and more
- [Workflows](./08-telescope-workflows.md) - Real-world usage patterns

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
