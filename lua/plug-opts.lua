-- plugin options --

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
    "vim"
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
		theme = "auto",
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
