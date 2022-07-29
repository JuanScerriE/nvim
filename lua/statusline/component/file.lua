local api = vim.api
local bo = vim.bo

local util = require("statusline.util")
local builtin = require("statusline.builtin")

local M = {}

M.get_filename = function(width)
	if util.is_truncated(width) then
		return string.format(" %s%s %s ", builtin.truncate, builtin.abs_path, builtin.modified)
	end

	return string.format(" %s%s %s ", builtin.truncate, builtin.filename, builtin.modified)
end

M.get_filetype = function(width)
	local filetype = bo.filetype

	if util.is_truncated(width) then
		return string.format(" %s ", filetype)
	end

	return ""
end

return M
