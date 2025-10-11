# Common Oil.nvim Workflows

Real-world usage patterns, tips, and advanced workflows for Oil.nvim file management.

## Prerequisites

Complete these first:
- [What is Oil.nvim?](./03-oil-introduction.md)
- [Creating Files](./03-oil-creating-files.md)
- [Editing Files](./03-oil-editing-files.md)

---

## Workflow 1: Quick File Creation While Coding

**Scenario:** You're coding and realize you need a new utils file

```
You're editing main.lua and think: "I need a utils.lua file"
```

**Steps:**
```
1. Press - (opens oil in current directory)
2. Press o, type "utils.lua", press Esc
3. Press :w (file created)
4. Press Enter on utils.lua
5. Start coding in new file!
```

**Why this is fast:** No leaving Neovim, no terminal commands!

---

## Workflow 2: Reorganize Project Files

**Scenario:** Move files between directories to restructure project

```
Want to move:
- src/old_component.lua → archive/old_component.lua
- src/temp.lua → archive/temp.lua
```

**Steps:**
```
1. Press - to open oil in src/
2. Navigate to old_component.lua
3. Press cw, type "../archive/old_component.lua", Esc
4. Navigate to temp.lua
5. Press cw, type "../archive/temp.lua", Esc
6. Press :w → Both files moved!
```

**Benefit:** Batch operation - both moves happen atomically.

---

## Workflow 3: Create Feature Directory Structure

**Scenario:** Create a new feature with standard structure

**Want to create:**
```
user_auth/
├── init.lua
├── controller.lua
├── model.lua
└── tests/
    └── test_auth.lua
```

**Steps:**
```
1. Press - to open oil
2. Press o, type "user_auth/", Esc, :w
3. Press Enter on user_auth/ (enter folder)
4. Press o, type "init.lua", Esc
5. Press o, type "controller.lua", Esc
6. Press o, type "model.lua", Esc
7. Press o, type "tests/", Esc
8. Press :w (creates 3 files + 1 folder)
9. Press Enter on tests/
10. Press o, type "test_auth.lua", Esc
11. Press :w
```

**Result:** Clean project structure created in seconds!

---

## Workflow 4: Cleanup Old Files

**Scenario:** Delete multiple temporary/old files

```
Files to delete:
- temp_1.lua
- temp_2.lua
- old_backup.lua
- debug_log.txt
```

**Steps:**
```
1. Press - to open oil
2. Navigate to temp_1.lua
3. Press V (visual line mode)
4. Press j to select temp_2.lua
5. Press j to select old_backup.lua
6. Press j to select debug_log.txt
7. Press d (delete selection)
8. Press :w → All 4 deleted!
```

**Alternative with search:**
```
1. Press - to open oil
2. Type /temp<Enter> (jumps to first "temp")
3. Press dd
4. Type n (next match)
5. Press dd
6. Repeat for other files
7. Press :w
```

---

## Workflow 5: Duplicate and Modify Configuration

**Scenario:** Create backup of config, then modify original

```
Have: config.lua
Want: config.lua (modified) + config.backup.lua (original)
```

**Steps:**
```
1. Press - to open oil
2. Navigate to config.lua
3. Press yy (copy)
4. Press p (paste)
5. Press cw, type "config.backup.lua", Esc
6. Press :w (backup created)
7. Press Enter on config.lua (open original)
8. Modify as needed
9. Press :w to save modifications
```

**Result:** Original backed up, safe to modify!

---

## Workflow 6: Batch Rename with Pattern

**Scenario:** Rename all test files to spec files

```
Have:
- test_user.lua
- test_post.lua
- test_auth.lua

Want:
- spec_user.lua
- spec_post.lua
- spec_auth.lua
```

**Steps:**
```
1. Press - to open oil
2. Navigate to test_user.lua
3. Press /test<Enter> (search for "test")
4. Press cw, type "spec", press Esc
5. Press n (next match)
6. Press . (dot - repeat last change)
7. Press n, then .
8. Press :w → All renamed!
```

**Magic:** The dot (`.`) command repeats your last change!

---

## Workflow 7: Quick Peek at Multiple Files

**Scenario:** Browse files to find the right one

```
You have 10 files and want to find the one with specific code
```

**Steps:**
```
1. Press Space - (floating oil window)
2. Navigate to first file
3. Press <C-p> (preview file content)
4. Press j (next file)
5. Press <C-p> (preview)
6. Repeat until you find it
7. Press Enter to open the right file
8. Or press q if you didn't find it
```

**Benefit:** Preview without opening, no clutter!

---

## Workflow 8: Safe Directory Deletion

**Scenario:** Delete a directory but check contents first

```
Want to delete: old_feature/
```

**Steps:**
```
1. Press - to open oil
2. Navigate to old_feature/
3. Press Enter (look inside)
4. Check files: "yep, these can all go"
5. Press - (go back to parent)
6. Navigate to old_feature/
7. Press dd
8. Press :w → Folder and contents deleted
```

**Best practice:** Always check before deleting folders!

---

## Workflow 9: Split View File Management

**Scenario:** Organize files while viewing code

```
Want to reorganize files while seeing your code
```

**Steps:**
```
1. Open your code file normally
2. Press :vsplit<Enter> (vertical split)
3. In new split, press - (open oil)
4. Now you have code on left, file manager on right
5. Organize files while viewing code
6. Press <C-w>h to go back to code
7. Press <C-w>l to go back to oil
```

**Benefit:** Context-aware file management!

---

## Workflow 10: Advanced - Copy Files Between Projects

**Scenario:** Copy a file from another project

```
Current project: ~/project-a/
Want to copy from: ~/project-b/utils.lua
```

**Steps:**
```
1. In project-a, press - to open oil
2. Press o, type "~/project-b/utils.lua", Esc
3. Press :w
4. Oil copies the file!
5. Optionally rename: cw, type "utils_imported.lua"
6. Press :w
```

**Note:** This creates a copy in your current directory.

---

## Advanced Features

### Toggle Hidden Files

```
g.              Toggle showing hidden files
```

**Use case:**
```
1. Press - to open oil
2. Don't see .gitignore?
3. Press g.
4. Hidden files now visible!
5. Press g. again to hide
```

---

### Change Sort Order

```
gs              Cycle through sort orders
                (name, size, type, modification time)
```

**Use case:**
```
1. Press gs (sort by size)
2. Press gs (sort by type)
3. Press gs (sort by time)
4. Press gs (back to name)
```

---

### Go to Specific Directory

```
_               Go to working directory (where nvim started)
`               Change vim's CWD to current oil directory
```

**Use case:**
```
You're deep in: ~/project/src/components/ui/

Press _ → Jump back to ~/project/ instantly!
```

---

### Show Help

```
g?              Show all available keymaps
```

Press `g?` anytime in Oil to see a help window with all commands!

---

### Open File with External Program

```
gx              Open file with system default program
```

**Example:**
```
1. Navigate to image.png
2. Press gx
3. Opens in Preview (Mac) or default image viewer
```

---

## Tips for Mastery

### Tip 1: Use Oil for All File Operations

**Instead of:**
```bash
# Terminal
mkdir new_feature
cd new_feature
touch init.lua
touch handler.lua
```

**Use Oil:**
```
- o "new_feature/" :w
Enter
o "init.lua" Esc
o "handler.lua" Esc
:w
```

**Benefit:** Never leave Neovim!

---

### Tip 2: Leverage Undo Before Saving

**Safety net:**
```
1. Make changes (rename, delete, create)
2. Review what you did
3. Press u if you made a mistake
4. Only press :w when you're sure
```

**This is Oil's superpower:** See and undo before committing!

---

### Tip 3: Combine with Leap for Speed

**If you have Leap.nvim installed:**
```
1. Press - to open oil
2. Press s (leap)
3. Type first 2 chars of target file
4. Press label
5. Instantly at the right file!
```

**Much faster than:** Pressing j/k 20 times!

---

### Tip 4: Use Visual Mode for Bulk Operations

**Pattern:**
```
1. Press V (visual line mode)
2. Select multiple files with j/k
3. Apply operation (d, y, etc.)
4. Press :w
```

**Always think:** "Can I do this in one batch operation?"

---

### Tip 5: Keep a Floating Oil Window Open

**Workflow:**
```
1. Press Space - (floating oil)
2. Do file operations
3. Press q (close when done)
4. Your code view is never disrupted!
```

**Use floating oil for:** Quick peeks and small changes.

**Use regular oil (-):** When you need full-screen file management.

---

## Common Patterns Cheat Sheet

```
╔════════════════════════════════════════════════════════╗
║              OIL COMMON PATTERNS                       ║
╠════════════════════════════════════════════════════════╣
║ Quick create file       - → o → filename → :w         ║
║ Backup file             - → yy → p → rename → :w      ║
║ Move file               - → cw → path → :w            ║
║ Delete multiple         - → V → jjj → d → :w          ║
║ Reorganize              - → multiple cw → :w          ║
║ Safe folder delete      - → Enter → check → - → dd →  :w║
║ Preview files           Space - → j → <C-p> → ...     ║
║ Batch rename            - → cw → n → . → n → . → :w   ║
╚════════════════════════════════════════════════════════╝
```

---

## Safety Checklist

Before pressing `:w`, verify:

- ✅ File names are correct (no typos)
- ✅ Paths are correct (files won't go to wrong directory)
- ✅ You really want to delete those files
- ✅ Folder deletions are intentional (check contents first)
- ✅ No accidental renames that would break imports

**Remember:** You can always press `u` before `:w`!

---

## Comparison: Oil vs Terminal

### Creating Project Structure

**Terminal:**
```bash
mkdir -p feature/{src,tests}
touch feature/src/init.lua
touch feature/src/handler.lua
touch feature/tests/test.lua
```

**Oil:**
```
- o "feature/" :w
Enter
o "src/" Esc
o "tests/" Esc
:w
Enter on src/
o "init.lua" Esc o "handler.lua" Esc :w
- Enter on tests/
o "test.lua" Esc :w
```

**Oil advantages:**
- Visual feedback
- See structure as you build
- Easy to undo mistakes
- Never leave Neovim

---

## Troubleshooting Workflows

### Q: I made many changes and want to review before saving?

**A:** Oil shows all changes in the buffer. Scroll through and review:
```
1. Look at renamed files (different names)
2. Missing lines = deleted files
3. New lines = created files
4. Press u to undo individual changes
5. Press :w when satisfied
```

---

### Q: Can I split operations across multiple :w saves?

**A:** Yes! Example:
```
1. Create files, press :w
2. Rename files, press :w
3. Delete files, press :w
```

Each `:w` applies only the current batch of changes.

---

### Q: How do I know if Oil will overwrite a file?

**A:** Oil won't let you create duplicate names. If you try:
```
1. Type "existing.lua" (file exists)
2. Press :w
3. Oil shows error: "file exists"
4. You must manually overwrite (use cw to rename first)
```

---

## Next Steps

You've mastered Oil.nvim workflows! Continue learning:

- [Basic Navigation with Leap](./01-leap-what-and-why.md) - Move faster in files
- [Multi-File Navigation](./04-multi-file-navigation.md) - Jump between files
- [Telescope Mastery](./08-telescope-mastery.md) - Find files and content

---

## Quick Reference: All Oil Commands

```
╔══════════════════════════════════════════════════════╗
║              COMPLETE OIL REFERENCE                  ║
╠══════════════════════════════════════════════════════╣
║ OPENING:                                            ║
║ -              Open in current window               ║
║ Space -        Open in floating window              ║
║                                                     ║
║ NAVIGATION:                                         ║
║ j/k            Move down/up                         ║
║ gg/G           Top/bottom                           ║
║ Enter          Open file/enter directory            ║
║ -              Go to parent                         ║
║ _              Go to working directory              ║
║ q              Close oil                            ║
║                                                     ║
║ CREATING:                                           ║
║ o/O            Open line below/above                ║
║ [name]         Type filename                        ║
║ [name/]        Type foldername with /               ║
║                                                     ║
║ EDITING:                                            ║
║ cw/c$/ciw      Rename (change)                      ║
║ dd             Delete file                          ║
║ yy             Copy file                            ║
║ p              Paste file                           ║
║                                                     ║
║ OPENING FILES:                                      ║
║ Enter          Current window                       ║
║ <C-v>          Vertical split                       ║
║ <C-x>          Horizontal split                     ║
║ <C-t>          New tab                              ║
║ <C-p>          Preview                              ║
║                                                     ║
║ ADVANCED:                                           ║
║ g.             Toggle hidden files                  ║
║ gs             Change sort order                    ║
║ g?             Show help                            ║
║ gx             Open with external program           ║
║ `              Change vim CWD to here               ║
║                                                     ║
║ APPLYING:                                           ║
║ :w             Save (apply all operations)          ║
║ u              Undo (before :w)                     ║
╚══════════════════════════════════════════════════════╝
```

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
