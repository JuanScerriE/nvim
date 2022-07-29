local api = vim.api
local b = vim.b

local M = {}

local util = require("statusline.util")

function M.git_info_exists()
	return b.gitsigns_status_dict or b.gitsigns_head
end

function M.git_diff(width)
	local status = b.gitsigns_status_dict

	if util.is_truncated(width) then
		return string.format(" +%s -%s ~%s ", status.added, status.removed, status.changed)
	end

	return ""
end

function M.git_branch(width)
	if util.is_truncated(width) then
		return string.format(" %s ", b.gitsigns_head)
	end

	return ""
end

return M
