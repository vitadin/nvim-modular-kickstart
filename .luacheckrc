-- Luacheck configuration for Neovim configuration
-- See: https://luacheck.readthedocs.io/en/stable/config.html

-- Ignore some pedantic warnings
ignore = {
  "111", -- Setting an undefined global variable (vim.* is ok)
  "112", -- Mutating an undefined global variable
  "113", -- Accessing undefined variable (vim.* fields)
  "121", -- Setting a read-only global variable (vim.o.*, vim.g.*, etc.)
  "122", -- Setting a read-only field of a global variable
  "142", -- Setting an undefined field of a global variable
  "143", -- Accessing an undefined field of a global variable
  "212", -- Unused argument (common in callback functions)
  "213", -- Unused loop variable
  "631", -- Line is too long (we have stylua for formatting)
}

-- Exclude directories
exclude_files = {
  ".git/",
  ".github/",
  "doc/",
}

-- Lua version
std = "luajit"

-- Maximum line length (should match stylua)
max_line_length = 160

-- Maximum cyclomatic complexity
max_cyclomatic_complexity = 15

-- Maximum code nesting depth
max_code_line_length = false
