# File Operations with Oil.nvim

Learn how to manage files and directories efficiently using Oil.nvim - a revolutionary file manager that lets you edit your filesystem like a buffer.

## Table of Contents

- [What is Oil.nvim?](#what-is-oilnvim)
- [Opening Oil](#opening-oil)
- [Basic Navigation](#basic-navigation)
- [Creating Files and Folders](#creating-files-and-folders)
- [Renaming Files](#renaming-files)
- [Deleting Files](#deleting-files)
- [Copying and Moving Files](#copying-and-moving-files)
- [Working with Multiple Files](#working-with-multiple-files)
- [Opening Files in Different Ways](#opening-files-in-different-ways)
- [Advanced Features](#advanced-features)
- [Common Workflows](#common-workflows)
- [Keyboard Shortcuts Reference](#keyboard-shortcuts-reference)

---

## What is Oil.nvim?

Oil.nvim is a **file manager that works like a text buffer**. Instead of using
special commands to manipulate files, you edit them like text and save your
changes.

**Key concept:** Your filesystem becomes a text buffer that you can edit with
normal Vim commands.

**Why Oil is powerful:**
- Use familiar Vim motions (dd, yy, p, cw, etc.)
- See all changes before applying them
- Batch operations (make multiple changes, save once)
- Undo/redo support
- No new keymaps to memorize

**Analogy:**
```
Traditional file manager:  Click file → Click delete → Confirm
Oil.nvim:                  Press dd → Press :w (done!)
```

---

## Opening Oil

### Two Ways to Open Oil

**Method 1: Current Window**
```
Press: -
Opens parent directory in current window
```

**Method 2: Floating Window**
```
Press: Space -
Opens parent directory in floating popup
```

### What You'll See

When you open Oil, you'll see something like:
```
../
init.lua
lua/
docs/
README.md
Makefile
.gitignore
```

**Understanding the display:**
- `../` - Parent directory (go up one level)
- Items ending with `/` - Directories
- Other items - Files
- Hidden files (starting with `.`) - Hidden by default

---

## Basic Navigation

Oil uses **standard Vim motions** - no special keys to learn!

### Moving Around

```
j or Down arrow       Move down to next file/folder
k or Up arrow         Move up to previous file/folder
gg                    Go to top of list
G                     Go to bottom of list
/pattern              Search for file/folder name
```

### Entering and Exiting Directories

```
Enter or <CR>         Open file or enter directory
-                     Go to parent directory
_                     Go to current working directory
```

### Closing Oil

```
q                     Close oil window
<C-c>                 Close oil window (alternative)
```

### Example Navigation Flow

```
Starting in: ~/projects/myapp/

1. Press - to open oil
2. See list of files in ~/projects/myapp/
3. Navigate to src/ with j/k
4. Press Enter to enter src/ directory
5. Press - to go back to parent
6. Press q to close oil
```

---

## Creating Files and Folders

**Key concept:** Create files/folders by inserting new lines and typing names.

### Create a Single File

```
1. Press - to open oil
2. Press o (open line below)
3. Type filename: "newfile.lua"
4. Press Esc
5. Press :w to create the file
```

**Important:** The file is NOT created until you save with `:w`!

### Create a Folder

```
1. Press - to open oil
2. Press o
3. Type folder name WITH trailing slash: "newfolder/"
4. Press Esc
5. Press :w to create the folder
```

**Note the trailing `/`** - This tells Oil you want a directory, not a file.

### Create Multiple Files at Once

```
1. Press - to open oil
2. Press o and type "file1.lua", press Esc
3. Press o and type "file2.lua", press Esc
4. Press o and type "file3.lua", press Esc
5. Press :w → All three files created at once!
```

### Create Nested Structure

```
Want to create: newfolder/subfile.lua

1. Press - to open oil
2. Press o and type "newfolder/", press Esc
3. Press :w to create the folder
4. Press Enter on newfolder/ to enter it
5. Press o and type "subfile.lua", press Esc
6. Press :w to create the file
```

---

## Renaming Files

**Key concept:** Rename files using Vim's change commands (cw, c$, etc.)

### Rename Single File

**Method 1: Change whole name (cw)**
```
1. Press - to open oil
2. Navigate to the file with j/k
3. Press cw (change word)
4. Type new name
5. Press Esc
6. Press :w to apply rename
```

**Method 2: Change part of name**
```
1. Press - to open oil
2. Navigate to file: "old_name.lua"
3. Press w to move to end (if needed)
4. Press ciw (change inner word) to change part
5. Type new text
6. Press Esc
7. Press :w
```

**Method 3: Append to name**
```
1. Press - to open oil
2. Navigate to file: "test.lua"
3. Press $ to go to end of name
4. Press i to insert before extension
5. Type addition: "_final"
6. Result: "test_final.lua"
7. Press Esc and :w
```

### Rename Multiple Files

```
Scenario: Rename multiple test files to spec files

1. Press - to open oil
2. Navigate to "test_user.lua"
3. Press cw, type "spec_user.lua", press Esc
4. Navigate to "test_post.lua"
5. Press cw, type "spec_post.lua", press Esc
6. Navigate to "test_auth.lua"
7. Press cw, type "spec_auth.lua", press Esc
8. Press :w → All renamed at once!
```

### Change File Extension

```
Change: script.js → script.ts

1. Press - to open oil
2. Navigate to "script.js"
3. Press $ to end of line
4. Press 2h to move before "js"
5. Press cw, type "ts", press Esc
6. Press :w
```

---

## Deleting Files

**Key concept:** Mark files for deletion with `dd`, then confirm with `:w`

### Delete Single File

```
1. Press - to open oil
2. Navigate to file you want to delete
3. Press dd (delete line)
4. Press :w to permanently delete
```

**Visual feedback:**
```
Before dd:         After dd:
init.lua           init.lua
old_file.lua       test.lua    ← old_file.lua removed from view
test.lua
```

The file is marked for deletion but not deleted until you `:w`!

### Delete Multiple Files

```
1. Press - to open oil
2. Navigate to first unwanted file
3. Press dd
4. Navigate to second unwanted file
5. Press dd
6. Navigate to third unwanted file
7. Press dd
8. Press :w → All three deleted at once!
```

### Delete a Folder

```
Warning: Deleting a non-empty folder will delete ALL contents!

1. Press - to open oil
2. Navigate to folder: "old_feature/"
3. Press dd
4. Press :w
5. Folder and all contents deleted
```

### Undo Accidental Deletion (Before Saving)

```
1. Accidentally press dd on important file
2. Press u (undo) immediately
3. File line reappears
4. No harm done (nothing saved yet)
```

**Important:** You can undo deletions with `u` **before** you save with `:w`.
After `:w`, the files are permanently deleted!

---

## Copying and Moving Files

### Copy a File (Duplicate)

```
1. Press - to open oil
2. Navigate to file you want to copy
3. Press yy (yank/copy line)
4. Press p (paste below)
5. Cursor moves to pasted line
6. Press cw to rename the copy
7. Type new name
8. Press Esc
9. Press :w → Copy created!
```

**Example:**
```
Want to copy: config.lua → config.backup.lua

1. Press - to open oil
2. Navigate to config.lua
3. Press yy
4. Press p
5. Press cw, type "config.backup.lua"
6. Press :w
```

### Copy Multiple Files

```
1. Press - to open oil
2. Navigate to first file
3. Press yy
4. Navigate to second file
5. Press yy
6. Press p (pastes last copied)
7. Or use visual mode (see Working with Multiple Files)
```

### Move File to Another Directory

**Method 1: Cut and paste in Oil**
```
Cannot directly move between directories in Oil.
Use this workflow instead:
1. Copy file to new location (yy, navigate, p)
2. Delete from old location (dd on original)
3. Press :w
```

**Method 2: Rename with path (recommended)**
```
Move: src/old.lua → lib/old.lua

1. Press - in src/ directory
2. Navigate to old.lua
3. Press cw
4. Type "../lib/old.lua"
5. Press Esc
6. Press :w → File moved!
```

---

## Working with Multiple Files

### Visual Mode Selection

**Select multiple lines (files) at once:**

```
1. Press - to open oil
2. Navigate to first file
3. Press V (enter visual line mode)
4. Press j/k to select multiple files
5. Press d to mark all for deletion
   OR
   Press y to copy all
6. Press Esc
7. Press :w if deleting, or p if pasting
```

**Example: Delete 5 files at once**
```
1. Press - to open oil
2. Navigate to first unwanted file
3. Press V
4. Press 4j (select 5 lines total)
5. Press d
6. Press :w → All 5 deleted!
```

### Using Counts

```
Delete 3 files:
1. Navigate to first file
2. Press 3dd (delete 3 lines)
3. Press :w

Copy 5 files:
1. Navigate to first file
2. Press 5yy (yank 5 lines)
3. Press p (paste all 5)
4. Press :w
```

---

## Opening Files in Different Ways

Once you're in Oil, you can open files in various ways:

### Open in Current Window

```
Enter or <CR>         Open file/directory in current window
```

### Open in Split

```
<C-v>                 Open file in vertical split
<C-x>                 Open file in horizontal split
```

**Example workflow:**
```
1. Press - to open oil
2. Navigate to file.lua with j/k
3. Press <C-v>
4. File opens in vertical split
5. Original window now shows your code
```

### Open in New Tab

```
<C-t>                 Open file in new tab
```

### Preview File Without Opening

```
<C-p>                 Preview file in floating window
```

**Use case:**
```
1. Press - to open oil
2. Navigate through files with j/k
3. Press <C-p> on each to preview contents
4. Find the file you want
5. Press Enter to open it
```

---

## Advanced Features

### Toggle Hidden Files

```
g.                    Toggle showing hidden files (starting with .)
```

**Example:**
```
1. Press - to open oil
2. Don't see .gitignore?
3. Press g.
4. Hidden files now visible!
```

### Change Sort Order

```
gs                    Cycle through sort orders
                      (name, size, type, modification time)
```

### Go to Specific Directory

```
_                     Go to current working directory (where you started nvim)
`                     Change Neovim's working directory to current oil directory
```

**Use case:**
```
You're deep in: ~/project/src/components/ui/

1. Press _
2. Jump back to ~/project/ (where you started nvim)
```

### Show Help

```
g?                    Show all available keymaps
```

Press `g?` anytime in Oil to see a help window with all commands!

### Open File with External Program

```
gx                    Open file with system default program
```

**Example:**
```
1. Navigate to image.png
2. Press gx
3. Opens in your system's image viewer (Preview on Mac, etc.)
```

---

## Common Workflows

### Workflow 1: Reorganize Project Files

**Goal:** Move files between directories

```
1. Press - to open oil in src/
2. Navigate to old_component.lua
3. Press cw
4. Type "../archive/old_component.lua"
5. Press Esc
6. Navigate to another file to move
7. Press cw and type new path
8. Press :w → All files moved!
```

### Workflow 2: Create Feature Directory Structure

**Goal:** Create new feature with multiple files

```
Want to create:
feature/
├── init.lua
├── handler.lua
└── utils.lua

1. Press - to open oil
2. Press o, type "feature/", press Esc
3. Press :w (create folder)
4. Press Enter to enter feature/
5. Press o, type "init.lua", press Esc
6. Press o, type "handler.lua", press Esc
7. Press o, type "utils.lua", press Esc
8. Press :w → All files created!
```

### Workflow 3: Cleanup Old Files

**Goal:** Delete multiple old/temp files

```
1. Press - to open oil
2. Navigate to temp_1.lua
3. Press dd
4. Navigate to temp_2.lua
5. Press dd
6. Navigate to old_backup.lua
7. Press dd
8. Press :w → All deleted!
```

### Workflow 4: Duplicate Configuration File

**Goal:** Create backup of config file

```
1. Press - to open oil
2. Navigate to config.lua
3. Press yy (copy)
4. Press p (paste)
5. Press cw, type "config.backup.lua"
6. Press Esc
7. Press :w → Backup created!
```

### Workflow 5: Batch Rename Files

**Goal:** Rename test files to spec files

```
Have: test_user.lua, test_post.lua, test_auth.lua
Want: spec_user.lua, spec_post.lua, spec_auth.lua

1. Press - to open oil
2. Navigate to test_user.lua
3. Press w to move to "user" part
4. Press b to go back to start
5. Press cw, type "spec", press Esc
6. Repeat for other files
7. Press :w → All renamed!
```

### Workflow 6: Quick File Creation While Coding

**Goal:** Create new file without leaving Neovim

```
Scenario: You're coding and realize you need a new utils file

1. Press - (opens oil in current directory)
2. Press o, type "utils.lua", press Esc
3. Press :w (file created)
4. Press Enter on utils.lua
5. Start coding in new file!
```

---

## Keyboard Shortcuts Reference

### Opening Oil
```
-               Open oil in current window (parent directory)
Space -         Open oil in floating window
```

### Navigation
```
j / k           Move down/up
gg / G          Go to top/bottom
Enter           Open file or enter directory
-               Go to parent directory
_               Go to working directory
q / <C-c>       Close oil
```

### Creating Files/Folders
```
o               Open line below (then type name)
O               Open line above (then type name)
:w              Save changes (creates files/folders)

Remember: End with / for folders: "newfolder/"
```

### Editing Files
```
cw              Change whole filename
dd              Delete file (mark for deletion)
yy              Copy file
p               Paste file
u               Undo changes (before :w)
:w              Save all changes (applies operations)
```

### Opening Files
```
Enter           Open in current window
<C-v>           Open in vertical split
<C-x>           Open in horizontal split
<C-t>           Open in new tab
<C-p>           Preview file (floating window)
```

### Advanced
```
g?              Show help with all keymaps
g.              Toggle hidden files
gs              Change sort order
gx              Open with external program
`               Change vim's working directory to here
```

---

## Important Safety Notes

### Changes Are Not Immediate

**All changes are buffered until you save with `:w`**

This means:
- You can undo mistakes with `u` before saving
- You can see all changes before applying them
- Multiple operations happen atomically when you save

**Example:**
```
1. Press dd on file1 (marked for deletion)
2. Press u (undo - file1 unmarked)
3. Nothing was actually deleted!

VS

1. Press dd on file1 (marked for deletion)
2. Press :w (file1 is now PERMANENTLY deleted)
3. Cannot undo - file is gone!
```

### Deleting Directories

**Be careful!** Deleting a directory with `dd` will delete ALL contents
recursively.

**Best practice:**
```
Before deleting a folder:
1. Press Enter to look inside
2. Check what's in there
3. Press - to go back
4. Now press dd if you're sure
5. Press :w
```

### No Trash/Recycle Bin

**Oil deletes files permanently** (by default).

If you want safer deletion, you can enable trash in the config, but this
configuration uses permanent deletion to keep things simple.

**Best practice:** Check twice before pressing `:w` after `dd`!

---

## Comparison with Command Line

**Traditional way (command line):**
```bash
# Create files
touch file1.lua file2.lua file3.lua

# Rename files
mv old_name.lua new_name.lua
mv test.lua ../archive/test.lua

# Delete files
rm file1.lua file2.lua file3.lua

# Copy files
cp config.lua config.backup.lua
```

**Oil.nvim way (inside Neovim):**
```
# Create files
- o "file1.lua" Esc
  o "file2.lua" Esc
  o "file3.lua" Esc
  :w

# Rename files
- cw "new_name.lua" Esc :w
  cw "../archive/test.lua" Esc :w

# Delete files
- dd dd dd :w

# Copy files
- yy p cw "config.backup.lua" Esc :w
```

**Advantages of Oil:**
- Never leave Neovim
- See all changes before applying
- Use familiar Vim motions
- Undo before saving
- Batch operations

---

## Practice Exercises

### Exercise 1: Create Files

```
1. Press - to open oil
2. Create three files: "test1.lua", "test2.lua", "test3.lua"
3. Save with :w
4. Verify they were created by reopening oil
```

### Exercise 2: Rename File

```
1. Press - to open oil
2. Find one of your test files
3. Rename it to "renamed.lua"
4. Save with :w
```

### Exercise 3: Copy and Modify

```
1. Press - to open oil
2. Copy "renamed.lua" to "renamed.backup.lua"
3. Save with :w
4. Verify you now have both files
```

### Exercise 4: Delete Files

```
1. Press - to open oil
2. Delete all the test files you created
3. Save with :w
4. Verify they're gone
```

### Exercise 5: Create Directory Structure

```
1. Create this structure:
   practice/
   ├── src/
   │   └── main.lua
   └── test/
       └── test.lua

2. Use oil to create all folders and files
3. Navigate between directories
4. Verify the structure is correct
```

---

## Troubleshooting

**Q: I pressed dd but the file is still there?**
A: You need to save with `:w` to apply the deletion.

**Q: I accidentally deleted a file, how do I undo?**
A: Press `u` immediately (if you haven't saved yet). If you already saved with
`:w`, the file is permanently gone.

**Q: Oil shows "No changes to save" when I press :w?**
A: You haven't made any changes to the filesystem. Make sure you edited
filenames, pressed dd, or added new lines before saving.

**Q: How do I create a folder inside a folder?**
A: You can either:
1. Create parent folder, :w, Enter to go in, create child folder, :w
2. Or type the full path: "parent/child/" in one line

**Q: Can I move files to a different drive/partition?**
A: Oil works best within the same filesystem. For moving between drives, use
traditional command-line tools or file managers.

**Q: The file I created doesn't have any content?**
A: Correct! Oil only creates empty files. After creating the file:
1. Press Enter to open it
2. Start editing with `i` (insert mode)
3. Write your content
4. Save with `:w`

---

## See Also

- [Basic Navigation](./01-basic-navigation.md) - Vim motions used in Oil
- [Editing Basics](./02-editing-basics.md) - Commands like dd, yy, p, cw
- [Multi-File Navigation](./04-multi-file-navigation.md) - Opening multiple files

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
