-- plugins --

local packer = require("packer")

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float()
		end,
	},
})

return packer.startup(function()
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
	use("ful1e5/onedark.nvim")
	use("lifepillar/vim-gruvbox8")
	use("sainnhe/everforest")
  use("folke/tokyonight.nvim")

  -- indent lines
  use("lukas-reineke/indent-blankline.nvim") 

	-- distraction free writing
	use("junegunn/goyo.vim")
	use("junegunn/limelight.vim")

	-- good greeter
	use({
		"startup-nvim/startup.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})

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

	-- lsp signature source for nvim-cmp
	use("hrsh7th/cmp-nvim-lsp-signature-help")

	-- buffer source for nvim-cmp
	use("hrsh7th/cmp-buffer")

	-- path source for nvim-cmp
	use("hrsh7th/cmp-path")

	-- cmdline source for nvim-cmp
	use("hrsh7th/cmp-cmdline")

	use("mfussenegger/nvim-dap")

	-- cmake support
	use({
		"Shatur/neovim-cmake",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- snipptes plugin
	use("hrsh7th/vim-vsnip")

	-- lsp plugin integration
	use("hrsh7th/vim-vsnip-integ")

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
