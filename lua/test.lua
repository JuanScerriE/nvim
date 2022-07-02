local highlights = {
	["NvimTreeStatusLine"] = { fg = "#3C3836", bg = "#EBDBB2" },
	["NvimTreeStatusLineNC"] = { fg = "#EBDBB2", bg = "#3C3836" },
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

for name, val in pairs(highlights) do
	print(name, val)
end
