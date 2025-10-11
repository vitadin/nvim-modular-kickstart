# What is Telescope and Search Scope

Understand what Telescope does and where it searches - critical foundation for using it effectively.

---

## What is Telescope?

Telescope is a **fuzzy finder** - it helps you find things quickly by typing just a few characters. Think of it as a universal search engine for your code.

**What can you search for?**
- Files by name
- File contents (text inside files)
- Git commits and branches
- Help documentation
- Keymaps
- LSP symbols (functions, variables)
- Recently opened files
- And much more!

**Why Telescope is powerful:**
- Fast fuzzy matching (type "flcnf" to find "file_config.lua")
- Live preview of results
- Works with huge codebases
- Extensible and customizable

---

## Search Scope: Where Does Telescope Search?

**IMPORTANT:** Telescope does NOT search your entire computer!

### Default Search Range

When you use Telescope commands like `<leader>sf` or `<leader>sg`:

**Telescope searches from your current working directory (CWD).**

**What is the current working directory?**
- It's the directory where you started Neovim
- Example: If you run `nvim` from `~/projects/myapp/`, then Telescope searches everything under `~/projects/myapp/`

---

## How to Check Your Current Directory

```vim
:pwd    " Print working directory
```

This shows where Telescope is searching from.

---

## Changing the Search Directory

### Method 1: Start Neovim from the Right Directory

```sh
cd ~/projects/myapp
nvim
```

### Method 2: Change Directory Inside Neovim

```vim
:cd ~/projects/myapp    " Change to this directory
:pwd                    " Verify the change
```

---

## What Gets Searched?

**Included:**
- All files and subdirectories under the current working directory
- Hidden files (starting with `.`)

**Excluded (automatically):**
- Files/directories listed in `.gitignore`
- Files inside `node_modules/`, `.git/`, etc. (if in `.gitignore`)

---

## Example Scenario

```
Directory structure:
/home/user/
├── projects/
│   ├── webapp/        ← You start nvim here
│   │   ├── src/
│   │   ├── tests/
│   │   └── node_modules/  (excluded via .gitignore)
│   └── another-project/   (NOT searched - outside CWD)
└── documents/             (NOT searched - outside CWD)

If you run: cd ~/projects/webapp && nvim

Then Telescope searches:
✓ src/
✓ tests/
✗ node_modules/ (excluded by .gitignore)
✗ another-project/ (outside CWD)
✗ documents/ (outside CWD)
```

---

## Special Search Commands

This configuration includes a special command for searching **only** in your Neovim config:

```
<leader>sn    Search [N]eovim files
              → Searches only in ~/.config/nvim/
              → Ignores your current working directory
```

**Use case:** Customize your config without leaving your project!

---

## Best Practice: Always Start from Project Root

**Good - from project root:**
```sh
cd ~/projects/myapp
nvim
```

**Less ideal - from subdirectory:**
```sh
cd ~/projects/myapp/src/components
nvim
# Now Telescope only searches components/ directory
```

**Pro tip:** Use a file explorer or fuzzy finder to navigate to your project first, then start Neovim from there.

---

## Common Scenarios

### Scenario 1: Can't Find Files

**Problem:** You press `Space s f` but your file doesn't appear

**Solution:** Check where Telescope is searching
```vim
:pwd    " Shows current directory
```

If wrong directory, change it:
```vim
:cd ~/correct/path
```

---

### Scenario 2: Too Many Results

**Problem:** Telescope shows files from multiple projects

**Cause:** You started Neovim from a parent directory like `~/projects/`

**Solution:** Navigate to specific project first
```sh
cd ~/projects/myapp    # Not ~/projects/
nvim
```

---

### Scenario 3: Searching Multiple Projects

**Problem:** You want to search across multiple projects

**Solution:** Start Neovim from the common parent directory
```sh
cd ~/projects    # Parent of all projects
nvim
# Now Telescope searches all projects under ~/projects/
```

**Note:** This can be slow for large directory trees!

---

## Performance Consideration

**Telescope speed depends on:**
1. **Number of files** - More files = slower search
2. **Your `.gitignore`** - Properly excluded directories speed things up
3. **Starting directory** - Smaller scope = faster search

**Best practice:**
```
Always add to .gitignore:
- node_modules/
- dist/
- build/
- .next/
- __pycache__/
- *.pyc
```

This dramatically speeds up Telescope!

---

## Understanding Search Context

**Key concept:** Telescope searches **relative to where you are**

```
Example 1: Start from ~/projects/webapp/
→ Searches everything in webapp/
→ Perfect for working on one project

Example 2: Start from ~/projects/
→ Searches ALL projects
→ Good for finding files across projects
→ But slower due to more files

Example 3: Start from ~/projects/webapp/src/
→ Searches only src/ directory
→ Fast but limited scope
```

**Choose starting location based on your needs!**

---

## Quick Reference: Search Scope

```
╔════════════════════════════════════════════════════╗
║           TELESCOPE SEARCH SCOPE                   ║
╠════════════════════════════════════════════════════╣
║ WHERE IT SEARCHES:                                ║
║ • Current working directory (CWD) and below       ║
║ • Respects .gitignore exclusions                  ║
║ • Does NOT search outside CWD                     ║
║                                                   ║
║ CHECK YOUR LOCATION:                              ║
║ :pwd          Show current directory              ║
║ :cd <path>    Change directory                    ║
║                                                   ║
║ BEST PRACTICE:                                    ║
║ • Start nvim from project root                    ║
║ • Add large dirs to .gitignore                    ║
║ • Use :pwd to verify location                     ║
╚════════════════════════════════════════════════════╝
```

---

## Next Steps

Now that you understand where Telescope searches:

- **[Basic Telescope Usage](./08-telescope-basic-usage.md)** - Learn the essential commands
- [Search Modes](./08-telescope-search-modes.md) - Different ways to search
- [Workflows](./08-telescope-workflows.md) - Real-world usage patterns

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
