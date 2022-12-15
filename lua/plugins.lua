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
	use("numToStr/Comment.nvim")

	-- better brackets
	use("tpope/vim-surround")
	use("windwp/nvim-autopairs")

	---------------------------------------

	-- tree-sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- colorscheme
	use("sainnhe/everforest")
    use("kvrohit/mellow.nvim")

	-- session manager
	use({ "Shatur/neovim-session-manager" })

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

	-- debugger
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
	use({
		"ziglang/zig.vim",
		ft = { "zig" },
	})

	-- jdtls improvements
	use({
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
	})

	---------------------------------------

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- fuzzy finder extension
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})

	-- navigation tree
	use("kyazdani42/nvim-tree.lua")
end)
