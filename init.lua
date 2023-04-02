local keymap = vim.keymap
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

require("lazy").setup({
	-- snippets

	-- lsp config
	"neovim/nvim-lspconfig",

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
	},

	"saadparwaiz1/cmp_luasnip",

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case",
					},
				},
			})

			telescope.load_extension("fzf")

			local builtin = require("telescope.builtin")

			keymap.set("n", "<leader>ff", builtin.find_files, {})
			keymap.set("n", "<leader>fg", builtin.git_files, {})
			keymap.set("n", "<leader>fb", builtin.buffers, {})
			keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},

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

	-- git integration
	{
		"lewis6991/gitsigns.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- actions
					map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
					map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},

	-- catppuccin
	{ "catppuccin/nvim", name = "catppuccin" },

	-- neodev
	"folke/neodev.nvim",

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

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",

		config = function()
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
		end,
	},
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

require("options/default-options")
require("bindings/default-bindings")
require("autocomplete")
require("lsp")

require("statusline").setup()
