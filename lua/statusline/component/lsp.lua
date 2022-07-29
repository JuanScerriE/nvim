local api = vim.api
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local util = require("statusline.util")

local M = {}

function M.lsp_diagnostics_exists()
	return next(lsp.buf_get_clients(0)) ~= nil
end

local function get_diagnostic_count(severity)
	return vim.tbl_count(diagnostic.get(0, { severity = severity }))
end

function M.get_lsp_diagnositics(width)
	local error_count = get_diagnostic_count(diagnostic.severity.ERROR)
	local warn_count = get_diagnostic_count(diagnostic.severity.WARN)
	local info_count = get_diagnostic_count(diagnostic.severity.INFO)
	local hint_count = get_diagnostic_count(diagnostic.severity.HINT)

	local diagnostics = ""

	if error_count > 0 then
		diagnostic = diagnostic .. string.format(" E:%s ", error_count)
	end
	if warn_count > 0 then
		diagnostic = diagnostic .. string.format(" W:%s ", warn_count)
	end
	if info_count > 0 then
		diagnostic = diagnostic .. string.format(" I:%s ", info_count)
	end
	if hint_count > 0 then
		diagnostic = diagnostic .. string.format(" H:%s ", hint_count)
	end

	return diagnostics
end

return M
