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
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
-- vim.opt.laststatus = 3

-- colorscheme
vim.cmd.colorscheme("retrobox")

-- keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>O", "<cmd>set spell!<cr>", { desc = "Toggle [O]rthographic Checking" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "[W]indow" })
vim.keymap.set("n", "<leader>mo", "<C-o>", { desc = "Ju[m]p to [O]ld position" })
vim.keymap.set("n", "<leader>mn", "<C-i>", { desc = "Ju[m]p to [N]ew position" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"tpope/vim-fugitive", -- Add support for Git

	-- write nicely typeset math in neovim (tex/latex integration)
	-- {
	-- 	"lervag/vimtex",
	-- 	ft = "tex",
	-- 	init = function()
	-- 		-- we want to use treesitter
	-- 		vim.g.vimtex_syntax_enabled = 0
	-- 		vim.g.vimtex_syntax_conceal_disable = 1
	--
	-- 		vim.g.vimtex_compiler_latexmk_engines = {
	-- 			["_"] = "-lualatex -shell-escape",
	-- 		}
	-- 	end,
	-- 	config = function()
	-- 		vim.opt.cole = 0
	--
	-- 		if vim.uv.os_uname().sysname == "Darwin" then
	-- 			vim.g.vimtex_view_method = "skim"
	-- 		end
	-- 	end,
	-- },

	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
	--    require('gitsigns').setup({ ... })
	--
	-- See `:help gitsigns` to understand what the configuration keys do
	-- { -- Adds git related signs to the gutter, as well as utilities for managing changes
	-- 	"lewis6991/gitsigns.nvim",
	-- 	opts = {
	-- 		signs = {
	-- 			add = { text = "+" },
	-- 			change = { text = "~" },
	-- 			delete = { text = "_" },
	-- 			topdelete = { text = "‾" },
	-- 			changedelete = { text = "~" },
	-- 		},
	-- 	},
	-- },

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			icons = {
				mappings = false,
			},
		},
		keys = {
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>c_", hidden = true },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>d_", hidden = true },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			{ "<leader>h_", hidden = true },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>r_", hidden = true },
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>f_", hidden = true },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>t_", hidden = true },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>w_", hidden = true },
		},
	},

	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			-- { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
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

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[F]ind [N]eovim files" })
		end,
	},

	-- { -- LSP Configuration & Plugins
	-- 	"neovim/nvim-lspconfig",
	-- 	dependencies = {
	-- 		-- Automatically install LSPs and related tools to stdpath for Neovim
	-- 		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
	-- 		"williamboman/mason-lspconfig.nvim",
	-- 		"WhoIsSethDaniel/mason-tool-installer.nvim",
	--
	-- 		-- Useful status updates for LSP.
	-- 		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
	-- 		{ "j-hui/fidget.nvim", opts = {} },
	--
	-- 		-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
	-- 		-- used for completion, annotations and signatures of Neovim apis
	-- 		{ "folke/neodev.nvim", opts = {} },
	-- 	},
	-- 	config = function()
	-- 		-- Brief aside: **What is LSP?**
	-- 		--
	-- 		-- LSP is an initialism you've probably heard, but might not understand what it is.
	-- 		--
	-- 		-- LSP stands for Language Server Protocol. It's a protocol that helps editors
	-- 		-- and language tooling communicate in a standardized fashion.
	-- 		--
	-- 		-- In general, you have a "server" which is some tool built to understand a particular
	-- 		-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
	-- 		-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
	-- 		-- processes that communicate with some "client" - in this case, Neovim!
	-- 		--
	-- 		-- LSP provides Neovim with features like:
	-- 		--  - Go to definition
	-- 		--  - Find references
	-- 		--  - Autocompletion
	-- 		--  - Symbol Search
	-- 		--  - and more!
	-- 		--
	-- 		-- Thus, Language Servers are external tools that must be installed separately from
	-- 		-- Neovim. This is where `mason` and related plugins come into play.
	-- 		--
	-- 		-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
	-- 		-- and elegantly composed help section, `:help lsp-vs-treesitter`
	--
	-- 		--  This function gets run when an LSP attaches to a particular buffer.
	-- 		--    That is to say, every time a new file is opened that is associated with
	-- 		--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
	-- 		--    function will be executed to configure the current buffer
	-- 		vim.api.nvim_create_autocmd("LspAttach", {
	-- 			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	-- 			callback = function(event)
	-- 				-- NOTE: Remember that Lua is a real programming language, and as such it is possible
	-- 				-- to define small helper and utility functions so you don't have to repeat yourself.
	-- 				--
	-- 				-- In this case, we create a function that lets us more easily define mappings specific
	-- 				-- for LSP related items. It sets the mode, buffer and description for us each time.
	-- 				local map = function(keys, func, desc)
	-- 					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
	-- 				end
	--
	-- 				-- Jump to the definition of the word under your cursor.
	-- 				--  This is where a variable was first declared, or where a function is defined, etc.
	-- 				--  To jump back, press <C-t>.
	-- 				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	--
	-- 				-- Find references for the word under your cursor.
	-- 				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	--
	-- 				-- Jump to the implementation of the word under your cursor.
	-- 				--  Useful when your language has ways of declaring types without an actual implementation.
	-- 				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	--
	-- 				-- Jump to the type of the word under your cursor.
	-- 				--  Useful when you're not sure what type a variable is and you want to see
	-- 				--  the definition of its *type*, not where it was *defined*.
	-- 				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	--
	-- 				-- Fuzzy find all the symbols in your current document.
	-- 				--  Symbols are things like variables, functions, types, etc.
	-- 				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	--
	-- 				-- Fuzzy find all the symbols in your current workspace.
	-- 				--  Similar to document symbols, except searches over your entire project.
	-- 				map(
	-- 					"<leader>ws",
	-- 					require("telescope.builtin").lsp_dynamic_workspace_symbols,
	-- 					"[W]orkspace [S]ymbols"
	-- 				)
	--
	-- 				-- Rename the variable under your cursor.
	-- 				--  Most Language Servers support renaming across files, etc.
	-- 				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	--
	-- 				-- Execute a code action, usually your cursor needs to be on top of an error
	-- 				-- or a suggestion from your LSP for this to activate.
	-- 				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	--
	-- 				-- Opens a popup that displays documentation about the word under your cursor
	-- 				--  See `:help K` for why this keymap.
	-- 				map("K", vim.lsp.buf.hover, "Hover Documentation")
	--
	-- 				-- WARN: This is not Goto Definition, this is Goto Declaration.
	-- 				--  For example, in C this would take you to the header.
	-- 				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	--
	-- 				-- The following two autocommands are used to highlight references of the
	-- 				-- word under your cursor when your cursor rests there for a little while.
	-- 				--    See `:help CursorHold` for information about when this is executed
	-- 				--
	-- 				-- When you move your cursor, the highlights will be cleared (the second autocommand).
	-- 				local client = vim.lsp.get_client_by_id(event.data.client_id)
	-- 				if client and client.server_capabilities.documentHighlightProvider then
	-- 					local highlight_augroup =
	-- 						vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
	-- 					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	-- 						buffer = event.buf,
	-- 						group = highlight_augroup,
	-- 						callback = vim.lsp.buf.document_highlight,
	-- 					})
	--
	-- 					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	-- 						buffer = event.buf,
	-- 						group = highlight_augroup,
	-- 						callback = vim.lsp.buf.clear_references,
	-- 					})
	--
	-- 					vim.api.nvim_create_autocmd("LspDetach", {
	-- 						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
	-- 						callback = function(event2)
	-- 							vim.lsp.buf.clear_references()
	-- 							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
	-- 						end,
	-- 					})
	-- 				end
	--
	-- 				-- The following autocommand is used to enable inlay hints in your
	-- 				-- code, if the language server you are using supports them
	-- 				--
	-- 				-- This may be unwanted, since they displace some of your code
	-- 				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
	-- 					map("<leader>th", function()
	-- 						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	-- 					end, "[T]oggle Inlay [H]ints")
	-- 				end
	-- 			end,
	-- 		})
	--
	-- 		-- LSP servers and clients are able to communicate to each other what features they support.
	-- 		--  By default, Neovim doesn't support everything that is in the LSP specification.
	-- 		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
	-- 		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
	-- 		local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- 		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
	--
	-- 		-- Enable the following language servers
	-- 		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
	-- 		--
	-- 		--  Add any additional override configuration in the following tables. Available keys are:
	-- 		--  - cmd (table): Override the default command used to start the server
	-- 		--  - filetypes (table): Override the default list of associated filetypes for the server
	-- 		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
	-- 		--  - settings (table): Override the default settings passed when initializing the server.
	-- 		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
	--
	-- 		local ensure_installed_servers = {
	-- 			lua_ls = {
	-- 				-- cmd = {...},
	-- 				-- filetypes = { ...},
	-- 				-- capabilities = {},
	-- 				settings = {
	-- 					Lua = {
	-- 						completion = {
	-- 							callSnippet = "Replace",
	-- 						},
	-- 						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
	-- 						-- diagnostics = { disable = { 'missing-fields' } },
	-- 					},
	-- 				},
	-- 			},
	-- 		}
	--
	-- 		-- Ensure the servers and tools above are installed
	-- 		--  To check the current status of installed tools and/or manually install
	-- 		--  other tools, you can run
	-- 		--    :Mason
	-- 		--
	-- 		--  You can press `g?` for help in this menu.
	-- 		require("mason").setup()
	--
	-- 		-- You can add other tools here that you want Mason to install
	-- 		-- for you, so that they are available from within Neovim.
	-- 		local ensure_installed = vim.tbl_keys(ensure_installed_servers or {})
	--
	-- 		vim.list_extend(ensure_installed, {
	-- 			"stylua", -- Used to format Lua code
	-- 		})
	--
	-- 		local servers = vim.deepcopy(ensure_installed_servers)
	--
	-- 		servers = vim.tbl_extend("error", servers, {
	-- 			ocamllsp = {
	-- 				single_file_support = true,
	-- 			},
	-- 			-- basedpyright = {},
	-- 			-- tsserver = {},
	-- 			-- vhdl_ls = {},
	-- 			-- rust_analyzer = {},
	-- 			hls = {
	-- 				filetypes = { "haskell", "lhaskell", "cabal" },
	-- 			},
	-- 			ltex = {},
	-- 			clangd = {},
	-- 		})
	--
	-- 		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
	--
	-- 		for server, server_settings in pairs(servers) do
	-- 			local server_props = server_settings
	--
	-- 			server_props.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
	--
	-- 			require("lspconfig")[server].setup(server_props)
	-- 		end
	--
	-- 		require("mason-lspconfig").setup()
	-- 	end,
	-- },

	{ -- Autoformat
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
			notify_on_error = false,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				python = { "ruff_organize_imports", "ruff_format" },
				ocaml = { "ocamlformat" },
				tex = { "latexindent" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
			formatters = {
				latexindent = {
					prepend_args = { "-l", ".tex-format.yaml" },
				},
			},
		},
		lazy = false,
	},

	-- { "micangl/cmp-vimtex", ft = "tex" },

	-- { -- Autocompletion
	-- 	"hrsh7th/nvim-cmp",
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		-- Snippet Engine & its associated nvim-cmp source
	-- 		{
	-- 			"L3MON4D3/LuaSnip",
	-- 			build = (function()
	-- 				-- Build Step is needed for regex support in snippets.
	-- 				-- This step is not supported in many windows environments.
	-- 				-- Remove the below condition to re-enable on windows.
	-- 				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
	-- 					return
	-- 				end
	-- 				return "make install_jsregexp"
	-- 			end)(),
	-- 			dependencies = {
	-- 				-- `friendly-snippets` contains a variety of premade snippets.
	-- 				--    See the README about individual language/framework/plugin snippets:
	-- 				--    https://github.com/rafamadriz/friendly-snippets
	-- 				-- {
	-- 				--   'rafamadriz/friendly-snippets',
	-- 				--   config = function()
	-- 				--     require('luasnip.loaders.from_vscode').lazy_load()
	-- 				--   end,
	-- 				-- },
	-- 			},
	-- 			config = function()
	-- 				require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
	-- 			end,
	-- 		},
	-- 		"saadparwaiz1/cmp_luasnip",
	--
	-- 		-- Adds other completion capabilities.
	-- 		--  nvim-cmp does not ship with all sources by default. They are split
	-- 		--  into multiple repos for maintenance purposes.
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-path",
	-- 	},
	-- 	config = function()
	-- 		-- See `:help cmp`
	-- 		local cmp = require("cmp")
	-- 		local luasnip = require("luasnip")
	-- 		luasnip.config.setup({
	-- 			enable_autosnippets = true,
	-- 		})
	--
	-- 		cmp.setup({
	-- 			snippet = {
	-- 				expand = function(args)
	-- 					luasnip.lsp_expand(args.body)
	-- 				end,
	-- 			},
	-- 			completion = {
	-- 				autocomplete = false,
	-- 				-- completeopt = "menu,menuone,noinsert",
	-- 			},
	--
	-- 			-- For an understanding of why these mappings were
	-- 			-- chosen, you will need to read `:help ins-completion`
	-- 			--
	-- 			-- No, but seriously. Please read `:help ins-completion`, it is really good!
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				-- Select the [n]ext item
	-- 				["<C-n>"] = cmp.mapping.select_next_item(),
	-- 				-- Select the [p]revious item
	-- 				["<C-p>"] = cmp.mapping.select_prev_item(),
	--
	-- 				-- Scroll the documentation window [b]ack / [f]orward
	-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
	--
	-- 				-- Accept ([y]es) the completion.
	-- 				--  This will auto-import if your LSP supports it.
	-- 				--  This will expand snippets if the LSP sent a snippet.
	-- 				["<C-y>"] = cmp.mapping.confirm({ select = true }),
	--
	-- 				-- If you prefer more traditional completion keymaps,
	-- 				-- you can uncomment the following lines
	-- 				--['<CR>'] = cmp.mapping.confirm { select = true },
	-- 				--['<Tab>'] = cmp.mapping.select_next_item(),
	-- 				--['<S-Tab>'] = cmp.mapping.select_prev_item(),
	--
	-- 				-- Manually trigger a completion from nvim-cmp.
	-- 				--  Generally you don't need this, because nvim-cmp will display
	-- 				--  completions whenever it has completion options available.
	-- 				["<C-Space>"] = cmp.mapping.complete({}),
	--
	-- 				-- Think of <c-l> as moving to the right of your snippet expansion.
	-- 				--  So if you have a snippet that's like:
	-- 				--  function $name($args)
	-- 				--    $body
	-- 				--  end
	-- 				--
	-- 				-- <c-l> will move you to the right of each of the expansion locations.
	-- 				-- <c-h> is similar, except moving you backwards.
	-- 				["<C-l>"] = cmp.mapping(function()
	-- 					if luasnip.expand_or_locally_jumpable() then
	-- 						luasnip.expand_or_jump()
	-- 					end
	-- 				end, { "i", "s" }),
	-- 				["<C-h>"] = cmp.mapping(function()
	-- 					if luasnip.locally_jumpable(-1) then
	-- 						luasnip.jump(-1)
	-- 					end
	-- 				end, { "i", "s" }),
	--
	-- 				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
	-- 				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
	-- 			}),
	-- 			sources = {
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "luasnip" },
	-- 				{ name = "path" },
	-- 			},
	-- 		})
	--
	-- 		cmp.setup.filetype("tex", {
	-- 			sources = {
	-- 				{ name = "vimtex" },
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "luasnip" },
	-- 				{ name = "buffer" },
	-- 				{ name = "path" },
	-- 				-- other sources
	-- 			},
	-- 		})
	-- 	end,
	-- },

	{ -- improve the navigation experience
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
			-- mimic vim-vinegar
			vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open Parent Directory" })
		end,
		lazy = false,
	},

	-- { -- Highlight, edit, and navigate code
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	build = ":TSUpdate",
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			"bash",
	-- 			"c",
	-- 			"ocaml",
	-- 			"diff",
	-- 			"html",
	-- 			"lua",
	-- 			"luadoc",
	-- 			"markdown",
	-- 			"markdown_inline",
	-- 			"query",
	-- 			"vim",
	-- 			"latex",
	-- 			"vimdoc",
	-- 		},
	-- 		-- Autoinstall languages that are not installed
	-- 		auto_install = true,
	-- 		highlight = {
	-- 			enable = true,
	-- 			-- disable = {"latex"},
	-- 			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
	-- 			--  If you are experiencing weird indenting issues, add the language to
	-- 			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
	-- 		},
	-- 		indent = {
	-- 			enable = true,
	-- 			-- disable = { "latex" }
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
	--
	-- 		-- Prefer git instead of curl in order to improve connectivity in some environments
	-- 		require("nvim-treesitter.install").prefer_git = true
	-- 		---@diagnostic disable-next-line: missing-fields
	-- 		require("nvim-treesitter.configs").setup(opts)
	--
	-- 		-- There are additional nvim-treesitter modules that you can use to interact
	-- 		-- with nvim-treesitter. You should go explore a few and see what interests you:
	-- 		--
	-- 		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	-- 		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	-- 		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	-- 	end,
	-- },

	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
	-- { import = 'custom.plugins' },
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = {},
		-- 	icons = vim.g.have_nerd_font and {} or {
		-- 		cmd = "⌘",
		-- 		config = "🛠",
		-- 		event = "📅",
		-- 		ft = "📂",
		-- 		init = "⚙",
		-- 		keys = "🗝",
		-- 		plugin = "🔌",
		-- 		runtime = "💻",
		-- 		require = "🌙",
		-- 		source = "📄",
		-- 		start = "🚀",
		-- 		task = "📌",
		-- 		lazy = "💤 ",
		-- 	},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
