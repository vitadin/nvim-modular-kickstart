# LaTeX Setup and Usage

Learn how to enable and use LaTeX support for writing academic papers, presentations, and documents in Neovim.

## What is LaTeX Support?

This configuration includes optional LaTeX support that transforms Neovim into a complete LaTeX IDE:

- **VimTeX** - LaTeX editing environment with compilation and preview
- **texlab** - Language Server for autocompletion and diagnostics
- **Skim** - PDF viewer with SyncTeX (jump between source and PDF)

**Important:** LaTeX support is **disabled by default** to avoid impacting non-LaTeX users.

---

## Prerequisites

Before enabling LaTeX support, you need to install system dependencies.

### Step 1: Install LaTeX Distribution

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

**Verify installation:**
```bash
pdflatex --version
# Should show: pdfTeX 3.x.x
```

### Step 2: Install PDF Viewer with SyncTeX

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

**What is SyncTeX?**
- Forward search: Jump from source code to PDF location
- Backward search: Click PDF to jump to source line
- Essential for efficient LaTeX editing

---

## Enable LaTeX Support

### Step 1: Enable VimTeX Plugin

Edit the file: `lua/plugins/editor/vimtex.lua`

Find line 30 and change:
```lua
-- Before:
enabled = false,

-- After:
enabled = true,
```

**Save the file** and close your editor.

### Step 2: Enable texlab LSP

Rename the LSP configuration file to activate it:

```bash
# Navigate to LSP servers directory
cd ~/.config/nvim/lua/lsp/servers

# Rename to remove .disabled suffix
mv texlab.lua.disabled texlab.lua
```

If using `NVIM_APPNAME=nvim-modular`:
```bash
cd ~/.config/nvim-modular/lua/lsp/servers
mv texlab.lua.disabled texlab.lua
```

### Step 3: Restart Neovim and Sync Plugins

```bash
# Close all Neovim instances
# Then open Neovim
nvim

# Sync plugins (this installs VimTeX and texlab)
:Lazy sync

# Wait for installation to complete
# Press 'q' to close the Lazy window
```

### Step 4: Verify Installation

Check that texlab LSP server installed:
```vim
:Mason
```

Look for `texlab` in the list - it should show as installed.

---

## Your First LaTeX Document

Let's create a simple document to test the setup.

### Create a Test File

```bash
nvim test.tex
```

### Type This Content

```latex
\documentclass{article}
\usepackage[utf8]{inputenc}

\title{My First LaTeX Document}
\author{Your Name}
\date{\today}

\begin{document}

\maketitle

\section{Introduction}
This is my first LaTeX document edited in Neovim.

\subsection{Why LaTeX?}
LaTeX is great for:
\begin{itemize}
    \item Academic papers
    \item Mathematical equations
    \item Professional documents
\end{itemize}

\section{Math Example}
The quadratic formula is:
\[ x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a} \]

\end{document}
```

### Compile and View

1. **Start compilation** (in normal mode):
   ```
   \ll
   ```
   (That's backslash-L-L)

   You'll see compilation output at the bottom.

2. **View the PDF**:
   ```
   \lv
   ```
   (That's backslash-L-V)

   Skim (or Zathura) should open showing your PDF!

**Success!** You just compiled your first LaTeX document in Neovim.

---

## Essential Workflows

### Workflow 1: Write, Compile, View

**Goal:** Write text, see it in PDF

**Steps:**
1. Edit your `.tex` file
2. Press `\ll` (start continuous compilation)
3. Save your file (`:w`)
4. Compilation happens automatically
5. Press `\lv` to view PDF

**Continuous compilation means:** Every time you save, LaTeX recompiles automatically.

### Workflow 2: Forward Search

**Goal:** Jump from source code to PDF location

**Scenario:** You're editing line 42 in your `.tex` file and want to see that exact paragraph in the PDF.

**Steps:**
1. Place cursor on line 42
2. Press `\lv` in normal mode
3. PDF viewer jumps to that paragraph

**Try it:**
- Go to the line with "quadratic formula"
- Press `\lv`
- The PDF should jump to that equation

### Workflow 3: Backward Search

**Goal:** Click PDF to find source location

**Scenario:** You're reading the PDF and spot a typo. Where is that in your source code?

**Steps:**
1. **In Skim (macOS):** Cmd+Shift+Click on the text
2. **In Zathura (Linux):** Ctrl+Click on the text
3. Neovim jumps to that exact line

**Try it:**
- Open your PDF in Skim
- Cmd+Shift+Click on "Introduction"
- Neovim should jump to `\section{Introduction}`

### Workflow 4: View Errors

**Goal:** Fix compilation errors

**Scenario:** Your document won't compile.

**Steps:**
1. LaTeX compilation fails
2. Quickfix window opens automatically showing errors
3. Press `Enter` on an error to jump to that line
4. Fix the error
5. Save (`:w`) to recompile

**Try creating an error:**
```latex
\begin{itemize}
    \item Test
% Missing \end{itemize}
```

Save and watch the quickfix window show the error.

### Workflow 5: Stop Compilation

**Goal:** Stop the background compilation process

**Command:**
```
\lk
```
(Backslash-L-K)

Useful when switching to a different document.

---

## Autocompletion Features

texlab LSP provides smart autocompletion:

### Test 1: Command Completion

**In insert mode, type:**
```latex
\sec
```

Press `<C-n>` (Ctrl+N) - you should see:
- `\section`
- `\section*`
- `\subsection`

### Test 2: Environment Completion

**Type:**
```latex
\begin{enu
```

Press `<C-n>` - you should see:
- `enumerate`
- `enumitem`

### Test 3: Citation Completion (with BibTeX)

If you have a `.bib` file:
```latex
\cite{
```

You'll see your bibliography entries!

### Test 4: Label/Reference Completion

**First, create a label:**
```latex
\section{Introduction}\label{sec:intro}
```

**Then reference it:**
```latex
See Section \ref{sec:
```

Press `<C-n>` - you should see `sec:intro` suggested!

---

## Common Commands Reference

### Compilation Commands

All commands use `\` (backslash) as leader:

| Command | Action |
|---------|--------|
| `\ll` | Start/stop continuous compilation |
| `\lk` | Stop compilation |
| `\lv` | View PDF (forward search) |
| `\lc` | Clean auxiliary files (.aux, .log, etc.) |
| `\le` | Show errors in quickfix window |

### Navigation Commands

| Command | Action |
|---------|--------|
| `\lt` | Open table of contents |
| `]]` | Next section |
| `[[` | Previous section |
| `]m` | Next environment start |
| `[m` | Previous environment start |

### Editing Commands

| Command | Action |
|---------|--------|
| `dse` | Delete surrounding environment |
| `cse` | Change surrounding environment |
| `tse` | Toggle starred environment |
| `dsc` | Delete surrounding command |
| `csc` | Change surrounding command |

### Text Objects

Use with `d`, `c`, `v` operators:

| Text Object | Selects |
|-------------|---------|
| `ie` | Inside environment |
| `ae` | Around environment |
| `i$` | Inside inline math |
| `a$` | Around inline math |
| `id` | Inside delimiters `()`, `[]`, `{}` |
| `ad` | Around delimiters |

**Examples:**
- `die` - Delete inside environment (deletes content between `\begin` and `\end`)
- `cse` - Change surrounding environment (e.g., change `itemize` to `enumerate`)
- `vi$` - Visually select inline math
- `dad` - Delete around delimiters (deletes `()` and contents)

---

## Practical Examples

### Example 1: Create a Bullet List

**Type:**
```latex
\begin{itemize}
\end{itemize}
```

**Place cursor between lines, type:**
```latex
\item First point
\item Second point
```

**Use `dse` to delete the environment:**
- Place cursor anywhere in `\begin{itemize}...\end{itemize}`
- Press `dse` in normal mode
- Entire environment deleted!

**Use `cse` to change environment:**
- Place cursor in the itemize environment
- Press `cse` in normal mode
- Type: `enumerate`
- Press Enter
- Environment changed to `enumerate`!

### Example 2: Write Math Equations

**Inline math:**
```latex
The formula is $E = mc^2$ in physics.
```

**Display math:**
```latex
\[
    \int_0^1 x^2 \, dx = \frac{1}{3}
\]
```

**Numbered equation:**
```latex
\begin{equation}\label{eq:pythagorean}
    a^2 + b^2 = c^2
\end{equation}
```

**Reference the equation:**
```latex
See Equation \ref{eq:pythagorean} for the Pythagorean theorem.
```

**Select and manipulate math:**
- Place cursor in `$E = mc^2$`
- Press `vi$` - Selects just `E = mc^2`
- Press `di$` - Deletes math content, keeps `$$`

### Example 3: Create Sections

**Type:**
```latex
\section{Methods}
Lorem ipsum...

\subsection{Data Collection}
More text...

\subsection{Analysis}
Even more text...
```

**Navigate sections:**
- Press `]]` to jump to next section
- Press `[[` to jump to previous section
- Press `\lt` to open table of contents, select section to jump

### Example 4: Fix a Typo in PDF

**Scenario:** You're reading your compiled PDF and spot: "teh" instead of "the"

**Steps:**
1. **In Skim:** Cmd+Shift+Click on "teh"
2. Neovim jumps to that line
3. Fix: `cw` then type `the`
4. Save: `:w`
5. PDF updates automatically!

**Without SyncTeX:** You'd have to manually find "teh" in your 50-page document.

### Example 5: Working with Citations

**Create a bibliography file:** `refs.bib`
```bibtex
@article{einstein1905,
    author = {Einstein, Albert},
    title = {On the Electrodynamics of Moving Bodies},
    year = {1905}
}
```

**In your `.tex` file:**
```latex
\documentclass{article}
\usepackage{cite}

\begin{document}

According to Einstein \cite{einstein1905}, relativity...

\bibliography{refs}
\bibliographystyle{plain}

\end{document}
```

**Autocomplete citation:**
- Type `\cite{`
- Press `<C-n>`
- See `einstein1905` suggestion!

---

## Tips and Tricks

### Tip 1: Keep Compilation Running

Start compilation once with `\ll` and leave it running:
- Every save triggers recompilation
- Faster than manual `\ll` each time
- Stop with `\lk` when done

### Tip 2: Use Table of Contents for Large Documents

For documents with many sections:
```
\lt
```
Opens a navigable table of contents window.
Press `Enter` to jump to a section.

### Tip 3: Clean Build Files Regularly

LaTeX creates many auxiliary files (.aux, .log, .synctex.gz):
```
\lc
```
Cleans them all, keeping only .tex and .pdf

### Tip 4: Use Snippets for Common Structures

Create common structures faster:

**Fraction:** `\frac{}{}`
- Type it once, move between `{}` with `<Tab>` (if snippets enabled)

**Matrix:**
```latex
\begin{pmatrix}
    a & b \\
    c & d
\end{pmatrix}
```

### Tip 5: Split Window for PDF Preview

**Alternative to external PDF viewer:**
```vim
:vsplit | terminal open -a Skim %:r.pdf
```

Opens PDF in split window (macOS specific).

---

## Troubleshooting

### Issue 1: `\ll` Does Nothing

**Solution:**
```vim
:echo g:vimtex_enabled
```
Should show `1`. If not:
1. Check `enabled = true` in `lua/plugins/editor/vimtex.lua`
2. Run `:Lazy sync`
3. Restart Neovim

### Issue 2: Autocompletion Doesn't Work

**Solution:**
```vim
:LspInfo
```
Should show `texlab` attached. If not:
1. Check `texlab.lua` exists (not `.disabled`)
2. Run `:Mason` and verify texlab installed
3. Run `:LspRestart`

### Issue 3: PDF Viewer Doesn't Open

**macOS:**
```bash
open -a Skim
```
Should open Skim. If not, reinstall:
```bash
brew reinstall --cask skim
```

**Linux:**
```bash
which zathura
```
Should show path. If not, install:
```bash
sudo apt install zathura
```

### Issue 4: Forward Search Not Working

**Check SyncTeX file exists:**
```bash
ls *.synctex.gz
```

If missing, check compilation options in `lua/plugins/editor/vimtex.lua`:
```lua
'-synctex=1',  -- Should be present
```

Recompile: `\lc` then `\ll`

### Issue 5: Compilation Errors

**View detailed log:**
```vim
:VimtexLog
```

**Common errors:**
- Missing `\end{environment}` - Check brackets match
- Undefined command - Check package loaded with `\usepackage{}`
- Missing $ - Check math delimiters match

---

## Next Steps

### Learn More Commands

```vim
:help vimtex
:help vimtex-default-mappings
:help vimtex-text-objects
```

### Practice Projects

1. **Academic Paper** - Write a 2-page paper with:
   - Title, abstract, sections
   - Equations and citations
   - Figures and tables

2. **Presentation** - Try Beamer slides:
   ```latex
   \documentclass{beamer}
   ```

3. **Resume** - Create a CV using LaTeX templates

### Advanced Topics

- **Multiple files:** Use `\input{}` or `\include{}`
- **Custom commands:** Define macros with `\newcommand`
- **Bibliography management:** Use BibTeX or biblatex
- **Tikz diagrams:** Draw figures programmatically

---

## Related Topics

- [Custom Keymaps](./09-custom-keymaps.md) - Remap VimTeX commands
- [LSP Features](./06-lsp-features.md) - Understanding LSP in general

---

[Back to Tutorial Index](./README.md) | [Back to Main README](../../README.md)
