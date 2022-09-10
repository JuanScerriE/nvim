local api = vim.api
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local tbl_count = vim.tbl_count
local wo = vim.wo
local b = vim.b

local M = {}

local modes = setmetatable({
	["n"] = "NORMAL",
	["nt"] = "NORMAL",
	["no"] = "N-PENDING",
	["v"] = "VISUAL",
	["V"] = "V-LINE",
	[""] = "V-BLOCK",
	["s"] = "SELECT",
	["S"] = "S-LINE",
	[""] = "S-BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "V-REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM-EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}, {
	__index = function()
		return "UNKNOWN" -- handle edge cases
	end,
})

-- FIX: Add a space because one is stripped. "  %s "

M.mode = function()
	return string.format("  %s ", modes[api.nvim_get_mode().mode])
end

local function filepath()
	return " %((%M)%) %<%f "
end

local function lsp_exists()
	return next(lsp.buf_get_clients(0)) ~= nil
end

M.lsp = function()
	local error_count = tbl_count(diagnostic.get(0, { severity = diagnostic.severity.ERROR }))
	local warn_count = tbl_count(diagnostic.get(0, { severity = diagnostic.severity.WARN }))
	local info_count = tbl_count(diagnostic.get(0, { severity = diagnostic.severity.INFO }))
	local hint_count = tbl_count(diagnostic.get(0, { severity = diagnostic.severity.HINT }))

	if lsp_exists() then
		return string.format("  [E%s W%s I%s H%s] ", error_count, warn_count, info_count, hint_count)
	else
		return ""
	end
end

local function git_exists()
	return b.gitsigns_status_dict or b.gitsigns_head
end

M.git = function()
	if git_exists() then
		return string.format(
			"  [+%s ~%s -%s | %s] ",
			b.gitsigns_status_dict.added or 0,
			b.gitsigns_status_dict.changed or 0,
			b.gitsigns_status_dict.removed or 0,
			b.gitsigns_status_dict.head
		)
	else
		return ""
	end
end

local function fileinfo()
	return " %((%M)%) %<%f  %y  [%03.5l : %03.5c]  %P "
end

local function active()
	wo.statusline = table.concat({
		"%#Statusline#",
		"%{luaeval(\"require('statusline').mode()\")}",
		"%{luaeval(\"require('statusline').git()\")}",
		"%{luaeval(\"require('statusline').lsp()\")}",
		"%=",
		fileinfo(),
	})
end

local function inactive()
	wo.statusline = table.concat({
		"%#StatuslineNC#",
		"%=",
		filepath(),
	})
end

M.setup = function()
	local statusline_gp = api.nvim_create_augroup("Statusline", {
		clear = true,
	})

	api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
		callback = active,
		group = statusline_gp,
	})

	api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
		callback = inactive,
		group = statusline_gp,
	})
end

return M
