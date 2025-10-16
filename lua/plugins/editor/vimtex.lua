-- VimTeX: LaTeX support for Neovim
-- Repository: https://github.com/lervag/vimtex
-- Documentation: :help vimtex
--
-- DISABLED BY DEFAULT - LaTeX support requires additional system dependencies
-- See installation instructions below before enabling
--
-- To enable LaTeX support:
-- 1. Copy config: cp lua/user-config.lua.example lua/user-config.lua
-- 2. Edit lua/user-config.lua and set latex = true
-- 3. Install system dependencies (see below)
-- 4. Restart Neovim and run :Lazy sync
--
-- Required System Dependencies:
--   macOS:
--     brew install --cask skim         # PDF viewer with SyncTeX support
--     brew install texlive             # LaTeX distribution
--     # or: brew install --cask mactex # Full LaTeX distribution (larger)
--
--   Linux (Ubuntu/Debian):
--     sudo apt install texlive-full zathura zathura-pdf-poppler
--
--   Linux (Arch):
--     sudo pacman -S texlive-most zathura zathura-pdf-mupdf
--
-- What is VimTeX?
-- - Complete LaTeX editing environment
-- - Real-time compilation and preview
-- - Forward/backward search (jump between source and PDF)
-- - LaTeX-specific motions and text objects
-- - Table of contents navigation
-- - Bibliography support

-- Load user configuration (git-ignored, prevents git pull conflicts)
local user_config = {}
local ok, config = pcall(require, 'user-config')
if ok then
	user_config = config
end

return {
	'lervag/vimtex',
	-- Controlled by lua/user-config.lua (set latex = true to enable)
	enabled = user_config.latex or false,

	-- Only load for LaTeX files (no impact on other file types)
	ft = { 'tex', 'bib' },

	config = function()
		-- PDF viewer configuration
		-- macOS: Use Skim for SyncTeX support (forward/backward search)
		vim.g.vimtex_view_method = 'skim'

		-- Linux users: Uncomment the line below and comment out the Skim line above
		-- vim.g.vimtex_view_method = 'zathura'

		-- Compiler configuration
		-- Use latexmk for automatic compilation
		vim.g.vimtex_compiler_method = 'latexmk'

		-- Latexmk options
		vim.g.vimtex_compiler_latexmk = {
			build_dir = '', -- Build in same directory (or specify output dir)
			options = {
				'-pdf', -- Generate PDF
				'-shell-escape', -- Allow shell commands (needed for some packages)
				'-verbose',
				'-file-line-error',
				'-synctex=1', -- Enable SyncTeX for forward/backward search
				'-interaction=nonstopmode', -- Don't stop on errors
			},
		}

		-- Engine selection (pdflatex, xelatex, or lualatex)
		-- Default: pdflatex
		-- Override per-file with magic comment: %!TEX program = xelatex
		-- Override per-project with .latexmkrc file
		vim.g.vimtex_compiler_latexmk_engines = {
			_ = '-pdf', -- pdflatex (default, best compatibility)
			-- Uncomment one of these to change global default:
			-- _ = '-xelatex',  -- XeLaTeX (better font support, Unicode)
			-- _ = '-lualatex', -- LuaLaTeX (Lua scripting, modern)
		}

		-- Quickfix configuration
		vim.g.vimtex_quickfix_mode = 1 -- Open quickfix on errors
		vim.g.vimtex_quickfix_open_on_warning = 0 -- Don't open on warnings

		-- Syntax concealment (optional - hide LaTeX commands for cleaner view)
		-- 0 = no concealment, 1 = conceal in insert mode, 2 = always conceal
		vim.g.vimtex_syntax_conceal_disable = 0

		-- Disable some default mappings if you prefer custom ones
		-- vim.g.vimtex_mappings_enabled = 0

		-- Folding configuration (optional)
		-- vim.g.vimtex_fold_enabled = 1
		-- vim.g.vimtex_fold_types = {
		--     sections = { enabled = 1 },
		--     envs = { enabled = 1 },
		-- }

		-- Notification when compilation completes
		vim.g.vimtex_compiler_latexmk_callback = 1

		-- Integration with other plugins
		-- For completion, use texlab LSP (configured in lua/lsp/servers/texlab.lua)
	end,

	-- Key mappings are handled by VimTeX automatically
	-- NOTE: This config sets maplocalleader = <Space>, so VimTeX uses <Space> not '\'
	-- Main compilation mappings:
	--   <Space>ll - Start/stop continuous compilation
	--   <Space>lv - View PDF (forward search to current location)
	--   <Space>lc - Clean auxiliary files
	--   <Space>le - Show errors in quickfix
	--   <Space>lt - Open table of contents
	--   <Space>lk - Stop compilation
	--
	-- Using XeLaTeX or LuaLaTeX:
	--   Option 1: Add magic comment at top of .tex file:
	--             %!TEX program = xelatex
	--             %!TEX program = lualatex
	--   Option 2: Create .latexmkrc in project directory:
	--             $pdf_mode = 5;  # xelatex
	--             $pdf_mode = 4;  # lualatex
	--   Then <Space>ll works as usual with the specified engine!
	--
	-- Text object mappings (non-leader):
	--   dse - Delete surrounding environment
	--   cse - Change surrounding environment
	--   tse - Toggle starred environment (e.g., equation <-> equation*)
	--   <F7> - Insert new command
	--   ]m/]M - Next/previous section start
	--   ]]/[[ - Next/previous section end
	--
	-- See :help vimtex-default-mappings for complete list
}
