# What is Leap and Why Use It?

Learn what makes Leap.nvim a revolutionary motion plugin and why it's faster than traditional Vim motions.

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

## How Leap Works

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

## Leap vs Traditional Motions

### Speed Comparison Table

| Task | Traditional Motion | Leap Motion | Winner |
|------|-------------------|-------------|---------|
| Jump 10 words ahead | `10w` (3 keys + counting) | `s` + 2 chars + label (3 keys) | Leap ⚡ |
| Jump to "return" | `/return<Enter>` (8 keys) | `s` + `re` + label (3 keys) | Leap ⚡ |
| Jump back to "function" | `?function<Enter>` (14 keys) | `S` + `fu` + label (3 keys) | Leap ⚡ |
| Jump across windows | `<C-w>l` (adjacent only) | `gs` + 2 chars + label (any) | Leap ⚡ |

### Real-World Speed Example

**Scenario:** Jump from line 10 to "return" at line 50

**Traditional approach:**
```
Option 1: /return<Enter>
- Type full word or enough to be unique
- 8-12 keystrokes
- Might overshoot if multiple "return"s

Option 2: 40j then f + r
- Need to calculate line distance
- Need to know current line number
- Multiple steps
```

**Leap approach:**
```
s + re + a
- 3 keystrokes total
- Instant visual feedback
- Precise jump every time
```

**Result:** Leap is ~3x faster! 🏆

---

## When to Use Each Motion Type

### Use `hjkl` for:
- Small adjustments (1-3 lines/characters)
- When target is very close (adjacent lines)

### Use `w/b/e` for:
- Moving 1-5 words
- When you're already thinking in words
- Same-line navigation

### Use Leap for:
- **Anything beyond 5 words away**
- **Cross-line jumps**
- **When you know what you're jumping to**
- **Precision jumps (exact location)**

This hybrid approach is fastest!

---

## Next Steps

Ready to learn how to use Leap? Continue to:

- **[Basic Leap Usage](./01-leap-basic-usage.md)** - Learn the three commands
- [Common Workflows](./01-leap-common-workflows.md) - Real-world examples
- [Advanced Techniques](./01-leap-advanced.md) - Power user tips

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
