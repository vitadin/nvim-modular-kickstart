# Find Files by Name

Search for files by their filename using Telescope - the fastest way to open files in your project.

## Command

```
<leader>sf         Search Files
→ Press: Space s f
```

**Remember:** `<leader>` = Space bar

---

## When to Use

**Use find files when:**
- You know the filename (or part of it)
- You want to open a specific file quickly
- You're navigating by file structure

**Don't use for:**
- Searching file contents → Use [Live Grep](./08-telescope-live-grep.md) instead

---

## How It Works

```
1. Press Space s f
2. Type part of the filename
3. See list of matching files
4. Press Enter to open
```

**Example:**
```
Type: "init"
Results:
→ init.lua
→ initialize.js
→ __init__.py
```

---

## Fuzzy Matching

**You don't need exact names!**

### Finding "config.lua"

```
Type: "config"    ✓ Works
Type: "cfg"       ✓ Works (abbreviation)
Type: "cnfg"      ✓ Works (missing vowels)
Type: "conf.lua"  ✓ Works (with extension)
Type: "cnf"       ✓ Works (even shorter)
```

### Finding "src/components/Button.tsx"

```
Type: "button"      ✓ Finds it
Type: "btn"         ✓ Finds it
Type: "comp button" ✓ Finds it (includes path)
Type: "src btn"     ✓ Finds it (path + filename)
```

**Key insight:** Characters match **in order** but don't need to be consecutive!

---

## Tips for Fast File Finding

### Tip 1: Use Distinctive Characters

**Slower:**
```
Type: "a"  (too many matches)
→ Shows 50 files
```

**Faster:**
```
Type: "admin"  (specific)
→ Shows 3 files
```

---

### Tip 2: Include Path for Disambiguation

**Problem:** Two files named "utils.lua"
- `src/utils.lua`
- `tests/utils.lua`

**Solution:**
```
Type: "src utils"   → Finds only src/utils.lua
Type: "test utils"  → Finds only tests/utils.lua
```

---

### Tip 3: Type Less, Not More

**Good enough:**
```
Type: "opt"  → Finds options.lua
```

**Unnecessary:**
```
Type: "options.lua"  → Same result, more typing
```

---

### Tip 4: Case Doesn't Matter

```
Type: "readme"
Matches: README.md, readme.txt, ReadMe.md

Telescope is case-insensitive!
```

---

## Common Patterns

### Finding Config Files

```
Space s f → Type "config"

Finds:
- config.lua
- .eslintrc.json (if named "config")
- database.config.js
```

---

### Finding Test Files

```
Space s f → Type "test"

Finds:
- test_user.lua
- user.test.js
- spec/user_spec.rb
```

---

### Finding by Extension

```
Space s f → Type ".md"

Finds all Markdown files:
- README.md
- CHANGELOG.md
- docs/tutorial.md
```

---

## Opening Files in Different Ways

### Open in Current Window

```
Press Enter
```

---

### Open in Split

```
Press Ctrl-v    (vertical split)
Press Ctrl-x    (horizontal split)
```

---

### Open in New Tab

```
Press Ctrl-t
```

---

## Practice Exercises

### Exercise 1: Basic Find

```
Task: Find and open init.lua

Steps:
1. Press Space s f
2. Type "init"
3. Press Enter
```

---

### Exercise 2: Fuzzy Match

```
Task: Find "README.md" by typing only "rdm"

Steps:
1. Press Space s f
2. Type "rdm"
3. Verify README.md appears
4. Press Enter
```

---

### Exercise 3: Path Include

```
Task: Find a file in the "lua" directory

Steps:
1. Press Space s f
2. Type "lua" then the filename
3. Example: "lua options"
4. Press Enter
```

---

## Troubleshooting

### Q: File doesn't appear in results?

**A:** Check:
1. Is the file in your current working directory? (`:pwd`)
2. Is it excluded by `.gitignore`?
3. Did you spell it correctly?

---

### Q: Too many results?

**A:** Type more characters:
```
Type: "u"      (100 results)
Type: "ut"     (20 results)
Type: "util"   (5 results)
```

---

### Q: Want to search only certain file types?

**A:** Include extension:
```
Type: ".lua"     (all Lua files)
Type: ".ts"      (all TypeScript files)
Type: "test.js"  (all JavaScript test files)
```

---

## Quick Reference

```
╔════════════════════════════════════════════════════╗
║              FIND FILES COMMAND                    ║
╠════════════════════════════════════════════════════╣
║ Space s f       Open find files                   ║
║ [filename]      Type (partial) filename           ║
║ Enter           Open in current window            ║
║ Ctrl-v          Open in vertical split            ║
║ Ctrl-x          Open in horizontal split          ║
║ Ctrl-t          Open in new tab                   ║
║                                                   ║
║ TIPS:                                             ║
║ • Fuzzy matching - don't need exact name          ║
║ • Case insensitive                                ║
║ • Include path to disambiguate                    ║
║ • Type less - "opt" finds "options.lua"           ║
╚════════════════════════════════════════════════════╝
```

---

## Next Steps

- [Live Grep](./08-telescope-live-grep.md) - Search file contents
- [Recent Files](./08-telescope-recent-files.md) - Fastest navigation
- [Advanced Features](./08-telescope-advanced-features.md) - Filtering tricks

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
