require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"cpp",
		"ninja",
		"cmake",
		"go",
		"rust",
		"yaml",
		"html",
		"css",
		"java",
		"python",
		"lua",
		"bash",
		"vim",
	},
	sync_install = false,
	highlight = {
		enable = true,
		disable = { "latex" },
		additional_vim_regex_highlighting = false,
	},
})
