# Neovim Tutorial Series

Welcome to the Neovim tutorial series! This collection of guides will help
you master Neovim efficiently using this modular configuration.

## Learning Path

### Beginner Level

1. [**Basic Navigation**](./01-basic-navigation.md) - Essential movement
   commands
2. [**Editing Basics**](./02-editing-basics.md) - Insert, delete, change text
3. [**File Operations**](./03-file-operations.md) - Opening, saving, closing
   files

### Intermediate Level

4. [**Multi-File Navigation**](./04-multi-file-navigation.md) - Jump between
   files efficiently
5. [**Search and Replace**](./05-search-replace.md) - Finding and replacing
   text
6. [**LSP Features**](./06-lsp-features.md) - Go to definition, find
   references, etc.
7. [**Git Workflow**](./07-git-workflow.md) - Using gitsigns and neogit

### Advanced Level

8. [**Telescope Mastery**](./08-telescope-mastery.md) - Fuzzy finding
   everything
9. [**Custom Keymaps**](./09-custom-keymaps.md) - Creating your own shortcuts
10. [**Plugin Management**](./10-plugin-management.md) - Adding, removing,
    configuring plugins

## Quick Reference

### This Configuration's Special Features

- **Leader key**: `<Space>`
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
