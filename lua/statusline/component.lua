local component = {}

component.trunc_width = setmetatable({
	mode = 80,
	git_status = 90,
	filename = 140,
	line_column = 60,
}, {
	__index = function()
		return 80 -- handle edge cases, if there's any
	end,
})

component.is_truncated = function(_, width)
	return vim.api.nvim_win_get_width(0) < width
end

component.modes = setmetatable({
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

component.mode = function(self)
	local current_mode = vim.api.nvim_get_mode().mode

	if self:is_truncated(self.trunc_width.mode) then
		return self.modes[current_mode].long
	end

	return self.modes[current_mode].long
end

component.git_status = function(self)
	-- use fallback because it doesn't set this variable on the initial `BufEnter`
	local signs = vim.b.gitsigns_status_dict or {
		added = 0,
		changed = 0,
		removed = 0,
		head = "",
	}

	-- vim.cmd(string.format("echo \"%s\"", signs.head))

	local is_head_empty = signs.head ~= ""

	if self:is_truncated(self.trunc_width.git_status) then
		return is_head_empty and string.format(" %s ", signs.head or "") or ""
	end

	return is_head_empty and string.format(" +%s ~%s -%s | %s ", signs.added, signs.changed, signs.removed, signs.head)
		or ""
end

component.filename = function(self)
	if self:is_truncated(self.trunc_width.filename) then
		return " %<%m %f "
	end

	return " %<%m %F "
end

component.filetype = function()
	local filetype = vim.b.filetype

	if filetype == "" then
		return ""
	end

	return string.format(" %s ", filetype)
end

component.line_column = function(self)
	if self:is_truncated(self.trunc_width.line_column) then
		return " %-03.5l : %-03.5c "
	end

	return " Ln %-03.5l, Col %-03.5c "
end

component.lsp_diagnostic = function(self)
	local result = {}

	local severity_levels = {
		error = "Error",
		warning = "Warning",
		information = "Information",
		hint = "Hint",
	}

	for k, severity_level in pairs(severity_levels) do
		result[k] = vim.diagnostic.get(0, { severity = severity_level })
	end

	if self:is_truncated(self.trunc_width.diagnostic) then
		return ""
	else
		return string.format(
			"| E:%s W:%s I:%s H:%s ",
			result["error"] or 0,
			result["warning"] or 0,
			result["information"] or 0,
			result["hint"] or 0
		)
	end
end

return component
