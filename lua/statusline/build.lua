local api = vim.api

local M = {}

local default = require("statusline.default")
local theme = require("statusline.theme")
local builtin = require("statusline.builtin")
local next = next

local hl = theme.hl
local color = theme.colors

-- [[
-- For left separators fg is prev-bg and
-- bg is next-bg.
-- For rigth separators bg is prev-bg and
-- fg is next-bg.
-- ]]

local function isemptytbl(tbl)
	return tbl == nil or next(tbl) == nil
end

local function isemptystr(str)
	return str == nil or str == ""
end

function M.statusline(_opts)
	local statusline = ""
	local prev_color = nil

	local section = default.section
	local left_separator = default.left_separator
	local right_separator = default.right_separator

	-- {{ Left Section
	if not isemptytbl(section.lll) then
		statusline = table.concat({ statusline, hl.lll, " dummy " })
		prev_color = color["LLL"]
	end

	if not isemptytbl(section.ll) then
		if not isemptystr(left_separator) and not isemptytbl(prev_color) then
			local val = { fg = prev_color.bg, bg = color["LL"].bg }
			prev_color = nil
			api.nvim_set_hl(0, "LLLAlt", val)

			statusline = table.concat({ statusline, hl.lll_alt, left_separator })
		end

    statusline = table.concat({statusline, hl.ll, " %{require('statusline.component.mode').get_mode(20)} "})
		prev_color = color["LL"]
	end

	if not isemptytbl(section.l) then
		if not isemptystr(left_separator) and not isemptytbl(prev_color) then
			local val = { fg = prev_color.bg, bg = color["L"].bg }
			prev_color = nil
			api.nvim_set_hl(0, "LLAlt", val)

			statusline = table.concat({ statusline, hl.ll_alt, left_separator })
		end

    statusline = table.concat({statusline, hl.l, " dummy "})
		prev_color = color["L"]
	end

	if not isemptystr(left_separator) and not isemptytbl(prev_color) then
		local val = { fg = prev_color.bg, bg = color["M"].bg }
		prev_color = nil
		api.nvim_set_hl(0, "LAlt", val)

		statusline = table.concat({ statusline, hl.l_alt, left_separator })
	end
	-- }}

	-- {{ Middle Section
	statusline = table.concat({ statusline, hl.m, "%=" })

	if not isemptytbl(section.m) then
	  statusline = table.concat({ statusline, " dummy " })
	end

	statusline = table.concat({ statusline, "%=" })
	prev_color = color["M"]
	-- }}

	-- {{ Right Section
	if not isemptytbl(section.r) then
		if not isemptystr(right_separator) and not isemptytbl(prev_color) then
			local val = { fg = color["R"].bg, bg = prev_color.bg }
			prev_color = nil
			api.nvim_set_hl(0, "RAlt", val)

	    statusline = table.concat({ statusline, hl.r_alt , right_separator })
		end

	  statusline = table.concat({ statusline, hl.r , "dummy" })
		prev_color = color["R"]
	end

	if not isemptytbl(section.rr) then
		if not isemptystr(right_separator) and not isemptytbl(prev_color) then
			local val = { fg = color["RR"].bg, bg = prev_color.bg }
			prev_color = nil
			api.nvim_set_hl(0, "RRAlt", val)

	    statusline = table.concat({ statusline, hl.rr_alt , right_separator })
		end

	  statusline = table.concat({ statusline, hl.rr , " dummy " })
		prev_color = color["RR"]
	end

	if not isemptytbl(section.rrr) then
		if not isemptystr(right_separator) and not isemptytbl(prev_color) then
			local val = { fg = color["RRR"].bg, bg = prev_color.bg }
			prev_color = nil
			api.nvim_set_hl(0, "RRRAlt", val)

	    statusline = table.concat({ statusline, hl.rrr_alt , right_separator })
		end

	  statusline = table.concat({ statusline, hl.rrr , " dummy " })
	end
	-- }}

	return statusline
end

return M
