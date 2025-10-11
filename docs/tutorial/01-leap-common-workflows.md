# Common Leap Workflows

Real-world usage patterns and workflows for using Leap.nvim in your daily coding.

## Prerequisites

Make sure you've completed [Basic Leap Usage](./01-leap-basic-usage.md) first.

---

## Workflow 1: Jump to Function Definition

**Scenario:** You're reading code and want to jump to a specific function

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

**Why this is fast:** No need to count lines or use `/process` search.

---

## Workflow 2: Jump to Variable Usage

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

**Pro tip:** If there are many matches, type a third character (e.g., `use`) to narrow down.

---

## Workflow 3: Edit at Specific Location

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

**Key insight:** Leap + operator = lightning-fast editing.

---

## Workflow 4: Navigate Long Functions

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

**Much faster than:** `8j` or `/filtered<Enter>`!

---

## Workflow 5: Delete from Here to There

**Scenario:** Delete a section of code

```javascript
function setup() {
  // Current cursor position
  const config = load_config();
  const options = parse_options();
  const merged = merge(config, options);
  // Want to keep from here
  return merged;
}
```

**Want to delete from cursor to "return"?**

**Steps:**
1. Position cursor at "const config"
2. Press `d` (delete operator)
3. Press `s` (leap becomes the motion)
4. Type `re` (for "return")
5. Press label
6. Everything from cursor up to "return" is deleted!

**Result:**
```javascript
function setup() {
  // Current cursor position
  return merged;
}
```

---

## Workflow 6: Copy from Here to There

**Scenario:** Yank (copy) a specific section

```lua
local function process_data()
  local input = get_input()
  local validated = validate(input)
  local transformed = transform(validated)
  local result = finalize(transformed)
  return result
end
```

**Want to copy from "validated" to "result"?**

**Steps:**
1. Position cursor at "validated"
2. Press `y` (yank operator)
3. Press `s` (leap motion)
4. Type `re` (for "result")
5. Press label
6. Lines are now in your clipboard!
7. Press `p` elsewhere to paste

---

## Workflow 7: Visual Selection with Leap

**Scenario:** Select text visually for manipulation

```ruby
class UserController
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end
end
```

**Want to select from "index" to "render :index"?**

**Steps:**
1. Position cursor at "index"
2. Press `v` (enter visual mode)
3. Press `s` (leap in visual mode)
4. Type `re` (for first "render")
5. Press label
6. Text is visually selected!
7. Now you can `d` (delete), `y` (copy), or `c` (change)

---

## Workflow 8: Jump Across Multiple Windows

**Scenario:** You have 3 splits open, need to navigate between them

```
┌──────────────────┬──────────────────┐
│ main.lua         │ tests.lua        │
│                  │                  │
│ function main()  │ function test()  │
│   ...            │   ...            │
│ ^ cursor here    │                  │
├──────────────────┴──────────────────┤
│ config.lua                          │
│                                     │
│ local config = {...}                │
└─────────────────────────────────────┘
```

**Want to jump to "test" in top-right, then "config" in bottom?**

**Steps:**
1. Press `gs` (leap from window)
2. Type `te` (for "test")
3. Press label → Jump to tests.lua
4. Press `gs` again
5. Type `co` (for "config")
6. Press label → Jump to config.lua

**Why this is powerful:** No need for `<C-w>hjkl` multiple times!

---

## Workflow 9: Repeat Edit Pattern

**Scenario:** Make the same change multiple times

```lua
function test_a() ... end
function test_b() ... end
function test_c() ... end
```

**Want to delete all three "test_" prefixes?**

**Steps:**
1. Press `s`, type `te`, jump to first "test_"
2. Press `dw` (delete word) to delete "test_"
3. Press `n` (next match - if using search)
   **OR** Press `.` (dot) to repeat the last action!
4. The leap + delete repeats on next "test_"!

**Note:** This requires the vim-repeat plugin (included in this config).

---

## Workflow 10: Navigate Error Messages

**Scenario:** Compiler shows errors on specific lines

```
Error: undefined variable 'config' on line 45
Error: type mismatch on line 78
Error: missing import on line 103
```

**Instead of `:45`, `:78`, `:103`:**

**Steps:**
1. Open the file
2. Press `s`, type `co` (for "config"), jump to error 1
3. Fix the error
4. Press `s`, type `ty` (for "type"), jump to error 2
5. Fix the error
6. Press `s`, type `im` (for "import"), jump to error 3
7. Fix the error

**Advantage:** Context-aware navigation instead of line numbers.

---

## Tips for Effective Workflows

### Tip 1: Think in Targets, Not Distances

**Old mindset:** "I need to go down 10 lines and right 5 words"

**New mindset:** "I need to go to the word 'function'"

**Action:** `s` + `fu` + label ✅

---

### Tip 2: Choose Unique 2-Character Patterns

**Bad:** `s` + `aa` (too common in code)

**Good:** `s` + `fu` (start of "function")

**Better:** `s` + `nc` (middle of "function" - even more unique)

---

### Tip 3: Combine with Operators Frequently

**Remember this pattern:**
```
operator + s/S + 2 chars + label = magic!
```

**Examples:**
- `d` + `s` + `re` + label = delete to "return"
- `c` + `S` + `fu` + label = change back to "function"
- `y` + `s` + `en` + label = yank to "end"
- `v` + `s` + `if` + label = visual select to "if"

---

### Tip 4: Keep Traditional Motions for Small Moves

**Best practice:**
- `hjkl` for 1-3 character moves
- `w/b/e` for 1-5 word moves
- **Leap for everything beyond that**

This hybrid approach is the fastest!

---

### Tip 5: Build Muscle Memory

**Practice routine:**
1. Spend 5 minutes daily using ONLY leap (no `hjkl`, no `/search`)
2. Force yourself to leap everywhere
3. After a week, it becomes second nature

**Start with one file:** Practice on a familiar file to build confidence.

---

## Common Patterns Cheat Sheet

```
╔════════════════════════════════════════════════════════╗
║                 COMMON LEAP PATTERNS                   ║
╠════════════════════════════════════════════════════════╣
║ Jump to function        s + fu + label                 ║
║ Jump to variable        s + [var name] + label         ║
║ Jump to return          s + re + label                 ║
║ Jump to import/require  s + im/re + label              ║
║ Jump to class           s + cl + label                 ║
║ Jump to error           s + er + label                 ║
║                                                        ║
║ Delete to target        d + s + chars + label          ║
║ Change to target        c + s + chars + label          ║
║ Copy to target          y + s + chars + label          ║
║ Select to target        v + s + chars + label          ║
║                                                        ║
║ Jump back               S + chars + label              ║
║ Jump across windows     gs + chars + label             ║
╚════════════════════════════════════════════════════════╝
```

---

## Next Steps

Ready for advanced techniques?

- **[Advanced Techniques](./01-leap-advanced.md)** - Power user tips
- [File Operations](./03-oil-introduction.md) - Use Leap with file management
- [Multi-File Navigation](./04-multi-file-navigation.md) - Leap between files

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
