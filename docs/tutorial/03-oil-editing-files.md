# Editing Files with Oil.nvim

Learn how to rename, delete, copy, and move files using Oil's buffer-based approach.

## Prerequisites

Complete these first:
- [What is Oil.nvim?](./03-oil-introduction.md)
- [Creating Files and Folders](./03-oil-creating-files.md)

---

## Renaming Files

**Key concept:** Rename files using Vim's change commands (`cw`, `c$`, etc.)

### Rename Entire Filename

**Method 1: Change whole name (cw)**
```
1. Press - to open oil
2. Navigate to the file with j/k
3. Press cw (change word)
4. Type new name
5. Press Esc
6. Press :w to apply rename
```

**Visual example:**
```
Before:                 After cw + typing:      After :w:
─────────────────       ─────────────────       ─────────────────
../                     ../                     ../
old_name.lua            newname.lua ← typed     newname.lua ← renamed!
test.lua                test.lua                test.lua
```

---

### Rename Part of Filename

**Method 2: Change to end of name (c$)**
```
Scenario: config.lua → config.backup.lua

1. Press - to open oil
2. Navigate to "config.lua"
3. Move cursor to after "config" (use w or f.)
4. Press c$ (change to end of line)
5. Type ".backup.lua"
6. Press Esc and :w
```

**Visual:**
```
Before:          Cursor position:      After c$:         After typing:
config.lua       config|.lua           config|           config.backup.lua
```

---

### Change File Extension

**Scenario:** Change `script.js` → `script.ts`

```
1. Press - to open oil
2. Navigate to "script.js"
3. Press $ (go to end of line)
4. Press 2h (move left 2 characters to before "js")
5. Press cw (change word)
6. Type "ts"
7. Press Esc and :w
```

**Alternative method:**
```
1. Navigate to "script.js"
2. Press /js<Enter> (search for "js")
3. Press cw, type "ts", Esc
4. Press :w
```

---

### Batch Rename Multiple Files

**Scenario:** Rename multiple test files to spec files

```
Have: test_user.lua, test_post.lua, test_auth.lua
Want: spec_user.lua, spec_post.lua, spec_auth.lua
```

**Steps:**
```
1. Press - to open oil
2. Navigate to "test_user.lua"
3. Press w (move to "user")
4. Press b (go back to start of "test")
5. Press cw, type "spec", press Esc
6. Navigate to "test_post.lua"
7. Repeat steps 3-5
8. Navigate to "test_auth.lua"
9. Repeat steps 3-5
10. Press :w → All renamed at once!
```

**Pro tip:** All changes happen atomically when you save!

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
Before dd:         After dd (before :w):    After :w:
─────────────────  ─────────────────       ─────────────────
init.lua           init.lua                init.lua
old_file.lua       test.lua ← moved up     test.lua ← only two files left
test.lua
```

**Important:** File is marked for deletion but not deleted until you `:w`!

---

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

**Efficient with visual mode:**
```
1. Navigate to first file
2. Press V (visual line mode)
3. Press j/k to select multiple files
4. Press d (delete selection)
5. Press :w
```

---

### Delete a Folder

**Warning:** Deleting a non-empty folder will delete ALL contents recursively!

```
1. Press - to open oil
2. Navigate to folder: "old_feature/"
3. Press dd
4. Press :w
5. Folder and all contents deleted permanently
```

**Best practice before deleting a folder:**
```
1. Press Enter to look inside
2. Check what's in there
3. Press - to go back
4. Now press dd if you're sure
5. Press :w
```

---

### Undo Accidental Deletion (Before Saving)

```
1. Accidentally press dd on important.lua
2. Press u (undo) immediately
3. File line reappears
4. No harm done (nothing saved yet)
```

**Critical:** You can undo deletions with `u` **before** you save with `:w`. After `:w`, the files are permanently gone!

---

## Copying Files

**Key concept:** Use `yy` (yank) and `p` (paste) like copying lines in a buffer

### Duplicate a File

**Scenario:** Create a backup of config.lua

```
1. Press - to open oil
2. Navigate to file you want to copy
3. Press yy (yank/copy line)
4. Press p (paste below)
5. Cursor moves to pasted line
6. Press cw to rename the copy
7. Type new name: "config.backup.lua"
8. Press Esc
9. Press :w → Copy created!
```

**Visual:**
```
Before yy:          After yy + p:           After rename + :w:
─────────────────   ─────────────────      ─────────────────
config.lua          config.lua              config.lua
README.md           config.lua ← pasted     config.backup.lua ← renamed copy
                    README.md               README.md
```

---

### Copy Multiple Files

**Method 1: Visual mode**
```
1. Press - to open oil
2. Navigate to first file
3. Press V (visual line mode)
4. Press j to select multiple files
5. Press y (yank selection)
6. Press p (paste all)
7. Rename each if needed
8. Press :w
```

**Method 2: Count**
```
1. Navigate to first file
2. Press 3yy (yank 3 lines)
3. Press p (paste 3 files)
4. Press :w
```

---

## Moving Files

**Key concept:** Rename with path to move files

### Move File to Another Directory

**Method 1: Rename with relative path**
```
Move: src/old.lua → lib/old.lua

1. Press - in src/ directory
2. Navigate to old.lua
3. Press cw
4. Type "../lib/old.lua"
5. Press Esc
6. Press :w → File moved!
```

**Method 2: Rename with absolute path**
```
1. Navigate to file
2. Press cw
3. Type full path: "/Users/name/project/lib/old.lua"
4. Press Esc
5. Press :w
```

---

### Move Multiple Files

**Scenario:** Move several files to archive/ folder

```
1. Press - to open oil
2. Navigate to first file
3. Press cw, type "../archive/file1.lua", Esc
4. Navigate to second file
5. Press cw, type "../archive/file2.lua", Esc
6. Navigate to third file
7. Press cw, type "../archive/file3.lua", Esc
8. Press :w → All three moved at once!
```

**Pro tip:** Oil creates the target directory if it doesn't exist!

---

## Working with Multiple Files

### Use Visual Mode for Bulk Operations

**Select multiple files:**
```
1. Press - to open oil
2. Navigate to first file
3. Press V (visual line mode)
4. Press j/k to select multiple files
5. Press d (delete), y (yank), or use other operations
6. Press :w
```

**Example: Delete 5 files at once**
```
1. Navigate to first unwanted file
2. Press V
3. Press 4j (select 5 lines total)
4. Press d
5. Press :w → All 5 deleted!
```

---

### Use Counts

**Delete 3 files:**
```
1. Navigate to first file
2. Press 3dd (delete 3 lines)
3. Press :w
```

**Copy 5 files:**
```
1. Navigate to first file
2. Press 5yy (yank 5 lines)
3. Press p (paste all 5)
4. Press :w
```

---

## Opening Files Different Ways

### Open in Current Window

```
Enter           Open file in current window
```

---

### Open in Splits

```
<C-v>           Open file in vertical split
<C-x>           Open file in horizontal split
```

**Example workflow:**
```
1. Press - to open oil
2. Navigate to file.lua
3. Press <C-v>
4. File opens in new vertical split
5. You can see oil and file side by side
```

---

### Open in New Tab

```
<C-t>           Open file in new tab
```

---

### Preview File Without Opening

```
<C-p>           Preview file in floating window
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

## Practice Exercises

### Exercise 1: Rename a File

```
Task: Rename "test.lua" to "renamed.lua"

Steps:
1. Press - to open oil
2. Find test.lua
3. Press cw, type "renamed.lua", press Esc
4. Press :w
5. Verify the change
```

---

### Exercise 2: Copy and Modify

```
Task: Create a backup copy of a file

Steps:
1. Press - to open oil
2. Navigate to any file
3. Press yy (copy)
4. Press p (paste)
5. Press cw, add ".backup" before extension
6. Press :w
7. Verify you have both original and backup
```

---

### Exercise 3: Delete Multiple Files

```
Task: Create 3 test files, then delete them all

Steps:
1. Create test1.lua, test2.lua, test3.lua (refer to creating files tutorial)
2. Press - to reopen oil
3. Navigate to test1.lua
4. Press V (visual mode)
5. Press 2j (select all 3)
6. Press d (delete)
7. Press :w
8. Verify they're gone
```

---

### Exercise 4: Move a File

```
Task: Move a file to a subdirectory

Steps:
1. Create a file: "moveme.lua"
2. Create a folder: "archive/"
3. Press - to open oil
4. Navigate to moveme.lua
5. Press cw, type "archive/moveme.lua"
6. Press :w
7. Press Enter on archive/ to verify file is there
```

---

## Troubleshooting

### Q: I pressed dd but the file is still there?

**A:** You need to save with `:w` to apply the deletion. The file is only marked for deletion until you save.

---

### Q: I accidentally deleted a file, how do I undo?

**A:** Press `u` immediately (if you haven't saved yet). If you already saved with `:w`, the file is permanently gone.

---

### Q: Can I move files to a different drive/partition?

**A:** Oil works best within the same filesystem. For moving between drives, use traditional command-line tools.

---

### Q: The file I created has no content?

**A:** Correct! Oil only creates empty files.

**To add content:**
```
1. Press Enter to open the file
2. Press i (insert mode)
3. Write your content
4. Press :w to save content
```

---

## Quick Reference

```
╔══════════════════════════════════════════════════════╗
║              EDITING FILES WITH OIL                  ║
╠══════════════════════════════════════════════════════╣
║ RENAMING:                                           ║
║ cw              Change whole filename               ║
║ c$              Change to end of name               ║
║ ciw             Change inner word                   ║
║                                                     ║
║ DELETING:                                           ║
║ dd              Delete file (mark for deletion)     ║
║ Vj...d          Visual select + delete multiple     ║
║ 3dd             Delete 3 files                      ║
║                                                     ║
║ COPYING:                                            ║
║ yy              Yank (copy) file                    ║
║ p               Paste file                          ║
║ 3yy             Yank 3 files                        ║
║                                                     ║
║ MOVING:                                             ║
║ cw              Change name to path: "../other/file"║
║                                                     ║
║ OPENING:                                            ║
║ Enter           Open in current window              ║
║ <C-v>           Open in vertical split              ║
║ <C-x>           Open in horizontal split            ║
║ <C-t>           Open in new tab                     ║
║ <C-p>           Preview file                        ║
║                                                     ║
║ APPLYING CHANGES:                                   ║
║ :w              Save (applies all operations)       ║
║ u               Undo (before :w)                    ║
╚══════════════════════════════════════════════════════╝
```

---

## Next Steps

Now that you can edit files:

- **[Common Workflows](./03-oil-workflows.md)** - Real-world usage patterns and tips

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
