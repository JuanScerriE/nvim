local M = {
	component_opts = {
		mode = {
			disable = false,
			length = 80,
			--force_short = false,
		},

		filename = {
			disable = false,
			length = 140,
			--force_relative_path = false,
			--force_absolute_path = false,
			--force_tail_path = false,
		},

		filetype = {
			disable = false,
			length = 20,
			--uppercase = false,
			--lowercase = true,
			-- if none of these two are set we'll just use the default
			-- value
		},

		lsp_status = {
			disable = true,
			length = 20,
			--enable_errors = true,
			--enable_warnings = true,
			--enable_information = true,
			--enable_hints = false,
		},

		git_diff = {
			disable = true,
			length = 40,
			--force_diff = false,
			--enable_diff = true,
			--enable_branch = true,
		},

		git_branch = {
			disable = true,
			length = 50,
		},

		line_column = {
			disable = false,
			length = 60,
			--force_short = false,
			--num_of_chars_for_lines = 4,
			--num_of_chars_for_columns = 3,
		},
	},
	sections = {
		section_lll = {},
		section_ll = {},
		section_l = {},
		section_m = {},
		section_r = {},
		section_rr = {},
		section_rrr = {},
	},
}

return M
