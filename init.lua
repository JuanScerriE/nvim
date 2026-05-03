-- use :help to figure out what these do e.g. :help mouse

-- globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false

-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = true
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.completeopt = "menu,popup,fuzzy,noinsert"
-- vim.opt.laststatus = 3
-- vim.opt.statusline = [[%<%f %h%w%m%r%=%-14.(%l,%c%V%) %P %y]]
vim.opt.foldmethod = "marker"

-- keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>O", "<cmd>set spell!<cr>", { desc = "Toggle [O]rthographic Checking" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "[W]indow" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "grd", vim.lsp.buf.definition)
vim.keymap.set("n", "grD", vim.lsp.buf.declaration)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("juan-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "sainnhe/sonokai" },

	{ "tpope/vim-sleuth" }, -- detect tabstop and shiftwidth automatically

	{ "tpope/vim-fugitive" }, -- add support for Git

	{ -- useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		opts = {
			icons = {
				mappings = false,
			},
			delay = 300,
		},
		lazy = false,
	},

	{ -- improve the navigation experience
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
			-- mimic vim-vinegar
			vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open Parent Directory" })
		end,
		lazy = false,
	},

	{ -- autoformat
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = true,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_organize_imports", "ruff_format" },
				ocaml = { "ocamlformat" },
				tex = { "latexindent" },
				html = { "prettier" },
				json = { "prettier" },
				javascript = { "prettier" },
			},
			formatters = {
				latexindent = {
					prepend_args = { "-l" },
				},
			},
		},
		lazy = false,
	},

	{ "mason-org/mason.nvim", opts = {} },

	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local mason_dap = require("mason-nvim-dap")
			local dap = require("dap")
			local ui = require("dapui")
			local dap_virtual_text = require("nvim-dap-virtual-text")

			mason_dap.setup({
				ensure_installed = { "cppdbg" },
				automatic_installation = true,
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			dap.set_log_level("TRACE")
			dap_virtual_text.setup()
			ui.setup()

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
				},
				{
					name = "Attach to gdbserver :1234",
					type = "cppdbg",
					request = "launch",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:1234",
					miDebuggerPath = "/usr/bin/gdb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
				},
			}

			dap.configurations.c = dap.configurations.cpp
		end,
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle({})
				end,
				desc = "Dap UI",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},

			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},

			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to Cursor",
			},

			{
				"<leader>dT",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate",
			},
		},
	},

	{ -- fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },

			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					preview = {
						treesitter = false,
					},
					layout_config = {
						width = 0.95,
						height = 0.95,
						-- preview_width = 0.65,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "[F]ind [M]arks" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols, { desc = "[F]ind [W]orkspace Symbols" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>f/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[F]ind [/] in Open Files" })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({ "svelte", "javascript", "typescript", "html", "cpp", "c", "go" })
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			-- Set up nvim-cmp.
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

						-- For `mini.snippets` users:
						-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
						-- insert({ body = args.body }) -- Insert at cursor
						-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
						-- require("cmp.config").set_onetime({ sources = {} })
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" }, -- For vsnip users.
					-- { name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config["pyright"] = {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = {
					"pyrightconfig.json",
					"pyproject.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					"Pipfile",
					".git",
				},
				capabilities = capabilities,
			}

			vim.lsp.config["ccls"] = {
				init_options = {
					compilationDatabaseDirectory = ".",
					index = {
						threads = 0,
					},
					clang = {},
				},
			}

			vim.lsp.config["clangd"] = {
				cmd = { "clangd", "--experimental-modules-support" },
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				root_markers = {
					"compile_commands.json",
					".clangd",
					".clang-format",
					".clangd-tidy",
					"compile_flags.txt",
				},
				settings = {
					single_file_support = true,
				},
				capabilities = capabilities,
			}

			vim.lsp.config["luals"] = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { ".luarc.json", ".luarc.jsonc" },
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
					},
				},
				capabilities = capabilities,
			}

			vim.lsp.config["gopls"] = {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
					},
				},
				capabilities = capabilities,
			}

			vim.lsp.config["rust_analyzer"] = {
				cmd = { "rust-analyzer" },
				filetypes = { "rust" },
				root_markers = { "Cargo.toml" },
				capabilities = capabilities,
			}

			vim.lsp.config["ocamllsp"] = {
				cmd = { "ocamllsp", "--fallback-read-dot-merlin" },
				filetypes = { "ocaml", "menhir", "ocamlinterface", "ocamllex", "reason", "dune" },
				root_markers = { "*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace" },
				settings = {
					single_file_support = true,
				},
				capabilities = capabilities,
			}

			vim.lsp.config["zls"] = {
				cmd = { "zls" },
				filetypes = { "zig", "zir" },
				root_markers = { "zls.json", "build.zig", "build.zig.zon", ".git" },
				capabilities = capabilities,
			}

			vim.lsp.config["svelte"] = {
				cmd = { "svelteserver", "--stdio" },
				filetypes = {
					"svelte",
				},
				root_markers = { "package-lock.json" },
				capabilities = capabilities,
			}

			vim.lsp.config["ltex-ls-plus"] = {
				cmd = { "ltex-ls-plus" },
				filetypes = {
					"bib",
					"context",
					"gitcommit",
					"html",
					"markdown",
					"org",
					"pandoc",
					"plaintex",
					"quarto",
					"mail",
					"mdx",
					"rmd",
					"rnoweb",
					"rst",
					"tex",
					"text",
					"typst",
					"xhtml",
				},
				root_markers = { ".git" },
				settings = {
					ltex = {
						enabled = {
							"bib",
							"context",
							"gitcommit",
							"html",
							"markdown",
							"org",
							"pandoc",
							"plaintex",
							"quarto",
							"mail",
							"mdx",
							"rmd",
							"rnoweb",
							"rst",
							"tex",
							"latex",
							"text",
							"typst",
							"xhtml",
						},
					},
				},
				capabilities = capabilities,
			}

			vim.lsp.enable({
				"zls",
				"svelte",
				"gopls",
				-- "clangd",
				"ccls",
				"cmake",
				"luals",
				"rust_analyzer",
				"ocamllsp",
				"ltex-ls-plus",
				"pyright",
			})
		end,
	},

	{ -- write nicely typeset math in neovim (tex/latex integration)
		"lervag/vimtex",
		-- ft = "tex", -- HACK: always load to enable inverse search
		init = function()
			vim.g.vimtex_syntax_conceal_disable = 1

			vim.g.vimtex_compiler_latexmk = {
				["aux_dir"] = ".tex-aux",
			}
			vim.g.vimtex_compiler_latexmk_engines = {
				["_"] = "-lualatex -shell-escape",
			}
		end,
		config = function()
			vim.opt.cole = 0

			if vim.uv.os_uname().sysname == "Darwin" then
				vim.g.vimtex_view_method = "skim"
			elseif vim.uv.os_uname().sysname == "Linux" then
				-- vim.g.vimtex_view_method = "zathura"
				vim.g.vimtex_view_general_viewer = "okular"
				vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
			end
		end,
	},
}, {
	ui = {
		icons = {},
	},
})

vim.cmd.colorscheme("sonokai")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
