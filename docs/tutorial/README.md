# Neovim Tutorial Series

Welcome to the Neovim tutorial series! This collection of focused, single-topic
guides will help you master Neovim efficiently using this modular configuration.

**Philosophy:** Each tutorial solves a single problem or teaches one specific
skill. No overwhelming 500+ line documents!

## Learning Path

### Beginner Level: Basic Navigation with Leap.nvim

1. [**What is Leap and Why?**](./01-leap-what-and-why.md) - Understand Leap's
   philosophy and speed advantages
2. [**Basic Leap Usage**](./01-leap-basic-usage.md) - Learn the three commands
   with step-by-step tutorials
3. [**Common Workflows**](./01-leap-common-workflows.md) - Real-world usage
   patterns for daily coding
4. [**Advanced Techniques**](./01-leap-advanced.md) - Power user tips and
   tricks

### Beginner Level: Editing Basics

5. [**Editing Basics**](./02-editing-basics.md) - Insert, delete, change text

### Beginner Level: File Operations with Oil.nvim

6. [**What is Oil.nvim?**](./03-oil-introduction.md) - Understanding Oil's
   buffer-based file management
7. [**Creating Files and Folders**](./03-oil-creating-files.md) - Making new
   files and directories
8. [**Editing Files**](./03-oil-editing-files.md) - Rename, delete, copy, and
   move files
9. [**Common Workflows**](./03-oil-workflows.md) - Real-world file management
   patterns

### Intermediate Level

10. [**Multi-File Navigation**](./04-multi-file-navigation.md) - Jump between
    files efficiently
11. [**Search and Replace**](./05-search-replace.md) - Finding and replacing
    text
12. [**LSP Features**](./06-lsp-features.md) - Go to definition, find
    references, etc.
13. [**Git Workflow**](./07-git-workflow.md) - Using gitsigns and neogit

### Advanced Level

14. [**Telescope Mastery**](./08-telescope-mastery.md) - Fuzzy finding
    everything
15. [**Custom Keymaps**](./09-custom-keymaps.md) - Creating your own shortcuts
16. [**Plugin Management**](./10-plugin-management.md) - Adding, removing,
    configuring plugins

## Quick Start: Jump to What You Need

### I want to...

- **Move faster in files** → [What is Leap?](./01-leap-what-and-why.md)
- **Jump anywhere in 3 keystrokes** → [Basic Leap Usage](./01-leap-basic-usage.md)
- **Manage files like a buffer** → [What is Oil?](./03-oil-introduction.md)
- **Create/delete files in Vim** → [Creating Files](./03-oil-creating-files.md)
- **Rename and organize files** → [Editing Files](./03-oil-editing-files.md)
- **See common usage patterns** → [Leap Workflows](./01-leap-common-workflows.md) or [Oil Workflows](./03-oil-workflows.md)

## Quick Reference

### This Configuration's Special Features

- **Leader key**: `<Space>`
- **Leap.nvim**: `s` (leap forward), `S` (leap backward), `gs` (leap windows)
- **Oil.nvim**: `-` (file manager), `<Space>-` (floating window)
- **Telescope**: `<leader>sf` (search files), `<leader>sg` (live grep)
- **LSP**: `grd` (definition), `grr` (references), `grn` (rename)
- **Git**: `]c` / `[c` (next/prev change), `<leader>hs` (stage hunk)
- **Bookmarks**: `<tab><tab>` (toggle bookmark)

### Common Vim Motions (Quick Reference)

```
Movement:
  h/j/k/l    - left/down/up/right
  w/b        - word forward/backward
  0/$        - start/end of line
  gg/G       - start/end of file
  {/}        - paragraph up/down

Editing:
  i/a        - insert before/after cursor
  o/O        - open line below/above
  d/c/y      - delete/change/yank (copy)
  p/P        - paste after/before
  u/Ctrl-r   - undo/redo

Visual mode:
  v          - character-wise visual
  V          - line-wise visual
  Ctrl-v     - block-wise visual
```

## Getting Help

1. **Neovim's built-in help**: `:help <topic>` (e.g., `:help telescope`)
2. **Which-key popup**: Press `<Space>` and wait to see available commands
3. **Plugin documentation**: `:help <plugin-name>` (e.g., `:help gitsigns`)
4. **This tutorial series**: Start with topic 1 and progress sequentially

## How to Use These Tutorials

1. **Hands-on practice**: Open Neovim and try each command as you read
2. **Repeat exercises**: Practice makes perfect
3. **Build muscle memory**: Focus on one technique at a time
4. **Customize**: Adapt the workflows to your needs

## Contributing

Found a useful tip or workflow? Consider adding it to this tutorial series!
Each tutorial is a standalone markdown file in this directory.

---

[Back to Main README](../../README.md)
