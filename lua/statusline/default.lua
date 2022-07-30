local M = {
	component_opts = {
		mode = {
			disable = false,
			length = 80,
		},

		filename = {
			disable = false,
			length = 140,
		},

		filetype = {
			disable = false,
			length = 20,
		},

		lsp_diagnostics = {
			disable = true,
			length = 20,
		},

		git_diff = {
			disable = true,
			length = 40,
		},

		git_branch = {
			disable = true,
			length = 50,
		},

		cursor_location = {
			disable = false,
			length = 50,
		},
	},

	left_separator = "",
	right_separator = "",
	internal_separator = "|",

	section = {
		lll = {
			"mode",
		},

		ll = {
			"git_branch",
			"git_diff",
		},

		l = {
			-- "git_diff"
		},

		m = {
			"filename",
		},

		r = {
			-- "lsp_diagnostics",
			-- "filetype",
		},

		rr = {
			"lsp_diagnostics",
			"filetype",
		},

		rrr = {
			"cusor_location",
		},
	},
}

return M
