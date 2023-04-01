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

	-- zen mode
	use("folke/zen-mode.nvim")

	-- local lighting
	use("folke/twilight.nvim")

	---------------------------------------

	-- tree-sitter
	use("nvim-treesitter/nvim-treesitter")

	-- colorschemes

	-- use("sainnhe/everforest")
	-- use("kvrohit/mellow.nvim")

	use({ "catppuccin/nvim", as = "catppuccin" })

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

	-- snipptes plugin
	use("hrsh7th/vim-vsnip")

	-- lsp plugin integration
	use("hrsh7th/vim-vsnip-integ")

	-- cmake support
	use({
		"Shatur/neovim-cmake",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- debugger
	use({
		"mfussenegger/nvim-dap",
		ft = { "c", "cpp", "cmake" },
		config = function()
			local dap = require("dap")

			dap.adapters.lldb = {
				type = "executable",
				command = "lldb-vscode",
				name = "lldb",
			}

			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = false,
				},
			}

            vim.keymap.set("n", "<leader>dk", dap.continue)
            vim.keymap.set("n", "<leader>dl", dap.run_last)
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
		end,
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
	use({
		"kyazdani42/nvim-tree.lua",
		opt = true,
		config = function()
			-- nvim-tree setup
			require("nvim-tree").setup({
				disable_netrw = true,
				hijack_netrw = true,
				renderer = {
					icons = {
						show = {
							git = true,
							folder = false,
							file = false,
							folder_arrow = false,
						},
					},
				},
			})
		end,
	})
end)
