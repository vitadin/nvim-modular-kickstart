# Makefile for Kickstart.nvim - Lua Code Quality Tools
# =======================================================
#
# This Makefile provides targets for maintaining code quality:
#   - format: Auto-format all Lua files with stylua
#   - lint:   Check code with luacheck
#   - check:  Run both format and lint (recommended before commits)
#   - test:   Verify Neovim can load the configuration
#   - clean:  Remove backup files and caches
#
# Requirements:
#   - stylua:   cargo install stylua  (or: brew install stylua)
#   - luacheck: luarocks install luacheck  (or: brew install luacheck)
#   - neovim:   For testing configuration

.PHONY: help format lint check test clean clean-nvim clean-test clean-all-dangerous install-tools

# Default target
help:
	@echo "Kickstart.nvim - Code Quality Targets"
	@echo "======================================"
	@echo ""
	@echo "Code Quality:"
	@echo "  make format        - Format all Lua files with stylua"
	@echo "  make lint          - Lint all Lua files with luacheck"
	@echo "  make check         - Run format + lint (recommended before commits)"
	@echo "  make test          - Test that Neovim can load the configuration"
	@echo ""
	@echo "Cleanup:"
	@echo "  make clean                - Remove backup files"
	@echo "  make clean-nvim           - Clean main Neovim data and cache"
	@echo "  make clean-test           - Clean test installation (nvim-modular)"
	@echo "  make clean-all-dangerous  - ⚠️  DANGER: Clean everything!"
	@echo ""
	@echo "Tools:"
	@echo "  make install-tools - Show instructions for installing required tools"
	@echo "  make verify-tools  - Check if all tools are installed"
	@echo ""
	@echo "Quick start:"
	@echo "  make check         - Verify code quality"
	@echo "  make clean-test    - Clean test installation before testing"
	@echo ""

# Format all Lua files
format:
	@echo "==> Formatting Lua files with stylua..."
	@if command -v stylua >/dev/null 2>&1; then \
		stylua --check . && echo "✓ All files are formatted correctly" || \
		(echo "Files need formatting. Running stylua..." && stylua .); \
	else \
		echo "Error: stylua not found. Run 'make install-tools' for installation instructions."; \
		exit 1; \
	fi

# Format files (force reformat even if already formatted)
format-fix:
	@echo "==> Formatting Lua files with stylua (force)..."
	@if command -v stylua >/dev/null 2>&1; then \
		stylua . && echo "✓ All files formatted"; \
	else \
		echo "Error: stylua not found. Run 'make install-tools' for installation instructions."; \
		exit 1; \
	fi

# Lint all Lua files
lint:
	@echo "==> Linting Lua files with luacheck..."
	@if command -v luacheck >/dev/null 2>&1; then \
		luacheck . && echo "✓ No linting errors found"; \
	else \
		echo "Error: luacheck not found. Run 'make install-tools' for installation instructions."; \
		exit 1; \
	fi

# Run both format and lint checks
check: format lint
	@echo ""
	@echo "✓ All checks passed!"
	@echo ""

# Test that Neovim can load the configuration
test:
	@echo "==> Testing Neovim configuration..."
	@if command -v nvim >/dev/null 2>&1; then \
		echo "Validating Lua syntax..."; \
		if luac -p init.lua 2>/dev/null && \
		   find lua -name "*.lua" -exec luac -p {} \; 2>/dev/null; then \
			echo "✓ All Lua files have valid syntax"; \
		else \
			echo "✗ Syntax errors found"; \
			exit 1; \
		fi; \
	else \
		echo "Error: nvim not found."; \
		exit 1; \
	fi

# Test with checkhealth
test-health:
	@echo "==> Running Neovim health checks..."
	@if command -v nvim >/dev/null 2>&1; then \
		nvim --headless -c "checkhealth" -c "quit" 2>&1 | head -n 50; \
	else \
		echo "Error: nvim not found."; \
		exit 1; \
	fi

# Clean backup files in current directory
clean:
	@echo "==> Cleaning backup files..."
	@find . -type f -name "*.backup" -delete
	@find . -type f -name "*~" -delete
	@echo "✓ Cleanup complete"

# Clean Neovim data and cache (for troubleshooting)
clean-nvim:
	@echo "==> Cleaning Neovim data and cache..."
	@echo "This will remove:"
	@echo "  - Plugin data: ~/.local/share/nvim/"
	@echo "  - Cache files: ~/.cache/nvim/"
	@echo ""
	@read -p "Are you sure? (y/N): " confirm && [ "$$confirm" = "y" ] || exit 1
	@rm -rf ~/.local/share/nvim
	@rm -rf ~/.cache/nvim
	@echo "✓ Neovim data and cache cleaned"
	@echo "Note: Plugins will reinstall on next launch"

# Clean test installation (nvim-modular)
clean-test:
	@echo "==> Cleaning test installation (nvim-modular)..."
	@echo "This will remove:"
	@echo "  - Config: ~/.config/nvim-modular/"
	@echo "  - Data:   ~/.local/share/nvim-modular/"
	@echo "  - Cache:  ~/.cache/nvim-modular/"
	@echo ""
	@if [ -d ~/.config/nvim-modular ] || [ -d ~/.local/share/nvim-modular ] || [ -d ~/.cache/nvim-modular ]; then \
		read -p "Are you sure? (y/N): " confirm && [ "$$confirm" = "y" ] || exit 1; \
		rm -rf ~/.config/nvim-modular; \
		rm -rf ~/.local/share/nvim-modular; \
		rm -rf ~/.cache/nvim-modular; \
		echo "✓ Test installation cleaned"; \
	else \
		echo "No test installation found"; \
	fi

# Clean all (backup files + Neovim data + test installation)
# WARNING: This is a destructive operation!
clean-all-dangerous:
	@echo "⚠️  ⚠️  ⚠️  DANGER: DESTRUCTIVE OPERATION ⚠️  ⚠️  ⚠️"
	@echo ""
	@echo "This will PERMANENTLY DELETE:"
	@echo "  - Backup files in current directory"
	@echo "  - Main Neovim data: ~/.local/share/nvim/"
	@echo "  - Main Neovim cache: ~/.cache/nvim/"
	@echo "  - Test config: ~/.config/nvim-modular/"
	@echo "  - Test data: ~/.local/share/nvim-modular/"
	@echo "  - Test cache: ~/.cache/nvim-modular/"
	@echo ""
	@echo "⚠️  All plugins will need to be reinstalled!"
	@echo "⚠️  All LSP servers will need to be reinstalled!"
	@echo "⚠️  Any custom plugin data will be lost!"
	@echo ""
	@read -p "Type 'yes' to confirm (anything else will cancel): " confirm && [ "$$confirm" = "yes" ] || { echo "Cancelled."; exit 1; }
	@echo ""
	@read -p "Are you ABSOLUTELY sure? Type 'DELETE' to proceed: " confirm2 && [ "$$confirm2" = "DELETE" ] || { echo "Cancelled."; exit 1; }
	@echo ""
	@echo "Deleting..."
	@find . -type f -name "*.backup" -delete
	@find . -type f -name "*~" -delete
	@rm -rf ~/.local/share/nvim
	@rm -rf ~/.cache/nvim
	@rm -rf ~/.config/nvim-modular
	@rm -rf ~/.local/share/nvim-modular
	@rm -rf ~/.cache/nvim-modular
	@echo "✓ All cleaned"
	@echo "⚠️  Remember to reinstall plugins on next Neovim launch!"

# Show installation instructions for required tools
install-tools:
	@echo "Required Tools Installation"
	@echo "============================"
	@echo ""
	@echo "1. stylua (Lua formatter):"
	@echo "   - With cargo: cargo install stylua"
	@echo "   - With Homebrew: brew install stylua"
	@echo "   - From releases: https://github.com/JohnnyMorganz/StyLua/releases"
	@echo ""
	@echo "2. luacheck (Lua linter):"
	@echo "   - With luarocks: luarocks install luacheck"
	@echo "   - With Homebrew: brew install luacheck"
	@echo "   - From source: https://github.com/mpeterv/luacheck"
	@echo ""
	@echo "3. Neovim (for testing):"
	@echo "   - With Homebrew: brew install neovim"
	@echo "   - Official site: https://neovim.io/"
	@echo ""
	@echo "Current tool status:"
	@command -v stylua >/dev/null 2>&1 && echo "  ✓ stylua installed" || echo "  ✗ stylua not found"
	@command -v luacheck >/dev/null 2>&1 && echo "  ✓ luacheck installed" || echo "  ✗ luacheck not found"
	@command -v nvim >/dev/null 2>&1 && echo "  ✓ neovim installed" || echo "  ✗ neovim not found"
	@echo ""

# Verify all tools are installed
verify-tools:
	@echo "==> Verifying required tools..."
	@MISSING=0; \
	command -v stylua >/dev/null 2>&1 || { echo "✗ stylua not found"; MISSING=1; }; \
	command -v luacheck >/dev/null 2>&1 || { echo "✗ luacheck not found"; MISSING=1; }; \
	command -v nvim >/dev/null 2>&1 || { echo "✗ neovim not found"; MISSING=1; }; \
	if [ $$MISSING -eq 0 ]; then \
		echo "✓ All required tools are installed"; \
	else \
		echo ""; \
		echo "Some tools are missing. Run 'make install-tools' for installation instructions."; \
		exit 1; \
	fi

# Pre-commit hook helper (runs all checks)
pre-commit: check test
	@echo ""
	@echo "✓ Ready to commit!"
	@echo ""
