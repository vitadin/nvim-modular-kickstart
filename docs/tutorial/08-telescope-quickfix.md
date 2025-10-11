# Using Quickfix with Telescope

Send Telescope results to quickfix list for systematic navigation through multiple locations.

## What is Quickfix?

**Quickfix** is a Vim feature that stores a list of locations (file + line number) that you can navigate through sequentially.

**Use case:** You found 20 matches and want to visit each one systematically.

---

## The Problem

**Scenario:** Live grep finds 20 TODO comments

**Without quickfix:**
```
1. Open Telescope, see TODOs
2. Press Enter on first TODO
3. Fix it
4. Press Space s g again, search "TODO"
5. Find next TODO
6. Repeat 20 times (tedious!)
```

---

## The Quickfix Solution

```
1. Space s g → Type "TODO"
2. Press Ctrl-q (send ALL results to quickfix)
3. Press Esc (close Telescope)
4. Use :cnext to cycle through each TODO
5. Fix them one by one
```

**Much faster!**

---

## How to Use Quickfix

### Step 1: Send to Quickfix

**In any Telescope search:**
```
Press Ctrl-q

→ Sends all visible results to quickfix list
→ Closes Telescope
→ Ready to navigate
```

---

### Step 2: Navigate Quickfix

**Commands:**
```
:cnext  or  :cn    Go to next item
:cprev  or  :cp    Go to previous item
:cfirst or  :cfir  Go to first item
:clast  or  :cla   Go to last item
```

---

### Step 3: View Quickfix List

```
:copen    Open quickfix window
:cclose   Close quickfix window
```

**Quickfix window shows:**
```
file1.lua|10| # TODO: Fix this
file2.lua|45| # TODO: Add tests
file3.lua|89| # TODO: Refactor
```

---

## Real Example

**Task:** Fix all TODO comments

```
1. Press Space s g
2. Type "TODO"
3. See 15 TODO comments
4. Press Ctrl-q (send to quickfix)
5. Press Esc

Now navigate:
:cn    → Jump to first TODO (file1.lua:10)
(Fix it)
:cn    → Jump to second TODO (file2.lua:45)
(Fix it)
:cn    → Jump to third TODO
... repeat for all 15
```

---

## Select Specific Items

**Don't want ALL results? Select specific ones:**

```
1. Open Telescope (any search)
2. Press Tab on items you want (marks them)
3. Press Shift-Tab to unmark
4. Press Ctrl-q (sends ONLY marked items)
```

**Example:**
```
Search results show 10 files
Tab on file 1 (mark it)
Tab on file 5 (mark it)
Tab on file 8 (mark it)
Ctrl-q → Only these 3 go to quickfix
```

---

## Common Workflows

### Workflow 1: Refactoring

**Task:** Rename `old_name` to `new_name` everywhere

```
1. Space s g → Type "old_name"
2. Ctrl-q (send to quickfix)
3. :cdo s/old_name/new_name/g | update
   (Changes all occurrences and saves)
```

**Explanation:**
- `:cdo` runs command on each quickfix item
- `s/old/new/g` replaces old_name with new_name
- `| update` saves the file

---

### Workflow 2: Review and Fix Errors

**Task:** Fix all LSP errors

```
1. Space s d (search diagnostics)
2. Ctrl-q (send to quickfix)
3. :copen (view list)
4. :cn (go to first error)
5. Fix it
6. :cn (next error)
7. Repeat until done
```

---

### Workflow 3: Remove Debug Statements

**Task:** Delete all console.log statements

```
1. Space s g → Type "console.log"
2. Ctrl-q
3. :copen (view all)
4. :cn (go to first)
5. dd (delete line)
6. :w (save)
7. :cn (next)
8. Repeat
```

---

## Tips

### Tip 1: Use Keymaps

**Add to your config for faster navigation:**
```lua
vim.keymap.set('n', ']q', ':cnext<CR>', { desc = 'Next quickfix' })
vim.keymap.set('n', '[q', ':cprev<CR>', { desc = 'Prev quickfix' })
```

Now: `]q` and `[q` to navigate!

---

### Tip 2: Close Quickfix When Done

```
:cclose

Clears the quickfix window from your screen
```

---

### Tip 3: Quickfix Persists

**The list stays until you:**
- Send new results to quickfix (replaces old list)
- Close Neovim
- Run `:call setqflist([])`  (clears list)

---

## Quickfix vs Telescope

**When to use each:**

```
╔════════════════════════════════════════════════════╗
║   Telescope           vs      Quickfix             ║
╠════════════════════════════════════════════════════╣
║ Browse results        →        Visit systematically║
║ Preview code          →        Jump and edit       ║
║ Pick one match        →        Process all matches ║
║ Fuzzy search          →        Linear navigation   ║
╚════════════════════════════════════════════════════╝
```

**Use Telescope:** When exploring or choosing one result

**Use Quickfix:** When processing multiple results systematically

---

## Practice Exercise

**Task:** Find and visit all TODOs

```
1. Create test file with 3 TODOs:
   # TODO: First
   # TODO: Second
   # TODO: Third

2. Press Space s g → Type "TODO"
3. Press Ctrl-q
4. Run :copen (see list)
5. Run :cn (first TODO)
6. Run :cn (second TODO)
7. Run :cn (third TODO)
8. Run :cclose
```

---

## Quick Reference

```
╔════════════════════════════════════════════════════╗
║            QUICKFIX COMMANDS                       ║
╠════════════════════════════════════════════════════╣
║ IN TELESCOPE:                                     ║
║ Ctrl-q          Send all to quickfix              ║
║ Tab             Mark item                         ║
║ Ctrl-q          Send marked items to quickfix     ║
║                                                   ║
║ NAVIGATION:                                       ║
║ :cnext  :cn     Next item                         ║
║ :cprev  :cp     Previous item                     ║
║ :cfirst         First item                        ║
║ :clast          Last item                         ║
║                                                   ║
║ MANAGEMENT:                                       ║
║ :copen          Open quickfix window              ║
║ :cclose         Close quickfix window             ║
║                                                   ║
║ BULK OPERATIONS:                                  ║
║ :cdo <cmd>      Run command on each item          ║
╚════════════════════════════════════════════════════╝
```

---

## Next Steps

- [Find Files](./08-telescope-find-files.md) - Basic file finding
- [Live Grep](./08-telescope-live-grep.md) - Content search
- [Recent Files](./08-telescope-recent-files.md) - Quick switching

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
