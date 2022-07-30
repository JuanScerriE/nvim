local api = vim.api

local M = {}

M.hlold = {
	-- nvim_tree_active = "%#NvimTreeStatusLine#",
	-- nvim_tree_inactive = "%#NvimTreeStatusLineNC#",
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

M.hl = {
	lll = "%#LLL#",
	lll_alt = "%#LLLAlt#",

	ll = "%#LL#",
	ll_alt = "%#LLAlt#",

	l = "%#L#",
	l_alt = "%#LAlt#",

	m = "%#M#",

	r_alt = "%#RAlt#",
	r = "%#R#",

	rr_alt = "%#RRAlt#",
	rr = "%#RR#",

	rrr_alt = "%#RRRAlt#",
	rrr = "%#RRR#",
}

local gruvbox_dark_theme = {
	muted_red = "#cc241d",
	muted_green = "#98971a",
	muted_yellow = "#d79921",
	muted_blue = "#458588",
	muted_purple = "#b16286",
	muted_aqua = "#689d6a",
	muted_orange = "#d65d0e",

	bright_red = "#fb4934",
	bright_green = "#b8bb26",
	bright_yellow = "#fabd2f",
	bright_blue = "#83a598",
	bright_purple = "#d3869b",
	bright_aqua = "#8ec07c",
	bright_orange = "#fe8019",

	bright_gray = "#928374",
	mid_gray = "#928374",
	muted_gray = "#a89984",

	bg = "#282828",
	bg0_h = "#1d2021",
	bg0_s = "#32302f",
	bg0 = "#282828",
	bg1 = "#3c3836",
	bg2 = "#504945",
	bg3 = "#665c54",
	bg4 = "#7c6f64",

	fg = "#ebdbb2",
	fg0 = "#fbf1c7",
	fg1 = "#ebdbb2",
	fg2 = "#d5c4a1",
	fg3 = "#bdae93",
	fg4 = "#a89984",
}

local theme = gruvbox_dark_theme

local highlights = setmetatable({
	["gruvbox"] = {
		-- ["NvimTreeStatusLine"] = { fg = "#3C3836", bg = "#EBDBB2" },
		-- ["NvimTreeStatusLineNC"] = { fg = "#EBDBB2", bg = "#3C3836" },
		["StatusLine"] = { fg = "#3C3836", bg = "#EBDBB2" },
		["StatusLineNC"] = { fg = "#EBDBB2", bg = "#3C3836" },
		["Mode"] = { bg = "#928374", fg = "#1D2021" },
		["LineCol"] = { bg = "#928374", fg = "#1D2021" },
		["Git"] = { bg = "#504945", fg = "#EBDBB2" },
		["Filetype"] = { bg = "#504945", fg = "#EBDBB2" },
		["Filename"] = { bg = "#504945", fg = "#EBDBB2" },
		["ModeAlt"] = { bg = "#504945", fg = "#928374" },
		["GitAlt"] = { bg = "#3C3836", fg = "#504945" },
		["LineColAlt"] = { bg = "#504945", fg = "#928374" },
		["FiletypeAlt"] = { bg = "#3C3836", fg = "#504945" },
	},
}, {
	__index = function()
		return {
			-- ["NvimTreeStatusLine"] = { fg = "#3C3836", bg = "#EBDBB2" },
			-- ["NvimTreeStatusLineNC"] = { fg = "#EBDBB2", bg = "#3C3836" },
			["StatusLine"] = { fg = "#3C3836", bg = "#EBDBB2" },
			["StatusLineNC"] = { fg = "#EBDBB2", bg = "#3C3836" },
			["Mode"] = { bg = "#928374", fg = "#1D2021", gui = "bold" },
			["LineCol"] = { bg = "#928374", fg = "#1D2021", gui = "bold" },
			["Git"] = { bg = "#504945", fg = "#EBDBB2" },
			["Filetype"] = { bg = "#504945", fg = "#EBDBB2" },
			["Filename"] = { bg = "#504945", fg = "#EBDBB2" },
			["ModeAlt"] = { bg = "#504945", fg = "#928374" },
			["GitAlt"] = { bg = "#3C3836", fg = "#504945" },
			["LineColAlt"] = { bg = "#504945", fg = "#928374" },
			["FiletypeAlt"] = { bg = "#3C3836", fg = "#504945" },
		}
	end,
})

M.colors = {
	["LLL"] = { bg = theme.mid_gray, fg = "#1D2021" },
	["LLLAlt"] = { bg = theme.bg3, fg = theme.mid_gray },

	["LL"] = { bg = theme.bg3, fg = theme.fg2 },
	["LLAlt"] = { bg = theme.bg2, fg = theme.bg3 },

	["L"] = { bg = theme.bg2, fg = theme.fg },
	["LAlt"] = { bg = theme.bg1, fg = theme.bg2 },

	["M"] = { bg = theme.bg1, fg = theme.fg },

	["RAlt"] = { bg = theme.bg1, fg = theme.bg2 },
	["R"] = { bg = theme.bg2, fg = theme.fg },

	["RRAlt"] = { bg = theme.bg2, fg = theme.bg3 },
	["RR"] = { bg = theme.bg3, fg = theme.fg2 },

	["RRRAlt"] = { bg = theme.bg3, fg = theme.mid_gray },
	["RRR"] = { bg = theme.mid_gray, fg = "#1D2021" },
}

M.setup = function()
	for name, val in pairs(M.colors) do
		api.nvim_set_hl(0, name, val)
	end
end

return M
