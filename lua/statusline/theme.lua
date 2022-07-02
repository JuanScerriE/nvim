local theme = {}

theme.hl = {
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

local themes = setmetatable({
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

theme.setup = function(theme_name)
	for name, val in pairs(themes[theme_name]) do
		vim.api.nvim_set_hl(0, name, val)
	end
end

return theme
