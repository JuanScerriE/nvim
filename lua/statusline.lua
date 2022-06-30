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
	local current_width = api.nvim_win_get_width(0)
	return current_width < width
end

M.colors = {
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
	{ "StatusLine", { fg = "#3C3836", bg = "#EBDBB2" } },
	{ "StatusLineNC", { fg = "#3C3836", bg = "#928374" } },
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

for name, val in pairs(highlights) do
	set_hl(name, val)
end

M.separators = {
	arrow = { "", "" },
	rounded = { "", "" },
	blank = { "", "" },
}

local active_sep = "blank"

M.modes = setmetatable({
	["n"] = { "Normal", "N" },
	["no"] = { "N·Pending", "N·P" },
	["v"] = { "Visual", "V" },
	["V"] = { "V·Line", "V·L" },
	[""] = { "V·Block", "V·B" },
	["s"] = { "Select", "S" },
	["S"] = { "S·Line", "S·L" },
	[""] = { "S·Block", "S·B" },
	["i"] = { "Insert", "I" },
	["ic"] = { "Insert", "I" },
	["R"] = { "Replace", "R" },
	["Rv"] = { "V·Replace", "V·R" },
	["c"] = { "Command", "C" },
	["cv"] = { "Vim·Ex ", "V·E" },
	["ce"] = { "Ex ", "E" },
	["r"] = { "Prompt ", "P" },
	["rm"] = { "More ", "M" },
	["r?"] = { "Confirm ", "C" },
	["!"] = { "Shell ", "S" },
	["t"] = { "Terminal ", "T" },
}, {
	__index = function()
		return { "Unknown", "U" } -- handle edge cases
	end,
})

M.get_current_mode = function()
	local current_mode = api.nvim_get_mode().mode

	if self:is_truncated(self.trunc_width.mode) then
		return string.format(" %s ", modes[current_mode][2]):upper()
	end

	return string.format(" %s ", modes[current_mode][1]):upper()
end

M.get_git_status = function(self)
	-- use fallback because it doesn't set this variable on the initial `BufEnter`
	local signs = vim.b.gitsigns_status_dict or { 
    added = 0,
    changed = 0,
    removed = 0,
    head = "",
  }

	local is_head_empty = signs.head ~= ""

	if self:is_truncated(self.trunc_width.git_status) then
		return is_head_empty and string.format(" %s ", signs.head or "") or ""
	end

	return is_head_empty
			and string.format(" +%s ~%s -%s | %s ", signs.added, signs.changed, signs.removed, signs.head)
		or ""
end
