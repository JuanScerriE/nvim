local api = vim.api
local o = vim.o

M = {}

M.is_truncated = function(width)
	if o.laststatus == 3 then
		-- if the statusline is global
		return o.columns < width
	else
		-- 0 to get the width of focused window
		return api.nvim_win_get_width(0) < width
	end
end

return M
