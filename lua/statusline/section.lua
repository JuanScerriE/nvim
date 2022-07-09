local api = vim.api

M = {}

M.trunc_width = setmetatable({
	mode = 80,
	git_status = 90,
	filename = 140,
	line_column = 60,
}, {
	__index = function()
		return 80 -- handle edge cases, if there's any
	end,
})

M.is_truncated = function(_, width)
	return api.nvim_win_get_width(0) < width
end

return M
