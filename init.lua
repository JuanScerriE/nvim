local loop = vim.loop
local opt = vim.opt
local fn = vim.fn
local g = vim.g
local o = vim.o

-- init --

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

opt.rtp:prepend(lazypath)

g.mapleader = ";"

local telescope_cmake_build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"

require("lazy").setup({

	-- lsp config
	{
        "neovim/nvim-lspconfig",
        config = function()
            require("config-lsp")
        end,
    },

    -- snippets
	"L3MON4D3/LuaSnip",

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
        config = function()
            require("config-completion")
        end,
	},

    -- nvim cmp luasnip compatibility
	"saadparwaiz1/cmp_luasnip",


	-- which-key
	{
		"folke/which-key.nvim",
		config = function()
			o.timeout = true
			o.timeoutlen = 400

			require("which-key").setup()
		end,
	},

	-- autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- comment
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- tex/latex integration
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			opt.conceallevel = 1
			g.tex_flavor = "latex"
			g.tex_conceal = "abdmg"
			g.vimtex_quickfix_mode = 1
		end,
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = telescope_cmake_build,
			},
		},
		config = function()
            require("config-telescope")
		end,
	},

	-- git integration
	{
		"lewis6991/gitsigns.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("config-gitsigns")
		end,
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config-treesitter")
		end,
	},

	-- catppuccin
	{ "catppuccin/nvim", name = "catppuccin" },

	-- neodev
	"folke/neodev.nvim",
}, {
	ui = {
		icons = {
			cmd = "cmd",
			config = "config",
			event = "event",
			ft = "ft",
			init = "init",
			keys = "keys",
			plugin = "plugin",
			runtime = "runtime",
			source = "source",
			start = "start",
			task = "task",
			lazy = "lazy",
		},
	},
})

require("common-options")
require("common-bindings")

require("statusline").setup()
