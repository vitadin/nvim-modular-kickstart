--[[
=====================================================================
==================== KICKSTART.NVIM - MODULAR ====================
=====================================================================

This is a modular restructuring of kickstart.nvim.

The configuration is organized as follows:
  - lua/config/     : Core Neovim settings (options, keymaps, autocmds)
  - lua/plugins/    : Plugin specifications organized by category
    - ui/           : Colorscheme, statusline, which-key
    - editor/       : Telescope, treesitter, mini.nvim, etc.
    - lsp/          : LSP configuration
    - coding/       : Completion, formatting, linting
    - git/          : Git integration (gitsigns)

To customize:
  - Modify settings in lua/config/ files
  - Add/remove plugins in lua/plugins/ subdirectories
  - Add your own custom plugins to lua/custom/plugins/

For help: `:help` or `<space>sh` to search help

=====================================================================
--]]

-- Set <space> as the leader key
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Load configuration
require 'config'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
