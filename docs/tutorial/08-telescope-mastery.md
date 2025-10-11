# Telescope Mastery

Master Telescope - the fuzzy finder that makes Neovim incredibly powerful.

## Table of Contents

- [What is Telescope?](#what-is-telescope)
- [Search Scope: Where Does Telescope Search?](#search-scope-where-does-telescope-search)
- [Basic Concepts](#basic-concepts)
- [Essential Commands](#essential-commands)
- [Navigation Inside Telescope](#navigation-inside-telescope)
- [Search Modes](#search-modes)
- [Advanced Filtering](#advanced-filtering)
- [Preview Window Tips](#preview-window-tips)
- [Quickfix Integration](#quickfix-integration)
- [Custom Searches](#custom-searches)
- [Performance Tips](#performance-tips)
- [Real-World Workflows](#real-world-workflows)

---

## What is Telescope?

Telescope is a **fuzzy finder** - it helps you find things quickly by typing
just a few characters. Think of it as a universal search engine for your code.

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

**Important:** Telescope does NOT search your entire computer!

### Default Search Range

When you use Telescope commands like `<leader>sf` or `<leader>sg`:

**Telescope searches from your current working directory (CWD).**

**What is the current working directory?**
- It's the directory where you started Neovim
- Example: If you run `nvim` from `~/projects/myapp/`, then Telescope searches
  everything under `~/projects/myapp/`

### How to Check Your Current Directory

```vim
:pwd    " Print working directory
```

This shows where Telescope is searching from.

### Changing the Search Directory

**Method 1: Start Neovim from the right directory**
```sh
cd ~/projects/myapp
nvim
```

**Method 2: Change directory inside Neovim**
```vim
:cd ~/projects/myapp    " Change to this directory
:pwd                    " Verify the change
```

### What Gets Searched?

**Included:**
- All files and subdirectories under the current working directory
- Hidden files (starting with `.`)

**Excluded (automatically):**
- Files/directories listed in `.gitignore`
- Files inside `node_modules/`, `.git/`, etc. (if in `.gitignore`)

### Example Scenario

```
Scenario: You have this directory structure:
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

### Special Search Commands

This configuration includes a special command for searching **only** in your
Neovim config:

```
<leader>sn    Search [N]eovim files
              → Searches only in ~/.config/nvim/
              → Ignores your current working directory
```

### Best Practice

**Always start Neovim from your project root:**

```sh
# Good - from project root
cd ~/projects/myapp
nvim

# Less ideal - from subdirectory
cd ~/projects/myapp/src/components
nvim
# Now Telescope only searches components/ directory
```

**Pro tip:** Use a file explorer or fuzzy finder to navigate to your project
first, then start Neovim from there.

---

## Basic Concepts

### What is `<leader>`?

**In this configuration, `<leader>` is the Space bar.**

So `<leader>sf` means: **Press Space, then s, then f**

### The Telescope Window

When you open Telescope, you'll see:

```
┌─────────────────────────────────────┐
│ > init.lua                          │ ← Input prompt (type here)
├─────────────────────────────────────┤
│ > init.lua                    3     │ ← Results list
│   README.md                   2     │
│   lua/config/options.lua      1     │
├─────────────────────────────────────┤
│ Preview of selected file            │ ← Preview window
│ ...file contents...                 │
└─────────────────────────────────────┘
```

**Three parts:**
1. **Prompt** (top) - Where you type your search
2. **Results** (middle) - Matching files/items
3. **Preview** (bottom) - Shows the selected item

---

## Essential Commands

### Remember: `<leader>` = Space bar

```
<leader>sf         Search files by name
                   → Press: Space s f

<leader>sg         Live grep (search file contents)
                   → Press: Space s g

<leader><leader>   Recent files
                   → Press: Space Space

<leader>sw         Search current word under cursor
                   → Press: Space s w

<leader>sh         Search help documentation
                   → Press: Space s h

<leader>sk         Search keymaps
                   → Press: Space s k

<leader>sd         Search diagnostics (errors/warnings)
                   → Press: Space s d

<leader>sr         Resume last search
                   → Press: Space s r

<leader>/          Search in current buffer
                   → Press: Space /
```

**Mnemonic:** Most commands start with **s** for "search"
- sf = search files
- sg = search grep
- sw = search word
- sh = search help
- sk = search keymaps
- sd = search diagnostics
- sr = search resume

---

## Navigation Inside Telescope

Once Telescope is open, use these keys:

### Moving Through Results

```
Ctrl-n  or  Down arrow     Next item
Ctrl-p  or  Up arrow       Previous item
Ctrl-u                     Scroll preview up
Ctrl-d                     Scroll preview down
```

### Actions

```
Enter             Open selected file
Ctrl-x            Open in horizontal split
Ctrl-v            Open in vertical split
Ctrl-t            Open in new tab

Ctrl-q            Send all results to quickfix list
Tab               Toggle selection (mark multiple items)
Shift-Tab         Deselect item

Esc  or  Ctrl-c   Close Telescope
```

### Example: Opening File in Split

```
1. Press Space s f (search files)
2. Type "option"
3. Press Ctrl-n to move to "options.lua"
4. Press Ctrl-v (opens in vertical split)
```

---

## Search Modes

### 1. Find Files (`<leader>sf`)

**When to use:** You know the filename, or part of it

**Example searches:**
```
Type: "init"      → Finds init.lua, init.vim, initialize.js
Type: "rcnf"      → Finds README.md, config.lua (fuzzy match)
Type: "lua opt"   → Finds lua/config/options.lua
```

**Tips:**
- Don't need to type the full name
- Order doesn't always matter (fuzzy matching)
- Case insensitive by default

---

### 2. Live Grep (`<leader>sg`)

**When to use:** You know what text you're looking for, but not where

**What it does:**
Searches the **contents** of all files in your project.

**Example searches:**
```
Type: "function setup"    → Finds all files with "function setup"
Type: "TODO"              → Finds all TODO comments
Type: "vim.keymap"        → Finds all keymap definitions
```

**Live Grep vs Find Files:**
```
Find Files:  Searches FILE NAMES
Live Grep:   Searches FILE CONTENTS
```

**Power combo:**
```
1. Press Space s g (live grep)
2. Type "require 'telescope'"
3. Find all files that import telescope
4. Press Enter to open one
```

---

### 3. Recent Files (`<leader><leader>`)

**When to use:** Switching between files you've recently edited

**This is the FASTEST way to navigate!**

```
1. Press Space Space
2. Type a few letters
3. Press Enter
```

**Example:**
```
Recently opened: init.lua, options.lua, keymaps.lua

Press Space Space
Type "opt" → options.lua appears first
Press Enter → instantly open options.lua
```

**Why it's fast:**
- Small list (only recent files)
- Sorted by recency
- Your most-used files appear first

---

### 4. Search Current Word (`<leader>sw`)

**When to use:** Cursor is on a word, want to find all occurrences

**Example workflow:**
```
1. Your cursor is on the word "telescope"
2. Press Space s w
3. Telescope searches for "telescope" in all files
4. Shows all matches with preview
5. Navigate and press Enter to jump
```

**Use case:**
- Find where a variable is used
- Find where a function is called
- Track down all references to something

---

### 5. Search in Current Buffer (`<leader>/`)

**When to use:** Searching within the file you're currently editing

**What it does:**
Shows all lines matching your search, with preview.

**Example:**
```
1. In a large file, press Space /
2. Type "function"
3. See all lines containing "function"
4. Press Enter to jump to selected line
```

**Better than:** Regular `/` search because:
- See all matches at once
- Preview context
- Fuzzy matching

---

## Advanced Filtering

### Exact Match

By default, Telescope uses fuzzy matching. For exact match:

```
Type: 'exact_word      (start with single quote)
Type: "exact phrase"   (use double quotes)
```

**Example:**
```
In live grep:
Type: init         → Finds "init", "initial", "initialize"
Type: 'init        → Finds only exact word "init"
Type: "init.lua"   → Finds exact phrase "init.lua"
```

### Exclude Patterns

Use `!` to exclude:

```
Type: test !spec       → Files with "test" but not "spec"
Type: config !backup   → Config files, excluding backups
```

### Path Filtering

Include path in search:

```
Type: lua/options      → Files in lua/ directory matching "options"
Type: plugin/tel       → Files in plugin/ matching "tel"
```

---

## Preview Window Tips

### Preview Navigation

While in Telescope:
```
Ctrl-u    Scroll preview up (half page)
Ctrl-d    Scroll preview down (half page)
```

**Use case:**
```
1. Search for "function setup"
2. Multiple results appear
3. Use Ctrl-n/Ctrl-p to cycle through results
4. Use Ctrl-u/Ctrl-d to read each preview
5. Find the right one without opening files
```

### No Preview Mode

If preview is slow or distracting:
- The preview window shows code context
- Can't disable without custom config
- But you can ignore it and focus on results

---

## Quickfix Integration

**What is quickfix?**
A list of locations (file + line number) you can navigate through.

### Send Results to Quickfix

```
1. Open Telescope (any search)
2. See multiple results you want to visit
3. Press Ctrl-q
4. All results sent to quickfix list
5. Close Telescope
6. Navigate quickfix with:
   :cnext  or  :cn    Next item
   :cprev  or  :cp    Previous item
   :copen             Open quickfix window
```

**Example workflow:**
```
1. Search for all TODO comments: Space s g, type "TODO"
2. Press Ctrl-q to send all TODOs to quickfix
3. Press Esc to close Telescope
4. Use :cn to cycle through each TODO
5. Fix them one by one
```

### Select Multiple Items

```
1. Open Telescope
2. Press Tab on items you want (marks them)
3. Press Ctrl-q to send selected items to quickfix
```

---

## Custom Searches

### Search Help for Topic

```
Press Space s h
Type: "telescope"
Find all help about telescope
```

**Great for learning!**
```
Space s h → "keymap"     Learn about keymaps
Space s h → "lsp"        Learn about LSP
Space s h → "motion"     Learn about motions
```

### Search Keymaps

```
Press Space s k
Type: "leader"
See all keymaps using leader
```

**Use cases:**
- Forgot a keymap? Search for it!
- "What was that grep command?" → Type "grep"
- "How do I split?" → Type "split"

### Search Diagnostics

```
Press Space s d
See all errors and warnings
Navigate to them quickly
```

**Use case:**
```
1. LSP shows 10 errors in your project
2. Press Space s d
3. See all errors in one list
4. Press Enter on each to jump and fix
```

---

## Performance Tips

### Search is Slow?

**1. Live Grep performance:**
- Searches entire project in real-time
- Faster with smaller projects
- Add more characters to narrow results

**2. Find Files performance:**
- Very fast (only searches filenames)
- Use this when possible

**3. Use `.gitignore`:**
- Telescope respects `.gitignore`
- Add `node_modules/`, `dist/`, `build/` to gitignore
- Dramatically speeds up searches

### Resume Last Search

Don't repeat yourself:
```
Press Space s r (search resume)
Opens your last telescope search
Continue where you left off
```

**Example:**
```
1. Search files: Space s f, type "config"
2. Open options.lua
3. Later, want to search "config" again
4. Press Space s r (much faster!)
```

---

## Real-World Workflows

### Workflow 1: Find and Replace Across Files

**Goal:** Change all occurrences of `old_name` to `new_name`

```
1. Press Space s g (live grep)
2. Type "old_name"
3. Press Ctrl-q (send to quickfix)
4. Press Esc
5. Run: :cdo s/old_name/new_name/g | update
   (This changes all occurrences and saves)
```

### Workflow 2: Explore Unfamiliar Codebase

**Goal:** Understand how authentication works

```
1. Press Space s g
2. Type "authenticate"
3. Browse results with Ctrl-n/Ctrl-p
4. Read previews with Ctrl-u/Ctrl-d
5. Press Enter on interesting files
6. Set marks (mA, mB) at important locations
```

### Workflow 3: Fix All Errors

**Goal:** LSP shows multiple errors, fix them all

```
1. Press Space s d (diagnostics)
2. See all errors listed
3. Press Enter on first error
4. Fix it
5. Press Space s d again
6. Repeat until done
```

### Workflow 4: Jump Between Related Files

**Goal:** Working on feature across multiple files

```
Use recent files (Space Space):
1. Edit controller.lua
2. Edit model.lua
3. Edit view.lua
4. Now use Space Space to instantly jump between them
5. Type 2-3 letters of filename
6. Press Enter
```

### Workflow 5: Learn Neovim

**Goal:** Learn about a Neovim feature

```
1. Press Space s h (search help)
2. Type the topic (e.g., "buffer")
3. Read help docs directly in Telescope
4. Press Enter to open full help page
```

### Workflow 6: Track Down Function Definition

**Goal:** Cursor on `setup()`, want to see where it's defined

```
Method 1 - Using search word:
1. Cursor on "setup"
2. Press Space s w
3. See all occurrences
4. Find the definition

Method 2 - Using LSP (faster):
1. Press g r d (go to definition)
2. Jump directly there
(See LSP Features tutorial for more)
```

---

## Combining with Other Tools

### Telescope + Marks

```
1. Use Telescope to find important files
2. Set global marks when you open them
3. Later, use marks for instant jumping
4. Use Telescope for fuzzy finding
```

### Telescope + LSP

```
1. Telescope for finding files
2. LSP for finding definitions/references within files
3. Best of both worlds
```

### Telescope + Git

```
This config has gitsigns and neogit.
Telescope can also search:
- Git commits
- Git branches
- Git status

(Advanced: requires custom Telescope commands)
```

---

## Common Questions

**Q: Telescope is showing too many results?**
A: Type more characters to narrow down. Or use `'exact` for exact match.

**Q: Can't find the file I want?**
A: Check your current directory with `:pwd`. Telescope only searches from your
   current working directory. See [Search Scope](#search-scope-where-does-telescope-search)
   for details.

**Q: Live grep is slow?**
A: Check your `.gitignore`. Exclude large directories like `node_modules/`.

**Q: How to search only in specific directory?**
A: Include path in search: Type `lua/config options` to search only in that
   directory.

**Q: Forgot what keymap does something?**
A: Press `Space s k` and search for what you remember. Or just press `Space`
   and wait - which-key will show you options.

**Q: Can I search in specific file types only?**
A: In live grep, after searching, manually filter results. Or use custom
   Telescope setup (advanced).

---

## Practice Exercises

### Exercise 1: Basic File Navigation

```
1. Press Space s f
2. Type "init"
3. Use Ctrl-n to move through results
4. Press Enter to open init.lua
```

### Exercise 2: Content Search

```
1. Press Space s g
2. Type "vim.keymap"
3. See all keymap definitions in your config
4. Use Ctrl-u/Ctrl-d to preview each one
```

### Exercise 3: Recent Files Speed Run

```
1. Open init.lua
2. Open options.lua
3. Open keymaps.lua
4. Now press Space Space and type "init"
5. See how fast you can jump back to init.lua
```

### Exercise 4: Quickfix Workflow

```
1. Press Space s g and search "TODO"
2. Press Ctrl-q to send to quickfix
3. Press Esc
4. Run :copen to see quickfix window
5. Navigate with :cn and :cp
```

### Exercise 5: Multi-Tool Navigation

```
1. Use Space s f to find "telescope.lua"
2. Open it and set mark T with mT
3. Use Space s g to search "require"
4. Browse results
5. Use 'T to jump back to telescope.lua
6. Use Ctrl-o to jump back to grep results
```

---

## Keyboard Shortcuts Quick Reference

**Opening Telescope:**
```
Space s f       Find files
Space s g       Live grep
Space Space     Recent files
Space s w       Search word under cursor
Space /         Search current buffer
Space s h       Search help
Space s k       Search keymaps
Space s d       Search diagnostics
Space s r       Resume last search
```

**Inside Telescope:**
```
Ctrl-n / Down   Next result
Ctrl-p / Up     Previous result
Ctrl-u          Scroll preview up
Ctrl-d          Scroll preview down

Enter           Open file
Ctrl-x          Open in horizontal split
Ctrl-v          Open in vertical split
Ctrl-t          Open in new tab

Ctrl-q          Send to quickfix
Tab             Toggle selection
Esc             Close
```

---

## Next Steps

After mastering Telescope:

1. **Learn LSP Features** - Combine Telescope with LSP for code navigation
2. **Custom Keymaps** - Create your own Telescope shortcuts
3. **Advanced Configuration** - Customize Telescope behavior (advanced)

**You're now a Telescope power user!** 🔭

---

## See Also

- [Multi-File Navigation](./04-multi-file-navigation.md) - Context for when to
  use Telescope
- [LSP Features](./06-lsp-features.md) - Complement Telescope with LSP
  navigation
- [Custom Keymaps](./09-custom-keymaps.md) - Create your own Telescope
  shortcuts

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
