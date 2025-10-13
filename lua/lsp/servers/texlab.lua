-- Texlab Language Server Configuration (LaTeX LSP)
-- Repository: https://github.com/latex-lsp/texlab
-- Documentation: https://github.com/latex-lsp/texlab/wiki
--
-- DISABLED BY DEFAULT - This file exists but won't be loaded unless you enable it
--
-- To enable LaTeX LSP support:
-- 1. Rename this file to remove the '.disabled' suffix (if present)
-- 2. Or simply keep this file as-is (it's already ready to use)
-- 3. Also enable VimTeX plugin in lua/plugins/editor/vimtex.lua
-- 4. Restart Neovim and run :Mason to verify texlab installs
--
-- What is texlab?
-- - Language Server Protocol (LSP) for LaTeX
-- - Provides: autocompletion, diagnostics, go-to-definition, references
-- - Works alongside VimTeX (VimTeX handles compilation, texlab handles LSP features)
-- - Automatically installed by Mason when this file is present
--
-- Features:
-- - Autocomplete \cite{} with bibliography entries
-- - Autocomplete \ref{} with document labels
-- - Autocomplete LaTeX commands and environments
-- - Go to definition for labels and citations
-- - Find references for labels
-- - Hover documentation for commands
-- - Code actions (e.g., insert missing packages)
-- - Real-time diagnostics for syntax errors

-- NOTE: This file will NOT be loaded by lua/lsp/servers.lua unless you enable VimTeX
-- The file exists but remains dormant until you activate LaTeX support

return {
	-- Server-specific settings
	settings = {
		texlab = {
			-- Build configuration
			build = {
				-- Compile on save
				onSave = true,
				-- Forward search after build (requires Skim or Zathura)
				forwardSearchAfter = false,
				-- Build command (uses latexmk by default)
				-- executable = 'latexmk',
				-- args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
			},

			-- Forward search configuration (jump from source to PDF)
			forwardSearch = {
				-- macOS with Skim
				executable = '/Applications/Skim.app/Contents/SharedSupport/displayline',
				args = { '%l', '%p', '%f' },

				-- Linux with Zathura (uncomment if using Linux):
				-- executable = 'zathura',
				-- args = { '--synctex-forward', '%l:1:%f', '%p' },
			},

			-- Chktex configuration (LaTeX linter)
			chktex = {
				onOpenAndSave = true, -- Run chktex when opening/saving files
				onEdit = false, -- Don't run on every edit (can be slow)
			},

			-- Diagnostics configuration
			diagnosticsDelay = 300, -- Delay before showing diagnostics (ms)

			-- Completion configuration
			completion = {
				-- Include package suggestions
				includePackages = true,
			},

			-- Formatting configuration
			-- latexFormatter = 'latexindent', -- Use latexindent for formatting
			-- latexindent = {
			--     ['local'] = nil, -- Path to local latexindent config
			--     modifyLineBreaks = false,
			-- },
		},
	},

	-- Optional: Override filetypes if needed
	-- filetypes = { 'tex', 'bib' },

	-- Optional: Override command if texlab is installed in non-standard location
	-- cmd = { 'texlab' },
}
