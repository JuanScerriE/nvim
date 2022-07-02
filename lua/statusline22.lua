local fn = vim.fn
local api = vim.api
local M = {}

M.trunc_width = setmetatable({
	mode = 80,
	git_status = 90,
	filename = 140,
	line_col = 60,
}, {
	__index = function()
		return 80 -- handle edge cases, if there's any
	end,
})

M.is_truncated = function(_, width)
	return api.nvim_win_get_width(0) < width
end

M.colors = {
	nvim_tree_active = "%#NvimTreeStatusLine#",
	nvim_tree_inactive = "%#NvimTreeStatusLineNC#",
	active = "%#StatusLine#",
	inactive = "%#StatuslineNC#",
	mode = "%#Mode#",
	mode_alt = "%#ModeAlt#",
	git = "%#Git#",
	git_alt = "%#GitAlt#",
	filetype = "%#Filetype#",
	filetype_alt = "%#FiletypeAlt#",
	line_col = "%#LineCol#",
	line_col_alt = "%#LineColAlt#",
}

local set_hl = function(name, val)
	api.nvim_set_hl(0, name, { fg = val.fg, bg = val.bg })
end

local highlights = {
	{ "NvimTreeStatusLine", { fg = "#3C3836", bg = "#EBDBB2" } },
	{ "NvimTreeStatusLineNC", { fg = "#EBDBB2", bg = "#3C3836" } },
	{ "StatusLine", { fg = "#3C3836", bg = "#EBDBB2" } },
	{ "StatusLineNC", { fg = "#EBDBB2", bg = "#3C3836" } },
	{ "Mode", { bg = "#928374", fg = "#1D2021", gui = "bold" } },
	{ "LineCol", { bg = "#928374", fg = "#1D2021", gui = "bold" } },
	{ "Git", { bg = "#504945", fg = "#EBDBB2" } },
	{ "Filetype", { bg = "#504945", fg = "#EBDBB2" } },
	{ "Filename", { bg = "#504945", fg = "#EBDBB2" } },
	{ "ModeAlt", { bg = "#504945", fg = "#928374" } },
	{ "GitAlt", { bg = "#3C3836", fg = "#504945" } },
	{ "LineColAlt", { bg = "#504945", fg = "#928374" } },
	{ "FiletypeAlt", { bg = "#3C3836", fg = "#504945" } },
}

for _, highlight in ipairs(highlights) do
	set_hl(highlight[1], highlight[2])
end

M.separators = {
	arrow = { "", "" },
	rounded = { "", "" },
	blank = { "", "" },
}

local active_sep = "arrow"

M.modes = setmetatable({
	["n"] = { long = "NORMAL", short = "N" },
	["nt"] = { long = "NORMAL", short = "N" },
	["no"] = { long = "N·PENDING", short = "N·P" },
	["v"] = { long = "VISUAL", short = "V" },
	["V"] = { long = "V·LINE", short = "V·L" },
	[""] = { long = "V·BLOCK", short = "V·B" },
	["s"] = { long = "SELECT", short = "S" },
	["S"] = { long = "S·LINE", short = "S·L" },
	[""] = { long = "S·BLOCK", short = "S·B" },
	["i"] = { long = "INSERT", short = "I" },
	["ic"] = { long = "INSERT", short = "I" },
	["R"] = { long = "REPLACE", short = "R" },
	["Rv"] = { long = "V·REPLACE", short = "V·R" },
	["c"] = { long = "COMMAND", short = "C" },
	["cv"] = { long = "VIM·EX ", short = "V·E" },
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

M.get_current_mode = function(self)
	local current_mode = api.nvim_get_mode().mode
	-- vim.cmd(string.format("echo \"%s\"", current_mode))

	if self:is_truncated(self.trunc_width.mode) then
		return self.modes[current_mode].short
	end

	return self.modes[current_mode].long
end

M.get_git_status = function(self)
	-- use fallback because it doesn't set this variable on the initial `BufEnter`
	local signs = vim.b.gitsigns_status_dict or {
		added = 0,
		changed = 0,
		removed = 0,
		head = "",
	}
	-- vim.cmd(string.format("echo \"%s\"", signs.head))

	local is_head_empty = signs.head ~= ""
	-- vim.cmd(string.format("echo \"%s\"", is_head_empty))

	-- if self:is_truncated(self.trunc_width.git_status) then
	-- 	return is_head_empty and string.format(" %s ", signs.head or "") or string.format("%s", is_head_empty)
	-- end
	--
	-- return is_head_empty and string.format(" +%s ~%s -%s | %s ", signs.added, signs.changed, signs.removed, signs.head)
	-- 	or string.format("%s", is_head_empty)

	if self:is_truncated(self.trunc_width.git_status) then
		return is_head_empty and string.format(" %s ", signs.head or "") or ""
	end

	return is_head_empty and string.format(" +%s ~%s -%s | %s ", signs.added, signs.changed, signs.removed, signs.head)
		or ""
end

M.get_filename = function(self)
	if self:is_truncated(self.trunc_width.filename) then
		return " %<%m %f "
	end

	return " %<%m %F "
end

M.get_filetype = function()
	local filetype = vim.bo.filetype

	if filetype == "" then
		return ""
	end

	return string.format(" %s ", filetype)
end

M.get_line_col = function(self)
	if self:is_truncated(self.trunc_width.line_col) then
		return " %-03.5l : %-03.5c "
	end

	return " Ln %-03.5l, Col %-03.5c "
end

M.get_lsp_diagnostic = function(self)
	local result = {}

	local levels = {
		error = "Error",
		warning = "Warning",
		information = "Information",
		hint = "Hint",
	}

	for k, level in pairs(levels) do
		result[k] = vim.lsp.diagnostic.get_count(0, level)
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

M.set_active = function(self)
	local colors = self.colors

	-- if vim.bo.filetype == "NvimTree" then
	-- 	local title = colors.mode .. " NvimTree "
	-- 	local title_alt = colors.mode_alt .. self.separators[active_sep][1]
	--
	-- 	return table.concat({ colors.active, title, title_alt })
	-- end

	-- if vim.bo.filetype == "TelescopePrompt" then
	-- 	local title = colors.mode .. " Telescope "
	-- 	local title_alt = colors.mode_alt .. self.separators[active_sep][1]
	--
	-- 	return table.concat({ colors.active, title, title_alt })
	-- end
	-- local mode = colors.mode .. self:get_current_mode()
	local mode = colors.mode .. " %{luaeval(\"require('statusline'):get_current_mode()\")} "
	local mode_alt = colors.mode_alt .. self.separators[active_sep][1]
	local git = colors.git .. self:get_git_status()
	local git_alt = colors.git_alt .. self.separators[active_sep][1]
	local filename = colors.inactive .. self:get_filename()
	local filetype_alt = colors.filetype_alt .. self.separators[active_sep][2]
	local filetype = colors.filetype .. self:get_filetype()
	local line_col = colors.line_col .. self:get_line_col()
	local line_col_alt = colors.line_col_alt .. self.separators[active_sep][2]

	-- vim.cmd(string.format('echo "I am executing 1"'))

	return table.concat({
		colors.active,
		mode,
		mode_alt,
		git,
		git_alt,
		"%=",
		filename,
		"%=",
		filetype_alt,
		filetype,
		line_col_alt,
		line_col,
	})
end

M.set_inactive = function(self)
	return self.colors.inactive .. "%= %F %="
end

M.set_explorer = function(self)
	local title = self.colors.mode .. " NvimTree "
	local title_alt = self.colors.mode_alt .. self.separators[active_sep][1]

	return table.concat({ self.colors.active, title, title_alt })
end

return M
