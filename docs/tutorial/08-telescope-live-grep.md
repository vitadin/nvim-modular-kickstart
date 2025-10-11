# Live Grep: Search File Contents

Search inside all files in your project to find specific text, functions, or patterns.

## Command

```
<leader>sg         Live Grep
→ Press: Space s g
```

---

## When to Use

**Use live grep when:**
- You know what text you're looking for
- You don't know which file contains it
- You want to find all occurrences across files

**Example use cases:**
- "Where is this function called?"
- "Find all TODO comments"
- "Where do I use this variable?"

---

## How It Works

```
1. Press Space s g
2. Type text to find
3. Telescope searches ALL file contents
4. See results with file names and line numbers
5. Press Enter to jump to match
```

---

## Find Files vs Live Grep

**Important difference:**

```
Find Files (Space s f):  Searches FILE NAMES
Live Grep (Space s g):   Searches FILE CONTENTS
```

**Example:**
```
You want to find where "authenticate" is used

Wrong: Space s f → Type "authenticate"
→ Only finds files named "authenticate.js"

Right: Space s g → Type "authenticate"
→ Finds all lines containing "authenticate"
```

---

## Real Examples

### Example 1: Find Function Calls

```
Space s g → Type "fetch_user"

Results:
controllers/auth.js:45  user = fetch_user(id)
models/user.js:12       def fetch_user(user_id):
tests/user_test.js:23   mock(fetch_user)
```

---

### Example 2: Find All TODOs

```
Space s g → Type "TODO"

Results:
main.lua:10      # TODO: Fix this bug
utils.lua:56     -- TODO: Optimize
handler.lua:89   // TODO: Add error handling
```

---

### Example 3: Find Import Statements

```
Space s g → Type "require 'telescope'"

Results:
init.lua:5               require 'telescope'
plugins/telescope.lua:1  require 'telescope'
```

---

## Tips for Effective Searching

### Tip 1: Be Specific

**Too broad:**
```
Space s g → Type "user"
→ 500 results (too many!)
```

**Better:**
```
Space s g → Type "user.save"
→ 15 results (manageable)
```

---

### Tip 2: Search Function Signatures

**Find where function is defined:**
```
Space s g → Type "function authenticate"
Space s g → Type "def process_data"
Space s g → Type "func HandleRequest"
```

**Finds definitions, not just calls!**

---

### Tip 3: Find Configuration Values

```
Space s g → Type "port = "
Space s g → Type "API_KEY"
Space s g → Type "DATABASE_URL"
```

---

### Tip 4: Search with Quotes

**For exact phrases:**
```
Space s g → Type "error handling"
```

---

## Common Use Cases

### Find All Error Handling

```
Space s g → Type "try"
Space s g → Type "catch"
Space s g → Type "error"
```

---

### Find All Console Logs

```
Space s g → Type "console.log"
Space s g → Type "print("
Space s g → Type "fmt.Println"
```

---

### Find All API Calls

```
Space s g → Type "fetch("
Space s g → Type "axios.get"
Space s g → Type "http.request"
```

---

### Find Variable Usage

```
Scenario: Want to see where "apiKey" is used

Space s g → Type "apiKey"
→ See all occurrences across all files
```

---

## Send Results to Quickfix

**Problem:** Found 20 occurrences, want to visit each one

**Solution:**
```
1. Space s g → Type pattern
2. See results
3. Press Ctrl-q (send to quickfix)
4. Press Esc
5. Use :cnext or :cn to cycle through each match
```

**Use case:** Refactoring - change all occurrences one by one

---

## Performance Tips

### Speed Up Search

**1. Be specific:**
```
Slow: Type "a"  (searches everything)
Fast: Type "authenticate"  (fewer matches)
```

**2. Use .gitignore:**
```
Add to .gitignore:
- node_modules/
- dist/
- build/
- __pycache__/
```

**3. Start from project root:**
```
Good: cd ~/projects/myapp && nvim
Bad:  cd ~ && nvim  (searches too much!)
```

---

## Practice Exercises

### Exercise 1: Find Function Usage

```
Task: Find where "setup" is called

Steps:
1. Press Space s g
2. Type "setup"
3. Browse results with Ctrl-n/Ctrl-p
4. Press Enter to jump to one
```

---

### Exercise 2: Find and Refactor

```
Task: Find all "old_name" and plan rename

Steps:
1. Press Space s g
2. Type "old_name"
3. Press Ctrl-q (send to quickfix)
4. Use :copen to see quickfix list
5. Plan your refactoring
```

---

### Exercise 3: Find Configuration

```
Task: Find where port number is set

Steps:
1. Press Space s g
2. Type "port ="
3. See all port configurations
4. Press Enter to open one
```

---

## Troubleshooting

### Q: Search is too slow?

**A:**
1. Add directories to `.gitignore`
2. Be more specific in your search
3. Make sure you're in project root (`:pwd`)

---

### Q: Getting too many results?

**A:**
1. Add more characters to narrow down
2. Include context: "function auth" not just "auth"
3. Use exact match with quotes

---

### Q: Not finding what I expected?

**A:**
1. Check file isn't in `.gitignore`
2. Verify you're in right directory (`:pwd`)
3. Try different search terms

---

## Quick Reference

```
╔════════════════════════════════════════════════════╗
║            LIVE GREP COMMAND                       ║
╠════════════════════════════════════════════════════╣
║ Space s g       Open live grep                    ║
║ [text]          Type text to find                 ║
║ Enter           Jump to match                     ║
║ Ctrl-q          Send to quickfix                  ║
║                                                   ║
║ PERFECT FOR:                                      ║
║ • Finding function calls                          ║
║ • Locating TODOs                                  ║
║ • Tracking variable usage                         ║
║ • Finding imports/requires                        ║
║ • Searching config values                         ║
╚════════════════════════════════════════════════════╝
```

---

## Next Steps

- [Search Current Buffer](./08-telescope-search-current-buffer.md) - Search within one file
- [Recent Files](./08-telescope-recent-files.md) - Quick file switching
- [Advanced Features](./08-telescope-advanced-features.md) - Filtering tricks

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
