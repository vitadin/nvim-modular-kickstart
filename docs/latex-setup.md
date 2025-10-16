# LaTeX Support Setup Guide

LaTeX support is **disabled by default** to avoid impacting users who don't need it. This guide shows how to enable full LaTeX editing capabilities with VimTeX and texlab LSP.

## What You Get

Once enabled, you'll have a complete LaTeX IDE:
- Real-time compilation and preview
- Forward/backward search (jump between source and PDF)
- Autocompletion for commands, citations, and references
- Go to definition and find references
- Real-time syntax diagnostics
- LaTeX-specific motions and text objects
- Table of contents navigation

## Prerequisites

### 1. Install LaTeX Distribution

**macOS:**
```bash
# Option 1: Full MacTeX (recommended, ~4GB)
brew install --cask mactex

# Option 2: BasicTeX (minimal, ~100MB)
brew install texlive
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt install texlive-full
```

**Linux (Arch):**
```bash
sudo pacman -S texlive-most
```

### 2. Install PDF Viewer with SyncTeX Support

**macOS:**
```bash
brew install --cask skim
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt install zathura zathura-pdf-poppler

# Arch
sudo pacman -S zathura zathura-pdf-mupdf
```

## Enable LaTeX Support

### Step 1: Enable VimTeX Plugin

Edit `lua/plugins/editor/vimtex.lua`:

```lua
-- Line 30: Change this line
enabled = false,

-- To:
enabled = true,
```

### Step 2: Enable texlab LSP

Rename the LSP configuration file:

```bash
cd ~/.config/nvim/lua/lsp/servers
mv texlab.lua.disabled texlab.lua
```

Or if using NVIM_APPNAME:
```bash
cd ~/.config/nvim-modular/lua/lsp/servers
mv texlab.lua.disabled texlab.lua
```

### Step 3: Restart Neovim

```bash
# Close all Neovim instances, then:
nvim

# Check that plugins are loading
:Lazy sync

# Verify texlab is installed
:Mason
# Look for 'texlab' in the list - it should auto-install
```

## Verify Setup

Create a test LaTeX file:

```bash
nvim test.tex
```

Type this content:
```latex
\documentclass{article}
\begin{document}
Hello, LaTeX!
\end{document}
```

### Test Compilation

1. **Start compilation:**
   ```
   \ll
   ```
   (That's backslash-L-L in normal mode)

2. **View PDF:**
   ```
   \lv
   ```
   Skim (or Zathura) should open showing your PDF

3. **Test LSP completion:**
   - Type `\cite{` in insert mode
   - You should see completion suggestions
   - Type `\ref{` to see label completions

### Test SyncTeX (Forward Search)

1. Place cursor on any line in your `.tex` file
2. Press `<Space>lv` in normal mode
3. The PDF viewer should jump to that exact location

### Test Backward Search

**In Skim (macOS):**
- Cmd+Shift+Click on any text in the PDF
- Neovim should jump to that line in the source

**In Zathura (Linux):**
- Ctrl+Click on any text in the PDF
- Neovim should jump to that line in the source

## Common Key Mappings

VimTeX provides these default mappings (leader is `\`):

### Compilation
- `<Space>ll` - Start/stop continuous compilation
- `<Space>lk` - Stop compilation
- `<Space>lc` - Clean auxiliary files (.aux, .log, etc.)
- `<Space>le` - Show errors in quickfix list

### Navigation
- `<Space>lv` - View PDF (forward search to current location)
- `<Space>lt` - Open table of contents
- `]]` / `[[` - Next/previous section
- `]m` / `[m` - Next/previous environment

### Editing
- `dse` - Delete surrounding environment
- `cse` - Change surrounding environment
- `tse` - Toggle starred environment (e.g., `equation` ↔ `equation*`)
- `dsc` - Delete surrounding command
- `csc` - Change surrounding command

### Text Objects
- `ie` / `ae` - Inside/around environment
- `i$` / `a$` - Inside/around inline math
- `id` / `ad` - Inside/around delimiters

See `:help vimtex-default-mappings` for complete list.

## Configuration

### Change PDF Viewer

**Linux users** need to change the viewer in `lua/plugins/editor/vimtex.lua`:

```lua
-- Line 49: Comment out Skim
-- vim.g.vimtex_view_method = 'skim'

-- Line 52: Uncomment Zathura
vim.g.vimtex_view_method = 'zathura'
```

### Change LaTeX Engine

By default, VimTeX uses `pdflatex`. To use XeLaTeX or LuaLaTeX:

Edit `lua/plugins/editor/vimtex.lua` (around line 70):

```lua
vim.g.vimtex_compiler_latexmk_engines = {
    _ = '-xelatex',  -- Use XeLaTeX
    -- or
    _ = '-lualatex',  -- Use LuaLaTeX
}
```

### Enable Automatic Compilation on Save

By default, you manually trigger compilation with `<Space>ll`. To compile automatically on save:

Edit `lua/lsp/servers/texlab.lua`:

```lua
build = {
    onSave = true,  -- Already enabled
},
```

This is already the default in our configuration.

## Troubleshooting

### VimTeX commands don't work

**Problem:** Pressing `<Space>ll` does nothing

**Solutions:**
1. Check VimTeX is enabled: `:echo g:vimtex_enabled`
2. Check file type: `:set ft?` (should show `tex`)
3. Verify LaTeX is installed: `which pdflatex`
4. Check VimTeX mappings: `:verbose map \ll`

### PDF viewer doesn't open

**Problem:** `<Space>lv` does nothing or gives error

**Solutions:**
1. Verify viewer is installed:
   ```bash
   # macOS
   open -a Skim

   # Linux
   which zathura
   ```

2. Check VimTeX viewer setting:
   ```vim
   :echo g:vimtex_view_method
   ```

3. Check PDF was generated:
   ```bash
   ls *.pdf
   ```

### Completion doesn't work

**Problem:** No suggestions when typing `\cite{` or `\ref{`

**Solutions:**
1. Check texlab is running: `:LspInfo`
2. Verify texlab.lua is enabled (not .disabled)
3. Restart LSP: `:LspRestart`
4. Check Mason installed texlab: `:Mason`

### Forward/Backward search doesn't work

**Problem:** `<Space>lv` doesn't jump to PDF location

**Solutions:**
1. Check SyncTeX is enabled (it should be by default)
2. Verify .synctex.gz file exists next to your PDF
3. Check viewer supports SyncTeX (Skim or Zathura required)
4. Try recompiling: `<Space>lc` then `<Space>ll`

### Compilation fails with errors

**Problem:** Red errors in quickfix window

**Solutions:**
1. Check LaTeX syntax in your document
2. View full log: `:VimtexLog`
3. Clean and rebuild: `<Space>lc` then `<Space>ll`
4. Check required packages are installed

## Disabling LaTeX Support

To disable and free up resources:

### Step 1: Disable VimTeX

Edit `lua/plugins/editor/vimtex.lua`:

```lua
-- Line 30: Change back to
enabled = false,
```

### Step 2: Disable texlab LSP

```bash
cd ~/.config/nvim/lua/lsp/servers
mv texlab.lua texlab.lua.disabled
```

### Step 3: Restart Neovim

```bash
nvim
:Lazy sync
```

## Advanced: Multiple LaTeX Projects

If you work with multiple LaTeX projects, use `.latexmkrc` files in each project root to customize compilation:

```perl
# .latexmkrc in project root
$pdf_mode = 1;           # pdflatex
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
$out_dir = 'build';      # Output directory
```

VimTeX automatically detects and uses project-specific `.latexmkrc` files.

## Resources

- **VimTeX Documentation:** `:help vimtex`
- **VimTeX Repository:** https://github.com/lervag/vimtex
- **texlab Documentation:** https://github.com/latex-lsp/texlab/wiki
- **LaTeX Cheat Sheet:** https://www.overleaf.com/learn/latex/Cheatsheet

## Comparison with Overleaf

| Feature | This Setup | Overleaf |
|---------|-----------|----------|
| Cost | Free | Limited free tier |
| Offline | ✅ Yes | ❌ No (paid only) |
| Speed | ✅ Instant | ⚠️ Network dependent |
| Vim keybindings | ✅ Native | ⚠️ Limited |
| Git integration | ✅ Native | ✅ Built-in |
| Collaboration | ❌ No | ✅ Yes |
| Setup complexity | ⚠️ Manual | ✅ None |

---

**Back to:** [Main README](../README.md) | [FAQ](faq/README.md) | [Tutorials](tutorial/README.md)
