-- Simple bookmark system using native Vim marks
-- This is a lightweight alternative that uses Vim's built-in marks
--
-- Usage:
--   mm          - Set a bookmark at current position
--   mn / mp     - Jump to next/previous bookmark
--   ml          - List all bookmarks
--   mc          - Clear bookmarks in current buffer
--   mx          - Clear all bookmarks
--
-- Implementation: Uses marks a-z for bookmarks
-- These are session-based and cleared when you close Neovim

-- Store active marks
local active_marks = {}

-- Toggle bookmark at current position
local function toggle_bookmark()
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local buf = vim.api.nvim_get_current_buf()

	-- Check if there's already a mark on this line
	local existing_mark = nil
	for mark = string.byte('a'), string.byte('z') do
		local mark_char = string.char(mark)
		local mark_pos = vim.api.nvim_buf_get_mark(buf, mark_char)
		if mark_pos[1] == line then
			existing_mark = mark_char
			break
		end
	end

	if existing_mark then
		-- Remove the mark by setting it to an invalid position
		vim.cmd('delmarks ' .. existing_mark)
		-- Remove from active marks
		for i, mark in ipairs(active_marks) do
			if mark == existing_mark then
				table.remove(active_marks, i)
				break
			end
		end
		vim.notify('Bookmark removed', vim.log.levels.INFO)
	else
		-- Find next available mark (a-z)
		local mark_char = nil
		for mark = string.byte('a'), string.byte('z') do
			local char = string.char(mark)
			local mark_pos = vim.api.nvim_buf_get_mark(buf, char)
			if mark_pos[1] == 0 then
				mark_char = char
				break
			end
		end

		if mark_char then
			vim.cmd('normal! m' .. mark_char)
			table.insert(active_marks, mark_char)
			vim.notify('Bookmark set: ' .. mark_char, vim.log.levels.INFO)
		else
			vim.notify('No available bookmark slots (a-z all used)', vim.log.levels.WARN)
		end
	end
end

-- Jump to next bookmark
local function next_bookmark()
	if #active_marks == 0 then
		vim.notify('No bookmarks set', vim.log.levels.WARN)
		return
	end
	vim.cmd("normal! ]'")
end

-- Jump to previous bookmark
local function prev_bookmark()
	if #active_marks == 0 then
		vim.notify('No bookmarks set', vim.log.levels.WARN)
		return
	end
	vim.cmd("normal! ['")
end

-- List all bookmarks
local function list_bookmarks()
	if #active_marks == 0 then
		vim.notify('No bookmarks set', vim.log.levels.INFO)
		return
	end

	vim.cmd('marks ' .. table.concat(active_marks, ''))
end

-- Clear bookmarks in current buffer
local function clear_buffer_bookmarks()
	local buf = vim.api.nvim_get_current_buf()
	local marks_to_delete = {}

	for _, mark_char in ipairs(active_marks) do
		local mark_pos = vim.api.nvim_buf_get_mark(buf, mark_char)
		if mark_pos[1] > 0 then
			table.insert(marks_to_delete, mark_char)
		end
	end

	if #marks_to_delete > 0 then
		vim.cmd('delmarks ' .. table.concat(marks_to_delete, ''))
		-- Remove from active_marks
		for _, mark in ipairs(marks_to_delete) do
			for i, active_mark in ipairs(active_marks) do
				if active_mark == mark then
					table.remove(active_marks, i)
					break
				end
			end
		end
		vim.notify('Cleared ' .. #marks_to_delete .. ' bookmarks from buffer', vim.log.levels.INFO)
	else
		vim.notify('No bookmarks in current buffer', vim.log.levels.INFO)
	end
end

-- Clear all bookmarks
local function clear_all_bookmarks()
	if #active_marks > 0 then
		vim.cmd('delmarks ' .. table.concat(active_marks, ''))
		local count = #active_marks
		active_marks = {}
		vim.notify('Cleared ' .. count .. ' bookmarks', vim.log.levels.INFO)
	else
		vim.notify('No bookmarks to clear', vim.log.levels.INFO)
	end
end

-- Set up keymaps
vim.keymap.set('n', 'mm', toggle_bookmark, { desc = 'Toggle bookmark' })
vim.keymap.set('n', 'mn', next_bookmark, { desc = 'Next bookmark' })
vim.keymap.set('n', 'mp', prev_bookmark, { desc = 'Previous bookmark' })
vim.keymap.set('n', 'ml', list_bookmarks, { desc = 'List bookmarks' })
vim.keymap.set('n', 'mc', clear_buffer_bookmarks, { desc = 'Clear bookmarks in buffer' })
vim.keymap.set('n', 'mx', clear_all_bookmarks, { desc = 'Clear all bookmarks' })

-- Return empty table since this doesn't need lazy.nvim
return {}
