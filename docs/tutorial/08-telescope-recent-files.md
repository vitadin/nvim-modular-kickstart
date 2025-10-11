# Recent Files: Fastest Navigation

Switch between recently opened files instantly - the fastest way to navigate in Neovim!

## Command

```
<leader><leader>   Recent Files
→ Press: Space Space
```

**Just press Space twice!**

---

## Why This is the Fastest

**Problem with other methods:**
```
Find Files: Space s f → Type filename → Wait → Enter
(4 steps)

Recent Files: Space Space → Type 2 letters → Enter
(2 steps, instant results!)
```

**Recent files is faster because:**
- Small list (only recent files)
- Files are sorted by recency
- Your most-used files appear first
- No searching entire project

---

## How It Works

```
1. Press Space Space
2. Type a few letters
3. Press Enter
```

**That's it!**

---

## Real Example

**Scenario:** You've recently opened:
- `init.lua`
- `options.lua`
- `keymaps.lua`

**Now you want to switch to options.lua:**

```
Press Space Space
Type "opt"
Press Enter
```

**Done in 3 keystrokes!**

---

## When to Use

**Use recent files when:**
- You're actively working on 2-5 files
- You need to switch back and forth
- You just edited a file and want to return

**Don't use for:**
- Files you haven't opened yet → Use [Find Files](./08-telescope-find-files.md)
- Searching by content → Use [Live Grep](./08-telescope-live-grep.md)

---

## Typical Workflow

**Example: Feature development**

```
1. Open controller.lua (edit)
2. Open model.lua (edit)
3. Open view.lua (edit)
4. Now need to go back to controller.lua

Traditional way:
Space s f → Type "controller" → Enter
(Slow, requires typing full name)

With recent files:
Space Space → Type "co" → Enter
(Instant!)
```

---

## The Two-File Dance

**Super common pattern:** Switching between two files

```
Editing: main.lua
Need: tests.lua

Space Space → Type "te" → Enter  (to tests.lua)
(Work on tests)
Space Space → Type "ma" → Enter  (back to main.lua)
(Work on main)
Space Space → Type "te" → Enter  (to tests again)
```

**This is THE fastest way to work on two files!**

---

## Multi-File Workflow

**Working on a feature across 4 files:**

```
Files in order:
1. controller.lua (most recent)
2. model.lua
3. view.lua
4. test.lua (least recent)

To jump to any:
Space Space → Shows all 4 at top of list
Type 2 letters to select
Press Enter
```

---

## Tips for Maximum Speed

### Tip 1: Open Files You'll Need

**At start of coding session:**
```
1. Open controller.lua
2. Open model.lua
3. Open view.lua
4. Now all three are in recent files
5. Use Space Space to jump between them all day!
```

---

### Tip 2: Use Minimal Characters

**You only need 2-3 letters:**
```
"options.lua" → Type "op"
"controller.lua" → Type "co"
"test.lua" → Type "te"
```

---

### Tip 3: Recent = Top of List

**Telescope orders by recency:**
```
Most recently used → Appears first
Least recently used → Appears last
```

**This means your active files are always at the top!**

---

### Tip 4: Combine with Leap

**Once file is open:**
```
1. Space Space → Open file
2. s (Leap) → Jump to exact location
```

**Perfect combo for speed!**

---

## Practice Exercises

### Exercise 1: Basic Switch

```
Task: Switch between two files

Steps:
1. Open init.lua (Space s f → "init" → Enter)
2. Open options.lua (Space s f → "opt" → Enter)
3. Now press Space Space
4. Type "init"
5. Press Enter (back to init.lua!)
```

---

### Exercise 2: Multi-File Navigation

```
Task: Open 3 files and navigate between them

Steps:
1. Open file1.lua
2. Open file2.lua
3. Open file3.lua
4. Press Space Space (see all 3 at top)
5. Type letters to select any
6. Press Enter
```

---

### Exercise 3: Speed Run

```
Task: How fast can you switch files?

Steps:
1. Have 2 files open
2. Time yourself: Space Space → 2 letters → Enter
3. Try to do it in under 1 second!
```

---

## Troubleshooting

### Q: File doesn't appear in recent files?

**A:** You haven't opened it in this session. Use [Find Files](./08-telescope-find-files.md) first:
```
Space s f → Find and open file
Now it's in recent files list!
```

---

### Q: List is too long?

**A:** Recent files shows ALL files you've opened. Type more letters to narrow:
```
Type: "c"    (10 results)
Type: "co"   (3 results)
Type: "con"  (1 result)
```

---

### Q: Want to clear recent files list?

**A:** Restart Neovim - recent files list is per-session.

---

## Workflow Patterns

### Pattern 1: Test-Driven Development

```
Space Space → Type "te" → tests.lua
(Write test)
Space Space → Type "ma" → main.lua
(Write code)
Space Space → Type "te" → tests.lua
(Run test)
Repeat!
```

---

### Pattern 2: Front and Back End

```
Space Space → Type "ap" → api.js
(Update API)
Space Space → Type "co" → component.tsx
(Update UI)
Space Space → Type "ap" → api.js
(Check API)
```

---

### Pattern 3: Code and Documentation

```
Space Space → Type "cod" → code.lua
(Write code)
Space Space → Type "doc" → README.md
(Document it)
```

---

## Quick Reference

```
╔════════════════════════════════════════════════════╗
║           RECENT FILES COMMAND                     ║
╠════════════════════════════════════════════════════╣
║ Space Space     Open recent files                 ║
║ [2-3 letters]   Type to narrow                    ║
║ Enter           Open file                         ║
║                                                   ║
║ WHY IT'S FAST:                                    ║
║ • Small list (only recent)                        ║
║ • Sorted by recency                               ║
║ • Most-used files first                           ║
║ • No project-wide search                          ║
║                                                   ║
║ PERFECT FOR:                                      ║
║ • Switching between active files                  ║
║ • Two-file workflows                              ║
║ • Multi-file feature development                  ║
╚════════════════════════════════════════════════════╝
```

---

## Next Steps

- [Find Files](./08-telescope-find-files.md) - When file isn't recent
- [Search Current Buffer](./08-telescope-search-current-buffer.md) - Search within file
- [Workflows](./08-telescope-workflows.md) - Combined usage patterns

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
