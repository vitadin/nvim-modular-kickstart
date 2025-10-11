# What is Oil.nvim?

Learn about Oil.nvim - a revolutionary file manager that lets you edit your filesystem like a text buffer.

---

## What is Oil.nvim?

Oil.nvim is a **file manager that works like a text buffer**. Instead of using special commands to manipulate files, you edit them like text and save your changes.

**Key concept:** Your filesystem becomes a text buffer that you can edit with normal Vim commands.

### The Core Philosophy

**Traditional file managers:**
```
Click file → Click delete → Click confirm → File deleted
```

**Oil.nvim:**
```
Press dd → Press :w → File deleted
```

---

## Why Oil is Powerful

### 1. Use Familiar Vim Motions

No new keymaps to memorize! Everything works like editing text:
- `dd` - Delete a file (mark for deletion)
- `yy` - Copy a file
- `p` - Paste a file
- `cw` - Rename a file
- `o` - Create a new file

### 2. See Changes Before Applying

**All changes are buffered until you save** with `:w`.

This means:
- You can undo mistakes with `u` before saving
- You can see all changes at once
- Multiple operations happen atomically when you save

### 3. Batch Operations

Make multiple changes, then save once:

```
1. Rename file1.lua → newfile1.lua
2. Delete file2.lua
3. Create file3.lua
4. Copy file4.lua → file4.backup.lua
5. Press :w → All 4 operations execute at once!
```

### 4. Undo/Redo Support

Made a mistake? Just press `u` before saving!

```
1. Press dd on important.lua (oops!)
2. Press u (undo)
3. File line reappears
4. No harm done!
```

---

## How to Open Oil

### Method 1: Current Window

```
Press: -

Opens parent directory in current window
```

**Use case:** Quick file browsing when you want to replace your current view.

### Method 2: Floating Window

```
Press: Space -

Opens parent directory in floating popup
```

**Use case:** Quick file operations without losing your place in code.

---

## What You'll See

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

### Understanding the Display

**Key elements:**
- `../` - Parent directory (go up one level)
- `lua/` - Directory (ends with `/`)
- `README.md` - File (no trailing `/`)
- `.gitignore` - Hidden file (starts with `.`)

**Hidden files:** By default, hidden files (starting with `.`) are shown. Toggle with `g.`

---

## Basic Navigation

Oil uses **standard Vim motions** - no special keys to learn!

### Moving Around

```
j or ↓          Move down to next file/folder
k or ↑          Move up to previous file/folder
gg              Go to top of list
G               Go to bottom of list
/pattern        Search for file/folder name
```

### Entering and Exiting Directories

```
Enter           Open file or enter directory
-               Go to parent directory
_               Go to current working directory (where nvim started)
```

### Closing Oil

```
q               Close oil window
<C-c>           Close oil window (alternative)
```

---

## Example Navigation Flow

Let's practice basic navigation:

```
Starting in: ~/projects/myapp/

1. Press - to open oil
2. See list of files in ~/projects/myapp/
3. Navigate to src/ with j/k
4. Press Enter to enter src/ directory
5. See files inside src/
6. Press - to go back to parent (myapp/)
7. Press q to close oil
```

---

## Key Safety Features

### 1. Changes Are Not Immediate

**All changes are buffered until you save with `:w`**

```
Example:
1. Press dd on file1 (marked for deletion)
2. Press u (undo - file1 unmarked)
3. Nothing was actually deleted!

VS

1. Press dd on file1 (marked for deletion)
2. Press :w (file1 is now PERMANENTLY deleted)
3. Cannot undo - file is gone!
```

**Always remember:** You can undo before `:w`, but not after!

### 2. Visual Feedback

Oil shows you what will happen before it happens:

```
Before dd:         After dd (before :w):
init.lua           init.lua
old_file.lua       test.lua    ← old_file.lua removed from view
test.lua

The file is marked for deletion but not deleted until you :w
```

### 3. Directory Deletion Warning

**Be careful!** Deleting a directory with `dd` will delete ALL contents recursively.

**Best practice:**
```
Before deleting a folder:
1. Press Enter to look inside
2. Check what's in there
3. Press - to go back
4. Now press dd if you're sure
5. Press :w
```

---

## Quick Start Checklist

Before moving to the next tutorials, make sure you can:

- ✅ Open Oil with `-` or `Space -`
- ✅ Navigate with `j`/`k` and `Enter`
- ✅ Go to parent directory with `-`
- ✅ Close Oil with `q`
- ✅ Understand that changes happen on `:w`, not before

---

## Next Steps

Now that you understand the basics, learn how to use Oil:

- **[Creating Files and Folders](./03-oil-creating-files.md)** - Make new files and directories
- [Editing Files](./03-oil-editing-files.md) - Rename, delete, copy files
- [Common Workflows](./03-oil-workflows.md) - Real-world usage patterns

---

## Quick Reference

```
╔══════════════════════════════════════════════════════╗
║              OIL.NVIM INTRODUCTION                   ║
╠══════════════════════════════════════════════════════╣
║ OPENING OIL:                                        ║
║ -              Open in current window               ║
║ Space -        Open in floating window              ║
║                                                     ║
║ NAVIGATION:                                         ║
║ j/k            Move down/up                         ║
║ Enter          Open file or enter directory         ║
║ -              Go to parent directory               ║
║ q              Close oil                            ║
║                                                     ║
║ KEY CONCEPT:                                        ║
║ :w             Save changes (applies all operations)║
║ u              Undo changes (before :w)             ║
╚══════════════════════════════════════════════════════╝
```

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
