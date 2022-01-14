-- plugins --

return require("packer").startup(function()
	-- packer.nvim manages itself
	use("wbthomason/packer.nvim")

	---------------------------------------

	-- better commenting
	use("tpope/vim-commentary")

	-- better brackets
	use("tpope/vim-surround")
	use("windwp/nvim-autopairs")

	---------------------------------------

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- tree-sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- colorscheme
	use("junegunn/seoul256.vim")
	use("joshdick/onedark.vim")
	use("lifepillar/vim-gruvbox8")
	use("sainnhe/everforest")
	-- use("arcticicestudio/nord-vim")
	-- use("drewtempelmeyer/palenight.vim")

	-- distraction free writing
	use("junegunn/goyo.vim")

	---------------------------------------

	-- git integration
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- tex/latex integration
	use({
		"lervag/vimtex",
		ft = { "tex" },
	})

	---------------------------------------

	-- lsp config
	use("neovim/nvim-lspconfig")

	-- autocomplete
	use("hrsh7th/nvim-cmp")

	-- lsp source for nvim-cmp
	use("hrsh7th/cmp-nvim-lsp")

	-- buffer source for nvim-cmp
	use("hrsh7th/cmp-buffer")

	-- snipptes plugin
	-- use("hrsh7th/vim-vsnip")

	-- lsp plugin integration
	-- use("hrsh7th/vim-vsnip-integ")

	---------------------------------------

	-- zig support
	use("ziglang/zig.vim")

	---------------------------------------

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- navigation tree
	use("kyazdani42/nvim-tree.lua")
end)
