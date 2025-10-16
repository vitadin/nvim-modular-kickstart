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

-- Define highlight group for bookmark sign
vim.api.nvim_set_hl(0, 'BookmarkSignHL', { fg = '#FFA500', bold = true }) -- Orange color

-- Store active marks with their sign IDs
local active_marks = {}
local sign_id_counter = 5000 -- Start from 5000 to avoid conflicts

-- Define a sign for each mark letter (a-z)
for mark = string.byte('a'), string.byte('z') do
	local mark_char = string.char(mark)
	vim.fn.sign_define('BookmarkSign_' .. mark_char, {
		text = mark_char, -- Show the actual mark letter
		texthl = 'BookmarkSignHL',
		numhl = '',
	})
end

-- Toggle bookmark at current position
local function toggle_bookmark()
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local buf = vim.api.nvim_get_current_buf()

	-- Check if there's already a mark on this line
	local existing_mark = nil
	local existing_mark_data = nil
	for i, mark_data in ipairs(active_marks) do
		local mark_pos = vim.api.nvim_buf_get_mark(buf, mark_data.mark)
		if mark_pos[1] == line then
			existing_mark = mark_data.mark
			existing_mark_data = mark_data
			break
		end
	end

	if existing_mark then
		-- Remove the sign
		vim.fn.sign_unplace('BookmarkGroup', { id = existing_mark_data.sign_id, buffer = buf })

		-- Remove the mark
		vim.cmd('delmarks ' .. existing_mark)

		-- Remove from active marks
		for i, mark_data in ipairs(active_marks) do
			if mark_data.mark == existing_mark then
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
			-- Set the mark
			vim.cmd('normal! m' .. mark_char)

			-- Place the sign with the mark letter
			sign_id_counter = sign_id_counter + 1
			vim.fn.sign_place(sign_id_counter, 'BookmarkGroup', 'BookmarkSign_' .. mark_char, buf, { lnum = line, priority = 10 })

			-- Store mark data
			table.insert(active_marks, {
				mark = mark_char,
				sign_id = sign_id_counter,
				buffer = buf,
				line = line,
			})

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

	local current_buf = vim.api.nvim_get_current_buf()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]

	-- Find all bookmarks in current buffer after current line
	local next_marks = {}
	for _, mark_data in ipairs(active_marks) do
		if mark_data.buffer == current_buf then
			local mark_pos = vim.api.nvim_buf_get_mark(current_buf, mark_data.mark)
			if mark_pos[1] > current_line then
				table.insert(next_marks, { mark = mark_data.mark, line = mark_pos[1], col = mark_pos[2] })
			end
		end
	end

	if #next_marks > 0 then
		-- Sort by line number and jump to the closest one
		table.sort(next_marks, function(a, b)
			return a.line < b.line
		end)
		vim.api.nvim_win_set_cursor(0, { next_marks[1].line, next_marks[1].col })
		vim.notify('Jumped to bookmark: ' .. next_marks[1].mark, vim.log.levels.INFO)
	else
		-- Wrap around to first bookmark in buffer
		local first_marks = {}
		for _, mark_data in ipairs(active_marks) do
			if mark_data.buffer == current_buf then
				local mark_pos = vim.api.nvim_buf_get_mark(current_buf, mark_data.mark)
				table.insert(first_marks, { mark = mark_data.mark, line = mark_pos[1], col = mark_pos[2] })
			end
		end

		if #first_marks > 0 then
			table.sort(first_marks, function(a, b)
				return a.line < b.line
			end)
			vim.api.nvim_win_set_cursor(0, { first_marks[1].line, first_marks[1].col })
			vim.notify('Wrapped to first bookmark: ' .. first_marks[1].mark, vim.log.levels.INFO)
		else
			vim.notify('No bookmarks in this buffer', vim.log.levels.WARN)
		end
	end
end

-- Jump to previous bookmark
local function prev_bookmark()
	if #active_marks == 0 then
		vim.notify('No bookmarks set', vim.log.levels.WARN)
		return
	end

	local current_buf = vim.api.nvim_get_current_buf()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]

	-- Find all bookmarks in current buffer before current line
	local prev_marks = {}
	for _, mark_data in ipairs(active_marks) do
		if mark_data.buffer == current_buf then
			local mark_pos = vim.api.nvim_buf_get_mark(current_buf, mark_data.mark)
			if mark_pos[1] < current_line then
				table.insert(prev_marks, { mark = mark_data.mark, line = mark_pos[1], col = mark_pos[2] })
			end
		end
	end

	if #prev_marks > 0 then
		-- Sort by line number (descending) and jump to the closest one
		table.sort(prev_marks, function(a, b)
			return a.line > b.line
		end)
		vim.api.nvim_win_set_cursor(0, { prev_marks[1].line, prev_marks[1].col })
		vim.notify('Jumped to bookmark: ' .. prev_marks[1].mark, vim.log.levels.INFO)
	else
		-- Wrap around to last bookmark in buffer
		local last_marks = {}
		for _, mark_data in ipairs(active_marks) do
			if mark_data.buffer == current_buf then
				local mark_pos = vim.api.nvim_buf_get_mark(current_buf, mark_data.mark)
				table.insert(last_marks, { mark = mark_data.mark, line = mark_pos[1], col = mark_pos[2] })
			end
		end

		if #last_marks > 0 then
			table.sort(last_marks, function(a, b)
				return a.line > b.line
			end)
			vim.api.nvim_win_set_cursor(0, { last_marks[1].line, last_marks[1].col })
			vim.notify('Wrapped to last bookmark: ' .. last_marks[1].mark, vim.log.levels.INFO)
		else
			vim.notify('No bookmarks in this buffer', vim.log.levels.WARN)
		end
	end
end

-- List all bookmarks
local function list_bookmarks()
	if #active_marks == 0 then
		vim.notify('No bookmarks set', vim.log.levels.INFO)
		return
	end

	-- Extract just the mark characters
	local mark_chars = {}
	for _, mark_data in ipairs(active_marks) do
		table.insert(mark_chars, mark_data.mark)
	end

	vim.cmd('marks ' .. table.concat(mark_chars, ''))
	vim.notify("Press 'a to jump to mark a, 'b for mark b, etc.", vim.log.levels.INFO)
end

-- Telescope picker for bookmarks (interactive selection)
local function telescope_bookmarks()
	if #active_marks == 0 then
		vim.notify('No bookmarks set', vim.log.levels.INFO)
		return
	end

	local pickers = require 'telescope.pickers'
	local finders = require 'telescope.finders'
	local conf = require('telescope.config').values
	local actions = require 'telescope.actions'
	local action_state = require 'telescope.actions.state'

	-- Build entries for telescope
	local entries = {}
	for _, mark_data in ipairs(active_marks) do
		local mark_pos = vim.api.nvim_buf_get_mark(mark_data.buffer, mark_data.mark)
		if mark_pos[1] > 0 then
			local bufname = vim.api.nvim_buf_get_name(mark_data.buffer)
			local filename = vim.fn.fnamemodify(bufname, ':t')
			local lines = vim.api.nvim_buf_get_lines(mark_data.buffer, mark_pos[1] - 1, mark_pos[1], false)
			local line_content = lines[1] or ''

			table.insert(entries, {
				mark = mark_data.mark,
				buffer = mark_data.buffer,
				line = mark_pos[1],
				col = mark_pos[2],
				filename = filename,
				filepath = bufname,
				content = line_content,
				display = string.format('[%s] %s:%d - %s', mark_data.mark, filename, mark_pos[1], line_content:match '^%s*(.-)%s*$'),
			})
		end
	end

	-- Sort by mark letter
	table.sort(entries, function(a, b)
		return a.mark < b.mark
	end)

	pickers
		.new({}, {
			prompt_title = 'Bookmarks',
			finder = finders.new_table {
				results = entries,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.display,
						ordinal = entry.mark .. ' ' .. entry.filename .. ' ' .. entry.content,
						filename = entry.filepath,
						lnum = entry.line,
						col = entry.col + 1,
					}
				end,
			},
			sorter = conf.generic_sorter {},
			previewer = conf.grep_previewer {},
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					vim.api.nvim_set_current_buf(selection.value.buffer)
					vim.api.nvim_win_set_cursor(0, { selection.value.line, selection.value.col })
				end)
				return true
			end,
		})
		:find()
end

-- Clear bookmarks in current buffer
local function clear_buffer_bookmarks()
	local buf = vim.api.nvim_get_current_buf()
	local marks_to_delete = {}
	local indices_to_remove = {}

	for i, mark_data in ipairs(active_marks) do
		if mark_data.buffer == buf then
			table.insert(marks_to_delete, mark_data.mark)
			table.insert(indices_to_remove, i)
			-- Remove sign
			vim.fn.sign_unplace('BookmarkGroup', { id = mark_data.sign_id, buffer = buf })
		end
	end

	if #marks_to_delete > 0 then
		vim.cmd('delmarks ' .. table.concat(marks_to_delete, ''))
		-- Remove from active_marks (in reverse order to maintain indices)
		for i = #indices_to_remove, 1, -1 do
			table.remove(active_marks, indices_to_remove[i])
		end
		vim.notify('Cleared ' .. #marks_to_delete .. ' bookmarks from buffer', vim.log.levels.INFO)
	else
		vim.notify('No bookmarks in current buffer', vim.log.levels.INFO)
	end
end

-- Clear all bookmarks
local function clear_all_bookmarks()
	if #active_marks > 0 then
		local marks = {}
		-- Remove all signs
		for _, mark_data in ipairs(active_marks) do
			table.insert(marks, mark_data.mark)
			vim.fn.sign_unplace('BookmarkGroup', { id = mark_data.sign_id, buffer = mark_data.buffer })
		end

		vim.cmd('delmarks ' .. table.concat(marks, ''))
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
vim.keymap.set('n', 'ml', list_bookmarks, { desc = 'List bookmarks (Vim marks)' })
vim.keymap.set('n', '<leader>mb', telescope_bookmarks, { desc = 'Show [b]ookmarks (Telescope)' })
vim.keymap.set('n', 'mc', clear_buffer_bookmarks, { desc = 'Clear bookmarks in buffer' })
vim.keymap.set('n', 'mx', clear_all_bookmarks, { desc = 'Clear all bookmarks' })

-- Return empty table since this doesn't need lazy.nvim
return {}
