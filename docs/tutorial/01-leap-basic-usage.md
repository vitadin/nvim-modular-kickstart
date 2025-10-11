# Basic Leap Usage

Master the three Leap commands with step-by-step tutorials and practice exercises.

## Prerequisites

Read [What is Leap and Why Use It?](./01-leap-what-and-why.md) first to understand the concepts.

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

---

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

---

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

## Step-by-Step Tutorials

### Tutorial 1: Your First Leap

**Setup:** Open any file with some text, or use this example:
```
The quick brown fox jumps over the lazy dog.
A journey of a thousand miles begins with a single step.
To be or not to be, that is the question.
```

**Exercise:**
1. Position your cursor at the start of the first line
2. Press `s` (status line changes - Leap is active)
3. Type `ju` (for "jumps")
4. Watch as labels appear on all "ju" matches
5. Press the label key that appears over "jumps"
6. 🎉 You just leaped!

---

### Tutorial 2: Leaping Backward

**Setup:** Same text as above, position cursor at end of line 3

**Exercise:**
1. Position cursor: "To be or not to be, that is the question.|"
2. Press `S` (capital S - backward leap)
3. Type `qu` (for "quick")
4. Press the label that appears over "quick" in line 1
5. You jumped backward across multiple lines!

---

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

**Key insight:** When there are many matches, each gets a unique label!

---

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

## Using Leap with Operators

**Powerful feature:** Combine Leap with Vim operators!

### Delete to Target

```
function setup()
  local config = load_config()
  local options = parse_options()
  return merge(config, options)
end
```

**Want to delete from cursor to "return"?**

1. Position cursor at "local config"
2. Press `d` (delete operator)
3. Press `s` (leap becomes the motion)
4. Type `re` (for "return")
5. Press label
6. Everything from cursor to "return" is deleted!

### This Works With:
- `d` + leap = delete to target
- `c` + leap = change to target
- `y` + leap = yank (copy) to target
- `v` + leap = visual select to target

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

---

### Exercise 2: Backward Leaping

**Starting position:** End of line 3 from Exercise 1

**Tasks:**
1. Leap back to "Variables" → `S` + `Va` + label
2. Leap back to "fun" → `S` + `fu` + label
3. Leap back to "quick" → `S` + `qu` + label

---

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

---

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

---

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

---

### Q: Labels don't appear after typing 2 characters?

**A:** Possible causes:
1. No matches found - try different characters
2. Pattern too common - try more specific characters (3rd, 4th char)
3. Leap has limits on how many matches to show

---

### Q: I keep hitting the wrong label?

**A:** This is normal at first! Tips:
1. Practice with home row labels (`s`, `f`, `n`, `j`, `k`, `l`, `h`)
2. Look before you leap - take your time to find the right label
3. Press `<Esc>` to cancel anytime
4. Speed comes with practice

---

### Q: Can I cancel a leap in progress?

**A:** Yes!
- Press `<Esc>` anytime after starting a leap
- Or `<C-c>` also works
- Cursor stays where it was

---

### Q: How do I leap to something with spaces?

**A:** Examples:
- "user name" → Type `us` (first word) or `na` (second word)
- You can't leap to the space itself, leap to words near it

---

## Quick Reference

```
╔══════════════════════════════════════════════════╗
║              LEAP BASIC COMMANDS                 ║
╠══════════════════════════════════════════════════╣
║ s              Leap forward                      ║
║ S              Leap backward                     ║
║ gs             Leap from window                  ║
║                                                  ║
║ AFTER PRESSING s/S/gs                           ║
║ [2 chars]      Type your target                 ║
║ [label]        Press label to jump              ║
║ <Esc>          Cancel leap                      ║
║                                                  ║
║ WITH OPERATORS                                  ║
║ d + s + chars  Delete to target                ║
║ c + s + chars  Change to target                ║
║ y + s + chars  Yank to target                  ║
║ v + s + chars  Visual select to target         ║
╚══════════════════════════════════════════════════╝
```

---

## Next Steps

Now that you know the basics:

- **[Common Workflows](./01-leap-common-workflows.md)** - Real-world usage patterns
- [Advanced Techniques](./01-leap-advanced.md) - Power user tips and tricks

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
