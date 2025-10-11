# Advanced Leap Techniques

Power user tips, tricks, and advanced techniques for mastering Leap.nvim.

## Prerequisites

Complete these first:
- [What is Leap?](./01-leap-what-and-why.md)
- [Basic Usage](./01-leap-basic-usage.md)
- [Common Workflows](./01-leap-common-workflows.md)

---

## Advanced Technique 1: Handling Ambiguous Targets

**Problem:** Multiple identical 2-character sequences

```
test test test test test test
```

When you type `s` + `te`, there are too many matches!

### Solution: Special Keys

After typing 2 characters, use:
- `<Enter>` - Jump to next occurrence
- `<Tab>` - Jump to previous occurrence
- `<Space>` - Show next group of labels

**Example:**
```
1. Press s
2. Type te
3. See labels: a, b, c, d, e, f (only 6 shown)
4. Press <Space> to see next batch: g, h, i, j, k, l
5. Keep pressing <Space> to cycle through all matches
```

---

## Advanced Technique 2: Understanding Label Priority

**What you'll notice:** Leap shows labels in a specific order

```
Labels appear in this order: s, f, n, j, k, l, h, o, d, w, e, i, m, b, u, y...
```

**Why this matters:** These are **home row keys**!

### Label Priority Strategy

**Fastest labels** (home row):
```
s f j k l h
```

**Your target often gets one of these**, making it faster to type.

**Middle-fast labels:**
```
d n e i o
```

**Slower labels** (farther from home row):
```
u y m b v
```

**Pro tip:** Targets closer to your cursor typically get better (faster) labels.

---

## Advanced Technique 3: Repeating with Dot

**Leap motions are repeatable with the dot (`.`) command!**

### Example: Delete Multiple Function Calls

```javascript
logger.debug("Starting process");
// ... code ...
logger.debug("Validating input");
// ... code ...
logger.debug("Processing data");
```

**Want to delete all logger.debug lines?**

**Steps:**
1. Press `s`, type `lo`, jump to first "logger"
2. Press `dd` (delete line)
3. Press `s`, type `lo`, jump to next "logger"
4. Press `.` (dot) → Repeats the `dd` action!
5. Repeat step 3-4 for remaining lines

**Magic:** The dot command repeats both the leap AND the action!

---

## Advanced Technique 4: Visual Mode Leap for Complex Selections

### Select Multi-Line Blocks

```python
def process_user(user):
    # Start selection here
    validated = validate_user(user)
    transformed = transform_data(validated)
    saved = save_to_db(transformed)
    # End selection here
    return saved
```

**Want to select from "validated" to "saved"?**

**Steps:**
1. Position cursor at "validated"
2. Press `v` (visual mode)
3. Press `s` (leap forward)
4. Type `sa` (for "saved")
5. Press label
6. Entire block is selected!
7. Press `d` to delete, `y` to copy, or `c` to change

### Visual Block Mode + Leap

**Advanced:** Use `<C-v>` (visual block) + Leap for column operations

```
name     = "John"
email    = "john@example.com"
password = "secret"
```

**Want to select the values column?**

**Steps:**
1. Position on first `"`
2. Press `<C-v>` (visual block)
3. Press `s`, type `se` (for "secret"), jump
4. Press `$` to extend to end of lines
5. Now you have a column selected!

---

## Advanced Technique 5: Case Insensitive Matching

**Leap is case insensitive by default** (in this config)

```javascript
Function MyFunction FUNCTION myfunction
```

Typing `s` + `fu` will match **all** of these:
- `Function`
- `MyFunction` (the "Fu" part)
- `FUNCTION`
- `myfunction`

**Use case:** Don't worry about capitalization when leaping!

---

## Advanced Technique 6: Leap in Operator-Pending Mode

**Powerful concept:** Leap becomes a motion when used after an operator

### Understanding Operator-Pending Mode

When you press `d`, `c`, `y`, or `v`, Vim waits for a motion. Leap can be that motion!

**Pattern:**
```
[operator] + [leap command] + [2 chars] + [label] = precise operation
```

### Advanced Examples

**Example 1: Change from here to target (inclusive)**
```lua
local function calculate()
  local result = compute_value()
  return result
end
```

Position at "compute", want to change up to and including "return":
```
c + s + re + label + type new text
```

**Example 2: Indent from here to target**
```python
def process():
    step1()
    step2()
    step3()
```

Want to indent from step1 to step3:
```
> + s + st + label (for "step3")
```

**Example 3: Format from here to target** (if you have formatter)
```
= + s + chars + label
```

---

## Advanced Technique 7: Leaping to Specific Characters

### Target Special Characters

```javascript
const data = { name: "John", age: 30, city: "NYC" };
```

**Want to jump to the third comma?**

**Steps:**
1. Press `s`
2. Type `, ` (comma + space)
3. Labels appear on all ", " occurrences
4. Press label for third one

**Works with any character:**
- `s` + `{` + ` ` = Jump to opening braces
- `s` + `=` + ` ` = Jump to assignment operators
- `s` + `->` = Jump to arrows (in languages that use them)

---

## Advanced Technique 8: Leap + Macros

**Ultra powerful:** Combine Leap with Vim macros for repetitive tasks

### Example: Rename Multiple Variables

```lua
local test_var = 1
local test_result = compute()
local test_final = process()
```

**Want to rename all "test_" to "prod_"?**

**Steps:**
1. Press `qa` (start recording macro in register a)
2. Press `s`, type `te`, jump to first "test_"
3. Press `cw`, type "prod_", press `<Esc>`
4. Press `q` (stop recording)
5. Press `@a` to run macro → jumps and renames next "test_"
6. Press `@@` to repeat → keeps going!

**Result:** All "test_" prefixes changed to "prod_" with minimal effort!

---

## Advanced Technique 9: Multi-Window Leap Strategies

### Strategy 1: Jump to Window and Position

```
┌──────────────┬──────────────┐
│ File A       │ File B       │
│ function foo │ function bar │
│ ...          │ ...          │
└──────────────┴──────────────┘
```

**Want to jump to "bar" in File B?**

**Traditional:** `<C-w>l` (switch window) + `/bar` (search)

**With Leap:** `gs` + `ba` + label (one command!)

### Strategy 2: Leap as Window Navigation

**Pro tip:** Use `gs` as your primary window navigation method!

**Instead of:**
- `<C-w>h` (left)
- `<C-w>j` (down)
- `<C-w>k` (up)
- `<C-w>l` (right)

**Use:**
- `gs` + [2 chars in target window] + label

**Advantage:** Jump to exact position in window, not just the window!

---

## Advanced Technique 10: Leap + Tree-sitter

**Note:** This config uses Tree-sitter for syntax highlighting

**Power combo:** Leap to syntax elements

```javascript
class UserController {
  constructor() {...}

  async fetchUsers() {...}

  async createUser(data) {...}
}
```

**Want to jump to method definitions?**

**Strategy:** Leap to unique parts of method syntax
- `s` + `as` + label = Jump to `async` keywords
- `s` + `co` + label = Jump to `constructor`
- `s` + `cr` + label = Jump to `createUser`

**Advantage:** Navigate by code structure, not just text!

---

## Performance Tips

### Tip 1: Minimize Label Choices

**The fewer labels shown, the faster you can jump.**

**How:** Type more specific 2-character patterns
- Instead of `s` + `te` (many matches)
- Use `s` + `es` (middle of "test" - fewer matches)

### Tip 2: Learn Home Row Labels

**Practice recognizing these instantly:**
```
s f n j k l h
```

**These appear most often**, so memorizing their keyboard positions speeds you up.

### Tip 3: Use Leap for Far Jumps Only

**Optimal strategy:**
- 0-3 words away → Use `w/e/b`
- 3-10 words away → Use Leap
- 10+ words away → Definitely use Leap

**Why:** Small jumps with `w` are faster than activating Leap.

---

## Troubleshooting Advanced Scenarios

### Q: Leap shows too many labels and I can't find mine?

**A:** Solutions:
1. Type a 3rd character to narrow down
2. Use `<Space>` to cycle to next group of labels
3. Choose more unique 2-character pattern

---

### Q: Can I leap to something across folds?

**A:** Yes! Leap searches all visible lines, even folded ones.

**But:** You can't leap to text inside a closed fold. Open the fold first.

---

### Q: Leap conflicts with my 's' for substitute?

**A:** This config maps `s` to Leap. If you need substitute:
- Use `cl` (change letter) instead of `s`
- Or remap Leap in `lua/plugins/editor/leap.lua`

---

### Q: Can I leap to text in a terminal buffer?

**A:** Yes! Leap works in terminal buffers.

**Use case:** Jump to specific output in terminal without using mouse.

---

## Power User Summary

**You've mastered Leap when:**
- ✅ You instinctively press `s` instead of counting lines
- ✅ You combine Leap with operators (`d`, `c`, `y`, `v`) automatically
- ✅ You use `gs` as your primary window navigation
- ✅ You can leap to targets without thinking about labels
- ✅ You repeat leap actions with `.` (dot) for efficiency
- ✅ You record macros with Leap for repetitive refactoring

---

## Quick Reference: All Advanced Commands

```
╔════════════════════════════════════════════════════════╗
║             LEAP ADVANCED REFERENCE                    ║
╠════════════════════════════════════════════════════════╣
║ AFTER TYPING 2 CHARS:                                 ║
║ <Enter>         Jump to next match                    ║
║ <Tab>           Jump to previous match                ║
║ <Space>         Show next group of labels             ║
║                                                       ║
║ REPEATING:                                            ║
║ .               Repeat last leap + action             ║
║                                                       ║
║ WITH OPERATORS:                                       ║
║ d + s + chars   Delete to target                     ║
║ c + s + chars   Change to target                     ║
║ y + s + chars   Yank to target                       ║
║ v + s + chars   Visual select to target              ║
║ > + s + chars   Indent to target                     ║
║                                                       ║
║ MACROS:                                               ║
║ qa + [leap + edit] + q   Record macro with leap      ║
║ @a              Run recorded macro                    ║
║                                                       ║
║ WINDOWS:                                              ║
║ gs + chars      Jump to any window                    ║
╚════════════════════════════════════════════════════════╝
```

---

## Next Steps

**You're now a Leap power user!** 🚀

Continue your journey:
- [File Operations](./03-oil-introduction.md) - Manage files efficiently
- [Multi-File Navigation](./04-multi-file-navigation.md) - Jump between files
- [Telescope Mastery](./08-telescope-mastery.md) - Fuzzy finding everything

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
