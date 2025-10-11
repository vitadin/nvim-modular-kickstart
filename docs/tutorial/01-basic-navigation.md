# Basic Navigation with Leap.nvim

Master lightning-fast movement in Neovim using Leap - a revolutionary motion plugin that lets you jump anywhere with just 2-3 keystrokes.

## Table of Contents

- [What is Leap?](#what-is-leap)
- [Why Use Leap?](#why-use-leap)
- [Basic Concept](#basic-concept)
- [The Three Leap Commands](#the-three-leap-commands)
- [Step-by-Step Tutorial](#step-by-step-tutorial)
- [Common Workflows](#common-workflows)
- [Advanced Techniques](#advanced-techniques)
- [Leap vs Traditional Motions](#leap-vs-traditional-motions)
- [Practice Exercises](#practice-exercises)
- [Troubleshooting](#troubleshooting)

---

## What is Leap?

Leap is a **motion plugin** that transforms how you navigate in Neovim.

**Traditional navigation:**
```
You want to go to line 50?
→ Type :50 or 50G or /pattern<Enter>
→ Multiple keystrokes, need to think about line numbers
```

**With Leap:**
```
You want to go to the word "function" ahead?
→ Press s, type "fu", press label key
→ 3 keystrokes, instant jump!
```

**Key concept:** Leap lets you jump to any visible location by typing just 2 characters of your target.

---

## Why Use Leap?

### Speed
- **Traditional:** 10w (move 10 words forward) = counting + typing
- **Leap:** s + fu + a (jump to "function") = 3 keystrokes, no counting

### Precision
- Jump exactly where you want
- No overshooting or undershooting
- Visual feedback shows all possible targets

### Simplicity
- Only need to remember: `s` (forward), `S` (backward), `gs` (windows)
- No complex motion combinations to memorize
- Works intuitively

---

## Basic Concept

### How Leap Works

1. **Press trigger key** (`s` for forward, `S` for backward)
2. **Type 2 characters** of your target location
3. **See labels** appear on all matches
4. **Press label** to jump there instantly

### Visual Example

```
Before pressing 's':
─────────────────────────────────────
function calculate_total(items)
  local total = 0
  for item in items do
    total = total + item.price
  end
  return total
end
─────────────────────────────────────
Cursor is here: ^
```

```
After pressing 's' then typing 'to':
─────────────────────────────────────
function calculate_aotal(items)
  local botal = 0
  for item in items do
    cotal = dotal + item.price
  end
  return eotal
end
─────────────────────────────────────
Cursor is here: ^

Labels appear: a, b, c, d, e
Press 'd' to jump to "total = total + item.price"
```

---

## The Three Leap Commands

### Command 1: `s` - Leap Forward

**What it does:** Search for locations **ahead** of your cursor

**When to use:** Moving down or right in your file

**Example:**
```
Current position:
    |
    v
function setup()
  local config = {...}
  return config
end

Want to jump to "return"?
1. Press s
2. Type "re"
3. Press the label that appears on "return"
```

### Command 2: `S` - Leap Backward

**What it does:** Search for locations **behind** your cursor

**When to use:** Moving up or left in your file

**Example:**
```
                            Current position:
                                    |
                                    v
function setup()
  local config = {...}
  return config
end

Want to jump back to "function"?
1. Press S (capital S)
2. Type "fu"
3. Press the label that appears on "function"
```

### Command 3: `gs` - Leap From Window

**What it does:** Jump to **any visible window/split**

**When to use:** You have multiple splits open and want to jump across them

**Example:**
```
┌─────────────────┬─────────────────┐
│ File 1          │ File 2          │
│ function main() │ function test() │
│   ...           │   ...           │
│ ^ cursor here   │                 │
└─────────────────┴─────────────────┘

Want to jump to "test" in the right window?
1. Press gs
2. Type "te"
3. Press the label (jumps to other window!)
```

---

## Step-by-Step Tutorial

### Tutorial 1: Your First Leap

Let's practice with a simple example.

**Setup:** Open any file with some text, or use this example:
```
The quick brown fox jumps over the lazy dog.
A journey of a thousand miles begins with a single step.
To be or not to be, that is the question.
```

**Exercise:**
1. Position your cursor at the start of the first line
2. Press `s` (you'll see the status line change - Leap is active)
3. Type `ju` (for "jumps")
4. Watch as labels appear on all "ju" matches
5. Press the label key that appears over "jumps"
6. 🎉 You just leaped!

### Tutorial 2: Leaping Backward

**Setup:** Same text as above, but position cursor at the end of line 3

**Exercise:**
1. Position cursor: "To be or not to be, that is the question.|"
2. Press `S` (capital S - backward leap)
3. Type `qu` (for "quick")
4. Press the label that appears over "quick" in line 1
5. You jumped backward across multiple lines!

### Tutorial 3: Multiple Matches

**Setup:** Text with multiple similar words
```
test function test_user test_data test_validation
function test_helper function test_runner
test_integration test_unit
```

**Exercise:**
1. Cursor at start
2. Press `s`
3. Type `te` (for "test")
4. Notice labels (a, b, c, d, etc.) on EVERY "te" match
5. Press different labels to try jumping to different "test" words
6. Press `<Esc>` to cancel if you don't want to jump

### Tutorial 4: Leaping Across Windows

**Setup:** Split your window
```
:vsplit
```

Now you have two windows side by side.

**Exercise:**
1. Make sure you're in the left window
2. Press `gs` (leap from window)
3. Type any 2 characters visible in the right window
4. Press the label
5. Cursor moves to the right window!

---

## Common Workflows

### Workflow 1: Jump to Function Definition

**Scenario:** You're reading code and want to jump to a function

```lua
-- Current position
local function calculate() ... end  ^
local function validate() ... end
local function process() ... end
local function transform() ... end
```

**Steps:**
1. Press `s`
2. Type `pr` (first 2 letters of "process")
3. Press label → Jump directly to `process()`

### Workflow 2: Jump to Variable Usage

**Scenario:** Find where a variable is used

```lua
local user_name = "John"
-- ... 50 lines of code ...
print(user_name)  -- Want to jump here
-- ... more code ...
print(user_name)  -- Or here
```

**Steps:**
1. Press `s`
2. Type `us` (for "user")
3. See labels on both `user_name` occurrences
4. Press label for the one you want

### Workflow 3: Edit at Specific Location

**Scenario:** Jump and immediately start editing

```python
def calculate_total(items):
    total = 0  # Want to change this to sum
    for item in items:
        total += item.price
    return total
```

**Steps:**
1. Press `s`
2. Type `to` (for "total")
3. Press label to jump to "total = 0"
4. Press `cw` (change word) immediately
5. Type `sum`
6. You've leaped and edited in one smooth motion!

### Workflow 4: Navigate Long Functions

**Scenario:** Jumping through a long function

```javascript
function processData(data) {
  const validated = validate(data);
  const transformed = transform(validated);
  const filtered = filter(transformed);
  const sorted = sort(filtered);
  const grouped = group(sorted);
  const aggregated = aggregate(grouped);
  return aggregated;
}
```

**Steps:**
1. At top, want to jump to "filtered"? Press `s`, type `fi`, jump
2. Want to go back to "validated"? Press `S`, type `va`, jump
3. Jump to "return"? Press `s`, type `re`, jump

Much faster than `8j` or `/filtered`!

### Workflow 5: Leap + Operator

**Scenario:** Delete/change/yank from here to target

```
function setup()
  local config = load_config()
  local options = parse_options()
  return merge(config, options)
end
```

**Want to delete from cursor to "return"?**

**Steps:**
1. Position cursor at "local config"
2. Press `d` (delete operator)
3. Press `s` (leap becomes the motion)
4. Type `re` (for "return")
5. Press label
6. Everything from cursor to "return" is deleted!

**This works with:**
- `d` + leap = delete to target
- `c` + leap = change to target
- `y` + leap = yank (copy) to target
- `v` + leap = visual select to target

---

## Advanced Techniques

### Technique 1: Ambiguous Targets

**Problem:** Multiple identical 2-character sequences

```
test test test test test test
```

**Solution:** Type 2 characters, then use special keys:
- `<Enter>` - Jump to next occurrence
- `<Tab>` - Jump to previous occurrence
- `<Space>` - Show next group of labels

### Technique 2: Label Preference

**What you'll notice:** Leap shows labels in a specific order

```
Labels: s, f, n, j, k, l, h, o, d, w, e, i, m, b, u, y...
```

**Why:** These are home row keys! Easier to reach.

**Tip:** Your target often gets `s`, `f`, or `n` label (fastest to type)

### Technique 3: Repeat with Dot

**Leap motions are repeatable!**

```
function test_a() ... end
function test_b() ... end
function test_c() ... end
```

**Steps:**
1. Press `s`, type `fu`, jump to first function
2. Do something (e.g., `daw` to delete the word)
3. Press `.` (dot) → Repeats the leap + action on next "fu"!

### Technique 4: Visual Mode Leap

**Select text using leap:**

```
local variable = "some long text that I want to select"
```

**Steps:**
1. Press `v` (visual mode)
2. Press `s` (leap forward)
3. Type target characters
4. Press label
5. Text is selected from cursor to target!

### Technique 5: Case Insensitivity

**Leap is case insensitive by default**

```
Function MyFunction FUNCTION
```

Typing `fu` will match all three:
- `Function`
- `MyFunction` (the "Fu" part)
- `FUNCTION`

---

## Leap vs Traditional Motions

### Comparison Table

| Task | Traditional Motion | Leap Motion |
|------|-------------------|-------------|
| Jump 10 words ahead | `10w` (count + motion) | `s` + 2 chars + label |
| Jump to "return" | `/return<Enter>` (8 keys) | `s` + `re` + label (3 keys) |
| Jump back to "function" | `?function<Enter>` (14 keys) | `S` + `fu` + label (3 keys) |
| Jump to line 50 | `:50<Enter>` or `50G` | `s` + 2 chars from line 50 + label |
| Jump across windows | `<C-w>l` (only adjacent) | `gs` + 2 chars + label (any window) |

### When to Use Traditional Motions

**Use `hjkl` for:**
- Small adjustments (1-3 lines/characters)
- When target is very close

**Use `w/b/e` for:**
- Moving 1-5 words
- When you're already thinking in words

**Use Leap for:**
- Anything beyond 5 words away
- Cross-line jumps
- When you know what you're jumping to
- Precision jumps (exact location)

### Real-World Speed Comparison

**Scenario:** Jump from line 10 to "return" at line 50

**Traditional:**
```
Option 1: /return<Enter>
- Need to type full word or enough to be unique
- 8-12 keystrokes
- Might overshoot if multiple "return"s

Option 2: 40j (down 40 lines) then f + r (find 'r')
- Need to calculate line distance
- Need to know current line number
- Multiple steps
```

**Leap:**
```
s + re + a
- 3 keystrokes
- Instant visual feedback
- Precise jump
```

**Winner:** Leap by ~3x faster 🏆

---

## Practice Exercises

### Exercise 1: Forward Leaping

**File content:**
```
The quick brown fox jumps over the lazy dog.
Programming is fun when you understand the concepts.
Variables store data for later use in your program.
```

**Tasks:**
1. Start at beginning of line 1
2. Leap to "jumps" → `s` + `ju` + label
3. Leap to "concepts" → `s` + `co` + label
4. Leap to "data" → `s` + `da` + label

### Exercise 2: Backward Leaping

**Starting position:** End of line 3 from Exercise 1

**Tasks:**
1. Leap back to "Variables" → `S` + `Va` + label
2. Leap back to "fun" → `S` + `fu` + label
3. Leap back to "quick" → `S` + `qu` + label

### Exercise 3: Multiple Matches

**File content:**
```
test_user test_admin test_guest
function test_helper()
  test_data = load_test()
  test_result = run_test()
end
```

**Tasks:**
1. Start at line 1
2. Leap to "test_admin" → `s` + `te` + (find correct label)
3. Leap to "test_data" → `s` + `te` + (different label)
4. Leap back to "test_helper" → `S` + `te` + label

### Exercise 4: Leap + Edit

**File content:**
```
local name = "old_value"
local age = 25
local city = "old_value"
```

**Tasks:**
1. Change "old_value" on line 1 to "John"
   - `s` + `ol` + label + `ciw` + `John` + `<Esc>`
2. Change "old_value" on line 3 to "NYC"
   - `s` + `ol` + label + `ciw` + `NYC` + `<Esc>`

### Exercise 5: Window Navigation

**Setup:**
1. Open Neovim
2. Split vertically: `:vsplit`
3. Split horizontally: `:split`
4. You now have 3 windows

**Tasks:**
1. Use `gs` to jump from current window to each other window
2. Practice: `gs` + type 2 chars visible in target window + label

---

## Troubleshooting

### Q: I pressed 's' but nothing happened?

**A:** Check:
1. Make sure you're in **normal mode** (press `<Esc>` first)
2. You might have a conflicting keymap
3. Try `:verbose map s` to see if another plugin mapped `s`

### Q: Labels don't appear after typing 2 characters?

**A:** Possible causes:
1. No matches found - try different characters
2. Pattern too common - Leap has limits on how many matches to show
3. Try typing more characters (3rd, 4th) to narrow down

### Q: I keep hitting the wrong label?

**A:** This is normal at first! Tips:
1. Practice with home row labels (`s`, `f`, `n`, `j`, `k`, `l`, `h`)
2. Look before you leap - take your time to find the right label
3. You can press `<Esc>` to cancel
4. Speed comes with practice

### Q: Can I cancel a leap in progress?

**A:** Yes!
- Press `<Esc>` anytime after starting a leap
- Or `<C-c>` also works
- Cursor stays where it was

### Q: Leap jumps to wrong location?

**A:** Two possibilities:
1. You pressed wrong label - just leap again
2. Multiple matches too close together - type a 3rd character to narrow down

### Q: How do I leap to something with spaces?

**A:** Good question! Examples:
- "user name" → Type `us` (first word) or `na` (second word)
- You can't leap to the space itself, leap to words near it

---

## Tips for Mastery

### Tip 1: Think in Targets, Not Distances

**Old mindset:** "I need to go down 10 lines and right 5 words"

**New mindset:** "I need to go to the word 'function'"

**Action:** `s` + `fu` + label ✅

### Tip 2: Use 2 Unique Characters

**Bad:** `s` + `aa` (too common in code)

**Good:** `s` + `fu` (start of "function")

**Better:** `s` + `nc` (middle of "function" - less common)

### Tip 3: Combine with Operators

**Remember this pattern:**
```
operator + s/S + 2 chars + label = magic!
```

Examples:
- `d` + `s` + `re` + label = delete to "return"
- `c` + `S` + `fu` + label = change back to "function"
- `y` + `s` + `en` + label = yank to "end"

### Tip 4: Build Muscle Memory

**Practice routine:**
1. Spend 5 minutes only using leap (no `hjkl`, no `/search`)
2. Force yourself to leap everywhere
3. After a few days, it becomes second nature

### Tip 5: Keep Traditional Motions for Small Moves

**Good strategy:**
- `hjkl` for 1-3 character moves
- `w/b/e` for 1-5 word moves
- **Leap for everything else**

This hybrid approach is fastest!

---

## Quick Reference Card

```
╔══════════════════════════════════════════════════════════╗
║                    LEAP.NVIM REFERENCE                   ║
╠══════════════════════════════════════════════════════════╣
║ BASIC COMMANDS                                           ║
║ s              Leap forward                              ║
║ S              Leap backward                             ║
║ gs             Leap from window (across splits)          ║
║                                                          ║
║ AFTER PRESSING s/S/gs                                   ║
║ [2 chars]      Type your target                         ║
║ [label]        Press label to jump                      ║
║ <Enter>        Next match                               ║
║ <Tab>          Previous match                           ║
║ <Space>        Next group of labels                     ║
║ <Esc>          Cancel leap                              ║
║                                                          ║
║ COMBINING WITH OPERATORS                                ║
║ d + s + chars  Delete to target                        ║
║ c + s + chars  Change to target                        ║
║ y + s + chars  Yank to target                          ║
║ v + s + chars  Visual select to target                 ║
║                                                          ║
║ TIPS                                                     ║
║ • Case insensitive by default                           ║
║ • Works in normal, visual, operator-pending modes       ║
║ • Repeatable with . (dot)                              ║
║ • Home row labels appear first (s, f, n, j, k...)      ║
╚══════════════════════════════════════════════════════════╝
```

---

## Next Steps

After mastering Leap:

1. **[Editing Basics](./02-editing-basics.md)** - Combine leap with editing commands
2. **[File Operations](./03-file-operations.md)** - Use leap to navigate while managing files
3. **[Multi-File Navigation](./04-multi-file-navigation.md)** - Leap across different files

**You're now ready to leap through your code at lightning speed!** ⚡

---

## See Also

- [Multi-File Navigation](./04-multi-file-navigation.md) - Jumping between files
- [Telescope Mastery](./08-telescope-mastery.md) - Finding files and content

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
