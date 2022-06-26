-- plugin options --

----------------------------------------------------------

-- cmake opts

local Path = require("plenary.path")

require("cmake").setup({
	cmake_executable = "cmake", -- CMake executable to run.
	parameters_file = "neovim.json", -- JSON file to store information about selected target, run arguments and build type.
	build_dir = tostring(Path:new("{cwd}", "build", "{os}-{build_type}")), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
	default_projects_path = tostring(Path:new(vim.loop.os_homedir(), "Projects")), -- Default folder for creating project.
	configure_args = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1", "-G", "Ninja" }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
	build_args = {}, -- Default arguments that will be always passed at cmake build step.
	on_build_output = nil, -- Callback which will be called on every line that is printed during build process. Accepts printed line as argument.
	quickfix_height = 5, -- Height of the opened quickfix.
	quickfix_only_on_error = false, -- Open quickfix window only if target build failed.
	copy_compile_commands = true, -- Copy compile_commands.json to current working directory.
})

----------------------------------------------------------

-- treesitter opts
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"cpp",
		"rust",
		"lua",
		"bash",
		"cmake",
		"css",
		"bibtex",
		"zig",
		"go",
		"html",
		"javascript",
		"java",
		"latex",
		"llvm",
		"ninja",
		"python",
		"yaml",
		"vim",
	},
	sync_install = false,
	ignore_install = { "javascript" },
	highlight = {
		-- disable = { "latex", "tex" },
		enable = true,
		additional_vim_regex_highlighting = true,
	},
})

-- lualine setup
require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "tokyonight",
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", {
			"diagnostics",
			sources = { "nvim_diagnostic" },
		} },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})

-- goyo opts
vim.g.goyo_width = 100

-- indent line opts
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = false,
}

----------------------------------------------------------

-- gitsigns setup
require("gitsigns").setup()

-- vimtex/tex opts
vim.g.tex_flavor = "latex"
-- vim.g.tex_conceal = "abdmg"
vim.g.vimtex_quickfix_mode = 0
-- vim.opt.conceallevel = 1

----------------------------------------------------------

-- nvim-tree setup
require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = false,
})

-- nvim-tree opts
vim.g.nvim_tree_show_icons = {
	["git"] = 1,
	["folders"] = 0,
	["files"] = 0,
	["folder_arrows"] = 0,
}

vim.g.nvim_tree_icons = {
	["default"] = "",
	["symlink"] = "",
	["git"] = {
		["unstaged"] = "✗",
		["staged"] = "✓",
		["unmerged"] = "",
		["renamed"] = "➜",
		["untracked"] = "★",
		["deleted"] = "",
		["ignored"] = "◌",
	},
	["folder"] = {
		["arrow_open"] = "",
		["arrow_closed"] = "",
		["default"] = "📁",
		["open"] = "📂",
		["empty"] = "",
		["empty_open"] = "",
		["symlink"] = "",
		["symlink_open"] = "",
	},
}

----------------------------------------------------------

-- nvim-autopairs

require("nvim-autopairs").setup({})

----------------------------------------------------------

-- startup setup

require("startup").setup({ theme = "startify" })
