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

-- ============================================================================
-- Font Configuration
-- ============================================================================

-- Font family and size
-- Format: "FontName:hSIZE" or "FontName:hSIZE:w700" (with weight)
-- Examples:
--   - "FiraCode Nerd Font:h14"
--   - "JetBrainsMono Nerd Font:h12:w500"
--   - "Cascadia Code:h16"
vim.o.guifont = 'Fira Code:h19'
-- Alternative fonts (uncomment to try):
-- vim.o.guifont = 'PragmataPro Mono Liga:h21'
-- vim.o.guifont = 'JetBrainsMono Nerd Font:h14'

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
vim.g.neovide_input_macos_alt_is_meta = true

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

-- Disable Treesitter highlighting for markdown in Neovide
-- Reason: Treesitter + Neovide can cause rendering issues with markdown
-- This uses Vim's built-in markdown syntax highlighting instead
vim.api.nvim_create_autocmd({ 'FileType' }, {
	group = vim.api.nvim_create_augroup('NeovideMarkdownFix', { clear = true }),
	pattern = { 'markdown' },
	callback = function()
		-- Disable treesitter highlighting for this buffer
		vim.cmd 'TSBufDisable highlight'
		-- Enable vim's built-in syntax highlighting instead
		vim.cmd 'syntax on'
	end,
	desc = 'Disable Treesitter for markdown in Neovide to prevent rendering issues',
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
