# Creating Files and Folders with Oil.nvim

Learn how to create files and directories using Oil's buffer-based approach.

## Prerequisites

Read [What is Oil.nvim?](./03-oil-introduction.md) first to understand the basic concepts.

---

## Key Concept

**In Oil, you create files/folders by inserting new lines and typing names.**

- Type a name → Creates a file
- Type a name with trailing `/` → Creates a folder
- Nothing is created until you save with `:w`

---

## Create a Single File

**Steps:**
```
1. Press - to open oil
2. Press o (open line below)
3. Type filename: "newfile.lua"
4. Press Esc
5. Press :w to create the file
```

**Visual example:**

```
Before 'o':              After 'o':              After typing:
─────────────────       ─────────────────       ─────────────────
../                     ../                     ../
init.lua                init.lua                init.lua
README.md               [cursor here]           newfile.lua ← typed
                        README.md               README.md
```

**Important:** The file is NOT created until you save with `:w`!

---

## Create a Folder

**Steps:**
```
1. Press - to open oil
2. Press o
3. Type folder name WITH trailing slash: "newfolder/"
4. Press Esc
5. Press :w to create the folder
```

**Example:**

```
Before:                 After typing:           After :w:
─────────────────       ─────────────────       ─────────────────
../                     ../                     ../
src/                    src/                    src/
docs/                   newfolder/ ← typed      newfolder/ ← created!
README.md               docs/                   docs/
                        README.md               README.md
```

**Critical:** The trailing `/` tells Oil you want a directory, not a file!

**What happens without `/`:**
- Type `newfolder` → Creates a file named "newfolder" (no extension)
- Type `newfolder/` → Creates a directory named "newfolder"

---

## Create Multiple Files at Once

**Scenario:** Create three related files

**Steps:**
```
1. Press - to open oil
2. Press o and type "file1.lua", press Esc
3. Press o and type "file2.lua", press Esc
4. Press o and type "file3.lua", press Esc
5. Press :w → All three files created at once!
```

**Visual:**

```
Before:                 After adding lines:     After :w:
─────────────────       ─────────────────       ─────────────────
../                     ../                     ../
init.lua                init.lua                init.lua
README.md               file1.lua               file1.lua ← created
                        file2.lua               file2.lua ← created
                        file3.lua               file3.lua ← created
                        README.md               README.md
```

**Benefit:** Make all changes first, then save once!

---

## Create Nested Directory Structure

**Scenario:** Want to create `newfolder/subfile.lua`

### Method 1: Step by Step

```
1. Press - to open oil
2. Press o and type "newfolder/", press Esc
3. Press :w to create the folder
4. Press Enter on newfolder/ to enter it
5. Press o and type "subfile.lua", press Esc
6. Press :w to create the file
```

### Method 2: Create Both at Once (Advanced)

**Note:** You can create nested structures in one line!

```
1. Press - to open oil
2. Press o
3. Type "newfolder/subfile.lua"
4. Press Esc
5. Press :w → Both folder and file created!
```

**Oil automatically creates parent directories if they don't exist.**

---

## Create Complex Project Structure

**Scenario:** Create a new feature with multiple files

**Want to create:**
```
feature/
├── init.lua
├── handler.lua
└── utils.lua
```

**Steps:**
```
1. Press - to open oil
2. Press o, type "feature/", press Esc
3. Press :w (create folder)
4. Press Enter to enter feature/
5. Press o, type "init.lua", press Esc
6. Press o, type "handler.lua", press Esc
7. Press o, type "utils.lua", press Esc
8. Press :w → All files created!
```

**Result:**
```
feature/
├── init.lua      ← empty file created
├── handler.lua   ← empty file created
└── utils.lua     ← empty file created
```

**Remember:** Oil creates empty files. You'll edit them after creation.

---

## Advanced: Create Multiple Folders

**Scenario:** Create multiple directories for a project

```
1. Press - to open oil
2. Press o, type "src/", press Esc
3. Press o, type "tests/", press Esc
4. Press o, type "docs/", press Esc
5. Press :w → All three folders created!
```

**Result:**
```
./
├── src/      ← created
├── tests/    ← created
├── docs/     ← created
└── (other files)
```

---

## Practice Exercises

### Exercise 1: Create Three Files

**Task:** Create `test1.lua`, `test2.lua`, `test3.lua`

**Steps:**
```
1. Press - to open oil
2. Press o, type "test1.lua", press Esc
3. Press o, type "test2.lua", press Esc
4. Press o, type "test3.lua", press Esc
5. Press :w
6. Verify: Press - again to see the files created
```

---

### Exercise 2: Create a Folder and File Inside

**Task:** Create `config/` and `config/settings.lua`

**Steps:**
```
1. Press - to open oil
2. Press o, type "config/", press Esc
3. Press :w (folder created)
4. Press Enter on config/ (enter folder)
5. Press o, type "settings.lua", press Esc
6. Press :w (file created)
7. Verify: You should be inside config/ seeing settings.lua
```

---

### Exercise 3: Create Nested Structure

**Task:** Create this structure:
```
practice/
├── src/
│   └── main.lua
└── test/
    └── test.lua
```

**Steps:**
```
1. Create practice/ folder
2. Enter practice/
3. Create src/ and test/ folders
4. Enter src/, create main.lua
5. Go back to practice/
6. Enter test/, create test.lua
```

---

## Common Mistakes and How to Fix Them

### Mistake 1: Forgot Trailing Slash for Folder

**Problem:**
```
1. Press o, type "myfolder" (no /)
2. Press :w
3. Creates a FILE named "myfolder", not a folder!
```

**Fix:**
```
1. Press - to open oil
2. Find the file "myfolder"
3. Press cw (change word)
4. Type "myfolder/" (with /)
5. Press :w (converts to folder)
```

---

### Mistake 2: Forgot to Save with :w

**Problem:**
```
1. Press o, type "newfile.lua"
2. Press q (close oil)
3. File was NOT created!
```

**Fix:** Always remember to save with `:w` before closing!

---

### Mistake 3: Created File in Wrong Directory

**Problem:**
```
1. Opened oil in /project/src/
2. Created test.lua
3. Wanted it in /project/tests/ instead!
```

**Fix:**
```
1. Press - to reopen oil
2. Find test.lua
3. Press cw (change word)
4. Type "../tests/test.lua"
5. Press :w (moves the file)
```

---

## Tips for Efficient File Creation

### Tip 1: Use `o` vs `O`

- `o` - Open line **below** cursor (most common)
- `O` - Open line **above** cursor

**Use case for `O`:**
```
Want to create a file at the TOP of the list:
1. Press gg (go to top)
2. Press O (open line above)
3. Type filename
```

---

### Tip 2: Create Related Files Together

**Instead of:**
```
Create file1.lua, save, create file2.lua, save, create file3.lua, save
```

**Do this:**
```
Create file1.lua, file2.lua, file3.lua, then save ONCE
```

**Benefit:** Atomic operation - all files created together or none at all.

---

### Tip 3: Use Descriptive Names Immediately

**Good:**
```
o → type "user_controller.lua" → Esc
```

**Bad:**
```
o → type "temp.lua" → Esc (then rename later)
```

**Why:** Saves time, avoids confusion.

---

### Tip 4: Verify Before Closing

**Best practice:**
```
1. Create files (o + filename + Esc)
2. Press :w (save)
3. Verify the files appear in the list
4. Then press q (close)
```

**Why:** Catch mistakes before leaving Oil.

---

## Troubleshooting

### Q: I pressed :w but file wasn't created?

**A:** Check:
1. Did you type a filename? (line can't be empty)
2. Is the filename valid? (no invalid characters like `:` or `*`)
3. Do you have write permissions in this directory?

---

### Q: Created a file but it has no content?

**A:** This is correct! Oil creates **empty files**.

**To add content:**
```
1. Press Enter on the filename (opens file)
2. Press i (insert mode)
3. Type your content
4. Press :w (save content)
```

---

### Q: How do I create a file with spaces in the name?

**A:** Just type it normally:
```
1. Press o
2. Type "my file.lua" (with space)
3. Press Esc and :w
```

**Note:** Spaces in filenames are valid but not recommended. Use underscores or dashes instead.

---

## Quick Reference

```
╔══════════════════════════════════════════════════════╗
║           CREATING FILES & FOLDERS                   ║
╠══════════════════════════════════════════════════════╣
║ o               Open line below (insert mode)       ║
║ O               Open line above (insert mode)       ║
║ [filename]      Type filename (e.g., "test.lua")    ║
║ [folder/]       Type foldername WITH / (e.g., "src/")║
║ :w              Save (creates files/folders)        ║
║ u               Undo (before :w)                    ║
║                                                     ║
║ KEY RULES:                                          ║
║ • No / at end   → Creates FILE                     ║
║ • Has / at end  → Creates FOLDER                   ║
║ • Nothing created until :w                         ║
║ • Can undo with u before :w                        ║
╚══════════════════════════════════════════════════════╝
```

---

## Next Steps

Now that you can create files and folders:

- **[Editing Files with Oil](./03-oil-editing-files.md)** - Rename, delete, copy files
- [Common Workflows](./03-oil-workflows.md) - Real-world usage patterns

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
