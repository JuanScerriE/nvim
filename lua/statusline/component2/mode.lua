local api = vim.api

local section = require("statusline.section")

local M = {}

local modes = setmetatable({
	["n"] = { long = "NORMAL", short = "N" },
	["nt"] = { long = "NORMAL", short = "N" },
	["no"] = { long = "N-PENDING", short = "N-P" },
	["v"] = { long = "VISUAL", short = "V" },
	["V"] = { long = "V-LINE", short = "V-L" },
	[""] = { long = "V-BLOCK", short = "V-B" },
	["s"] = { long = "SELECT", short = "S" },
	["S"] = { long = "S-LINE", short = "S-L" },
	[""] = { long = "S-BLOCK", short = "S-B" },
	["i"] = { long = "INSERT", short = "I" },
	["ic"] = { long = "INSERT", short = "I" },
	["R"] = { long = "REPLACE", short = "R" },
	["Rv"] = { long = "V-REPLACE", short = "V-R" },
	["c"] = { long = "COMMAND", short = "C" },
	["cv"] = { long = "VIM-EX ", short = "V-E" },
	["ce"] = { long = "EX ", short = "E" },
	["r"] = { long = "PROMPT ", short = "P" },
	["rm"] = { long = "MORE ", short = "M" },
	["r?"] = { long = "CONFIRM ", short = "C" },
	["!"] = { long = "SHELL ", short = "S" },
	["t"] = { long = "TERMINAL ", short = "T" },
}, {
	__index = function()
		return { long = "UNKNOWN", short = "U" } -- handle edge cases
	end,
})

local is_mode_truncated = function()
  return section:is_truncated(section.trunc_width.mode)
end

M.get_mode = function(self)
	local mode = api.nvim_get_mode().mode

	if is_mode_truncated() then
		return modes[mode].long
	end

	return modes[mode].short
end

return M
