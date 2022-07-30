local api = vim.api
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local tbl_count = vim.tbl_count
local bo = vim.bo
local wo = vim.wo

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
	["R"] =  "REPLACE",
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

M.mode = function()
  return modes[api.nvim_get_mode().mode]
end

M.filepath = function()
  return " %m %<%f "
end

M.lsp = function()
  local error_count = tbl_count(diagnostic.get(0, { severity = diagnostic.severity.ERROR }))
  local warn_count = tbl_count(diagnostic.get(0, { severity = diagnostic.severity.WARN }))
  local info_count = tbl_count(diagnostic.get(0, { severity = diagnostic.severity.INFO }))
  local hint_count = tbl_count(diagnostic.get(0, { severity = diagnostic.severity.HINT }))

  local diagnostic_msg = ""

  if error_count > 0 then
    diagnostic_msg = diagnostic_msg .. string.format(" E:%s ", error_count)
  end

  if warn_count > 0 then
    diagnostic_msg = diagnostic_msg .. string.format(" W:%s ", warn_count)
  end

  if info_count > 0 then
    diagnostic_msg = diagnostic_msg .. string.format(" I:%s ", info_count)
  end

  if hint_count > 0 then
    diagnostic_msg = diagnostic_msg .. string.format(" H:%s ", hint_count)
  end

  print(diagnostic_msg)

  return diagnostic_msg
end

M.fileinfo = function()
  return " %Y  [%-03.5l : %-03.5c]  %P "
end

local function active()
  wo.statusline = table.concat({
    "%#Statusline#",
    " %{luaeval(\"require('statusline2').mode()\")} ",
    " %{luaeval(\"require('statusline2').lsp()\")} ",
    "%=",
    M.filepath(),
    "%=",
    M.fileinfo(),
  })
end

local function inactive()
  wo.statusline = table.concat({
    "#StatuslineNC#",
    "%=",
    M.filepath(),
    "%=",
  })
end

M.setup = function()
  local statusline_gp = api.nvim_create_augroup("Statusline", {
  	clear = true,
  })
  
  api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  	callback = active,
  	group = statusline_gp,
  })
  
  api.nvim_create_autocmd({ "BufWinLeave", "WinLeave" }, {
  	callback = inactive,
  	group = statusline_gp,
  })
end

return M
