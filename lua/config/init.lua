-- Configuration Module Loader
-- This file loads all configuration modules in the correct order

-- Load Neovim options
require 'config.options'

-- Load keymaps
require 'config.keymaps'

-- Load autocommands
require 'config.autocmds'

-- Bootstrap and configure lazy.nvim plugin manager
require 'config.lazy'

-- Load Neovide-specific configuration (only if running in Neovide)
-- This is safe to load even in terminal Neovim - it will return early if not in Neovide
require 'config.neovide'
