local loop = vim.loop
local opt = vim.opt
local fn = vim.fn
local g = vim.g
local o = vim.o

-- install lazy if it is not installed
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

-- set the leader and local leader
g.mapleader = ";"
g.maplocalleader = ";"

-- some locals to make the plugin section less cluttered
local telescope_cmake_build =
	"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"

local config_lsp = require("config.lsp")
local config_non_lsp = require("config.non-lsp")

-- deal with plugins
require("lazy").setup({

	-- manages my external dependencies
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- just so lua_ls does not complain about neovim api
	"folke/neodev.nvim",

	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			config_lsp.setup()
		end,
	},

	-- let mason manage my lspconfig as well
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = config_lsp.servers,
			})
		end,
	},

	-- somethings should have an lsp interface you know
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"nvim-lua/plenary.nvim",
		},
		ft = { "python" },
		config = function()
			config_non_lsp.setup()
		end,
	},

	-- nvim cmp
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
			require("config.completion")
		end,
	},

	-- nvim cmp luasnip compatibility
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
		},
	},

	-- tell me which key comes next
	{
		"folke/which-key.nvim",
		config = function()
			o.timeout = true
			o.timeoutlen = 400

			require("which-key").setup()
		end,
	},

	-- make autopairs a thing
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- comment related improvements
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- write nicely typeset math in neovim (tex/latex integration)
	{
		"lervag/vimtex",
		ft = "tex",
		init = function()
			g.vimtex_compiler_latexmk_engines = {
				["_"] = "-lualatex",
			}
		end,
	},

	-- git integration (magit is actually good)
	{
		"lewis6991/gitsigns.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("config.gitsigns")
		end,
	},

	-- i wish we had a fuzzy finder for physical paper
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
			require("config.telescope")
		end,
	},

	-- somehow sitting on trees makes code look nicer
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
	},

	-- i need a cappuccino made by cat
	{ "catppuccin/nvim", name = "catppuccin" },
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

-- common options related to neovim
require("common.bindings")
require("common.options")

-- setup the statusline
require("statusline").setup()
