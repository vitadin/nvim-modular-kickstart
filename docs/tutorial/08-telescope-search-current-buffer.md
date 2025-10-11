# Search in Current Buffer with Telescope

Learn how to see all matches at once in your current file - like search with automatic folding!

## Prerequisites

Read [Basic Telescope Usage](./08-telescope-basic-usage.md) first.

---

## The Problem with Traditional Search

**Traditional `/` search in Vim:**
```
Type /pattern<Enter>
→ See first match
→ Press n to go to next match
→ Press n again... and again...
→ Can only see ONE match at a time
→ Easy to miss matches
```

---

## The Telescope Solution

**Press `Space /` (search in current buffer):**
```
Type pattern
→ See ALL matches instantly
→ Navigate with j/k
→ Preview shows context
→ Gapped lines are hidden (like folding!)
→ Jump to any match with Enter
```

---

## How to Use It

**Steps:**
```
1. Open any file
2. Press Space /
3. Type your search pattern
4. See all matching lines at once
5. Use j/k to browse
6. Press Enter to jump to one
```

---

## Real Example

**Scenario:** You have a 500-line file with "TODO" comments

**File contents:**
```
Line 10:  # TODO: Fix this bug
Line 45:  # TODO: Add error handling
Line 120: # TODO: Refactor this
Line 300: # TODO: Optimize query
Line 450: # TODO: Write tests
```

### Traditional Way (Slow)

```
1. Type /TODO<Enter>
2. At line 10, press n → line 45
3. Press n → line 120
4. Press n → line 300
5. Press n → line 450
(Takes time, easy to lose track)
```

### Telescope Way (Fast)

```
1. Press Space /
2. Type "TODO"
3. Instantly see:
   ┌────────────────────────────┐
   │  10: # TODO: Fix this      │
   │  45: # TODO: Add tests     │
   │ 120: # TODO: Refactor      │
   │ 300: # TODO: Optimize      │
   │ 450: # TODO: Document      │
   └────────────────────────────┘
4. Lines 11-44, 46-119, etc. are HIDDEN!
5. Navigate with j/k, Enter to jump
```

**Result:** See all 5 TODOs at once!

---

## Why This is Powerful

### See Everything at Once

No more cycling through `n/n/n` - you get an overview instantly.

### Gapped Lines Hidden

Only matching lines are shown - everything else is hidden like folding!

```
Your file:                Telescope shows:
─────────────────        ─────────────────
1: import foo             10: # TODO: Fix
2: import bar             45: # TODO: Test
3: ...                    120: # TODO: Refactor
10: # TODO: Fix           300: # TODO: Optimize
11: code                  450: # TODO: Document
...
45: # TODO: Test
(lines 11-44 hidden!)
```

### Preview Context

Before jumping, preview shows surrounding code:

```
Selected: 120: # TODO: Refactor

Preview shows:
118:   def process():
119:       data = fetch()
120:       # TODO: Refactor this
121:       result = transform(data)
122:       return result
```

---

## Common Use Cases

### Find All TODO Comments

```
Space / → Type "TODO"
```

Shows all TODOs with line numbers!

---

### See All Function Definitions

```
Space / → Type "def " (Python)
Space / → Type "function" (JavaScript)
Space / → Type "func " (Go)
```

Get overview of all functions in the file!

---

### Locate All Return Statements

```
Space / → Type "return"
```

See all exit points in your function!

---

### Find All Error Handling

```
Space / → Type "try"
Space / → Type "catch"
Space / → Type "error"
```

---

### Review All Imports

```
Space / → Type "import"
Space / → Type "require"
Space / → Type "from "
```

See all dependencies at once!

---

### Find Console Logs

```
Space / → Type "console.log"
Space / → Type "print("
Space / → Type "fmt.Println"
```

Clean up debug statements!

---

## Advantages Over Traditional Search

```
╔════════════════════════════════════════════════════╗
║   Traditional /search    vs   Telescope Space /   ║
╠════════════════════════════════════════════════════╣
║ See one match at a time     See all matches       ║
║ Cycle with n/n/n            Navigate with j/k     ║
║ No overview                 Instant overview      ║
║ All lines visible           Only matches visible  ║
║ Jump directly               Preview before jump   ║
║ Exact match only            Fuzzy matching        ║
╚════════════════════════════════════════════════════╝
```

---

## Tips

### Tip 1: Use for Long Files

**When file is over 200 lines, use `Space /` instead of `/`**

You'll save time and get better overview!

---

### Tip 2: Combine with Pattern

```
Space / → Type "function.*export"

Finds: function foo() export
       function bar() export
```

Uses regex patterns!

---

### Tip 3: Quick Count

Want to know how many times something appears?

```
Space / → Type pattern
Count the results shown!
```

---

## Practice Exercise

**Task:** Find all TODO comments in your config

```
1. Open any file with TODOs (or create some)
2. Press Space /
3. Type "TODO"
4. See all at once
5. Navigate with j/k
6. Press Enter to jump to one
```

---

## Workflow Example

**Scenario:** Cleaning up debug statements

```
1. Open file.js
2. Press Space /
3. Type "console.log"
4. See all 7 console.log statements
5. Navigate to first one
6. Press Enter (jumps to line)
7. Delete the line (dd)
8. Press Space / again
9. Repeat for remaining logs
```

**Result:** Efficiently remove all debug code!

---

## Quick Reference

```
╔════════════════════════════════════════════════════╗
║       SEARCH CURRENT BUFFER                        ║
╠════════════════════════════════════════════════════╣
║ Space /         Open current buffer search        ║
║ [pattern]       Type what to find                 ║
║ j/k             Navigate results                  ║
║ Enter           Jump to selected line             ║
║ Ctrl-u/Ctrl-d   Scroll preview                    ║
║ Esc             Close                             ║
║                                                   ║
║ PERFECT FOR:                                      ║
║ • Finding all TODOs                               ║
║ • Seeing all function definitions                 ║
║ • Locating all returns/errors                     ║
║ • Reviewing all imports                           ║
║ • Finding debug statements                        ║
╚════════════════════════════════════════════════════╝
```

---

## Next Steps

- [Other Search Modes](./08-telescope-search-modes.md) - Learn other search types
- [Advanced Features](./08-telescope-advanced-features.md) - Filtering and quickfix

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
