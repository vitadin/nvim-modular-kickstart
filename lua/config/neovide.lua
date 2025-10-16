-- Neovide-specific Configuration
-- This file only runs when Neovim is launched via Neovide GUI
-- Regular terminal Neovim users are unaffected
--
-- To use Neovide: neovide /path/to/file
-- Documentation: https://neovide.dev/configuration.html

-- Guard: Only run if actually running in Neovide
if not vim.g.neovide then
	return
end

-- Load user configuration (git-ignored, prevents git pull conflicts)
local user_config = {}
local ok, config = pcall(require, 'user-config')
if ok then
	user_config = config
end

-- ============================================================================
-- Font Configuration
-- ============================================================================

-- Font family and size
-- Default: nil (uses Neovide's default system font)
-- Can be customized in lua/user-config.lua
--
-- If user specifies a font or font_size in user-config.lua, it will be used
-- Otherwise, Neovide uses its default font (usually system default monospace)

if user_config.neovide then
	-- If user specified a complete font string
	if user_config.neovide.font then
		vim.o.guifont = user_config.neovide.font
	-- If user only specified font_size, use Neovide default with custom size
	elseif user_config.neovide.font_size then
		-- Note: When only size is specified, Neovide will use its default font
		-- with the specified size. Format: ":hSIZE"
		vim.o.guifont = string.format(':h%d', user_config.neovide.font_size)
	end
	-- If neither is specified, leave guifont unset (Neovide uses its default)
end

-- If guifont is still not set, it means user didn't configure anything
-- Neovide will use its own default font

-- Line spacing (padding between lines)
-- Higher values = more vertical spacing
vim.opt.linespace = 10

-- ============================================================================
-- Cursor Configuration
-- ============================================================================

-- Cursor animation duration (in seconds)
-- Lower = faster, Higher = smoother
-- Range: 0.0 (instant) to 0.2 (very slow)
vim.g.neovide_cursor_animation_length = 0.13

-- Cursor trail length
-- How long the cursor trail particles last
-- Range: 0.0 (no trail) to 1.0 (long trail)
vim.g.neovide_cursor_trail_size = 0.8

-- Cursor visual effects (VFX)
-- Options: 'railgun', 'torpedo', 'pixiedust', 'sonicboom', 'ripple', 'wireframe'
-- Uncomment to enable:
-- vim.g.neovide_cursor_vfx_mode = 'torpedo'

-- Cursor particles settings (when VFX is enabled)
-- vim.g.neovide_cursor_vfx_opacity = 200.0
-- vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
-- vim.g.neovide_cursor_vfx_particle_density = 7.0
-- vim.g.neovide_cursor_vfx_particle_speed = 10.0

-- Cursor antialiasing
vim.g.neovide_cursor_antialiasing = true

-- ============================================================================
-- Window Configuration
-- ============================================================================

-- Display refresh rate (Hz)
-- Higher = smoother animations (if your display supports it)
vim.g.neovide_refresh_rate = 60

-- Fullscreen mode
-- true = Start in fullscreen, false = Start in window
vim.g.neovide_fullscreen = false

-- Remember window size between sessions
vim.g.neovide_remember_window_size = true

-- Window padding (in pixels)
-- Adds breathing room around the editor content
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 20

-- Window transparency (0.0 = transparent, 1.0 = opaque)
-- Note: May not work on all platforms
-- vim.g.neovide_transparency = 0.95

-- Floating window transparency
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

-- ============================================================================
-- Scroll Configuration
-- ============================================================================

-- Scroll animation duration (in seconds)
-- Lower = faster, Higher = smoother
vim.g.neovide_scroll_animation_length = 0.3

-- Hide mouse when typing
vim.g.neovide_hide_mouse_when_typing = true

-- ============================================================================
-- Input Configuration
-- ============================================================================

-- Allow <Cmd> key on macOS (useful for macOS users)
vim.g.neovide_input_use_logo = true

-- macOS-specific: Use Option (Alt) as Meta key
-- When true: Option acts like Alt in terminal Neovim
-- When false: Option produces special characters (e.g., Option+e = ´)
vim.g.neovide_input_macos_option_key_is_meta = true

-- ============================================================================
-- Performance Configuration
-- ============================================================================

-- Enable/disable various rendering features for performance tuning
-- Default: true for all
-- vim.g.neovide_no_idle = true  -- Always render frames (uses more CPU/battery)
-- vim.g.neovide_confirm_quit = true  -- Ask before quitting with unsaved changes

-- Profiler (for debugging performance)
-- vim.g.neovide_profiler = true

-- ============================================================================
-- Workarounds and Fixes
-- ============================================================================

-- Enable markdown code block syntax highlighting for Neovide
-- Set this globally before any markdown files are loaded
vim.g.markdown_fenced_languages = {
	'bash',
	'c',
	'cpp',
	'go',
	'html',
	'javascript',
	'js=javascript',
	'json',
	'lua',
	'python',
	'sh',
	'typescript',
	'vim',
	'viml=vim',
}

-- Disable Treesitter for markdown in Neovide (causes rendering issues)
-- Use Vim's built-in syntax highlighting instead
vim.api.nvim_create_autocmd({ 'FileType' }, {
	group = vim.api.nvim_create_augroup('NeovideMarkdownFix', { clear = true }),
	pattern = { 'markdown' },
	callback = function()
		-- Disable treesitter highlighting for this buffer
		vim.cmd 'TSBufDisable highlight'
		-- Enable vim's built-in syntax highlighting
		vim.cmd 'syntax enable'
		-- Force reload markdown syntax to pick up fenced languages
		vim.cmd 'setlocal syntax=markdown'

		-- Set pure black background for code blocks
		vim.api.nvim_set_hl(0, 'markdownCode', { bg = '#000000' })
		vim.api.nvim_set_hl(0, 'markdownCodeBlock', { bg = '#000000' })
		vim.api.nvim_set_hl(0, 'markdownCodeDelimiter', { bg = '#000000' })

		-- Force black background for all syntax groups inside code blocks
		-- We need to override each language's syntax highlighting background
		local code_languages = {
			'bash', 'c', 'cpp', 'go', 'html', 'javascript', 'json',
			'lua', 'python', 'sh', 'typescript', 'vim'
		}

		for _, lang in ipairs(code_languages) do
			-- Get all highlight groups for this language and set black background
			local groups = vim.fn.getcompletion(lang, 'highlight')
			for _, group in ipairs(groups) do
				local hl = vim.api.nvim_get_hl(0, { name = group })
				if hl and not vim.tbl_isempty(hl) then
					-- Keep foreground color but set black background
					vim.api.nvim_set_hl(0, group, vim.tbl_extend('force', hl, { bg = '#000000' }))
				end
			end
		end
	end,
	desc = 'Disable Treesitter for markdown in Neovide, use Vim syntax',
})

-- ============================================================================
-- Neovide-specific Keymaps (Optional)
-- ============================================================================

-- Paste from system clipboard using Cmd+V (macOS) or Ctrl+V (Windows/Linux)
if vim.fn.has 'mac' == 1 then
	-- macOS: Cmd+V to paste
	vim.keymap.set({ 'n', 'v', 'i', 'c' }, '<D-v>', function()
		vim.api.nvim_paste(vim.fn.getreg '+', true, -1)
	end, { desc = 'Paste from clipboard (Neovide macOS)' })

	-- macOS: Cmd+C to copy
	vim.keymap.set('v', '<D-c>', '"+y', { desc = 'Copy to clipboard (Neovide macOS)' })
else
	-- Windows/Linux: Ctrl+V to paste
	vim.keymap.set({ 'n', 'v', 'i', 'c' }, '<C-v>', function()
		vim.api.nvim_paste(vim.fn.getreg '+', true, -1)
	end, { desc = 'Paste from clipboard (Neovide)' })

	-- Windows/Linux: Ctrl+C to copy
	vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to clipboard (Neovide)' })
end

-- Toggle fullscreen with F11 (common GUI convention)
vim.keymap.set('n', '<F11>', function()
	vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end, { desc = 'Toggle fullscreen (Neovide)' })

-- ============================================================================
-- Debug Information
-- ============================================================================

-- Print confirmation that Neovide config loaded (for debugging)
-- Comment out if you don't want the message
vim.notify('Neovide configuration loaded', vim.log.levels.INFO, { title = 'Neovide' })
