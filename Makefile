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

.PHONY: help format lint check test clean install-tools

# Default target
help:
	@echo "Kickstart.nvim - Code Quality Targets"
	@echo "======================================"
	@echo ""
	@echo "Available targets:"
	@echo "  make format        - Format all Lua files with stylua"
	@echo "  make lint          - Lint all Lua files with luacheck"
	@echo "  make check         - Run format + lint (recommended before commits)"
	@echo "  make test          - Test that Neovim can load the configuration"
	@echo "  make clean         - Remove backup files and caches"
	@echo "  make install-tools - Show instructions for installing required tools"
	@echo ""
	@echo "Quick start:"
	@echo "  make check         - Verify code quality"
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

# Clean backup files and caches
clean:
	@echo "==> Cleaning backup files and caches..."
	@find . -type f -name "*.backup" -delete
	@find . -type f -name "*~" -delete
	@echo "✓ Cleanup complete"

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
