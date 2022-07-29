status = {}

local hl = require("statusline.theme").hl
local component = require("statusline.component2")

local separators = {
	arrow = { left = "", right = "" },
	rounded = { left = "", right = "" },
	blank = { left = "", right = "" },
}

local active_sep = "arrow"

status.active = function()
	local mode = hl.mode .. " %{luaeval(\"require('statusline.component1.mode'):get_mode()\")} "
	local mode_alt = hl.mode_alt .. separators[active_sep].left
	local git = hl.git .. " %{luaeval(\"require('statusline.component2'):git_status()\")} "
	-- local sep = "|"
	-- local lsp = hl.git .. " %{luaeval(\"require('statusline.component'):lsp_diagnostic()\")} "
	local git_alt = hl.git_alt .. separators[active_sep].left
	local filename = hl.inactive .. component:filename()
	local filetype_alt = hl.filetype_alt .. separators[active_sep].right
	local filetype = hl.filetype .. component:filetype()
	local line_col = hl.line_col .. component:line_column()
	local line_col_alt = hl.line_col_alt .. separators[active_sep].right

	vim.opt_local.statusline = table.concat({
		hl.active,
		mode,
		mode_alt,
		git,
		-- sep,
		-- lsp,
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

status.inactive = function()
	vim.opt_local.statusline = hl.inactive .. "%= %F %="
end

return status
