vim.loader.enable()

-- globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false

-- options
vim.o.number = true
vim.o.mouse = "a"
vim.o.showmode = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.cole = 0
vim.o.foldmethod = "marker"

-- set the list chars
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- diagnostics config
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = true,
	virtual_lines = false,
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})

-- default keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "JS:clear highlights on search" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "JS:open diagnostic quickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "JS:exit terminal mode" })
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "JS:enter window mode <C-w>" })
vim.keymap.set("n", "<leader>O", "<cmd>set spell!<cr>", { desc = "JS:toggle orthographic checking" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("juan-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.hl_op()
	end,
})

-- plugins
local function run_build(name, cmd, cwd)
	local result = vim.system(cmd, { cwd = cwd }):wait()
	if result.code ~= 0 then
		local stderr = result.stderr or ""
		local stdout = result.stdout or ""
		local output = stderr ~= "" and stderr or stdout
		if output == "" then
			output = "No output from build command."
		end
		vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind

		if kind ~= "install" and kind ~= "update" then
			return
		end

		if name == "LuaSnip" then
			if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
				run_build(name, { "make", "install_jsregexp" }, ev.data.path)
			end
			return
		end

		if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
			run_build(name, { "make" }, ev.data.path)
			return
		end
	end,
})

local function gh(repo)
	return "https://github.com/" .. repo
end

vim.pack.add({ gh("tpope/vim-fugitive") })

vim.pack.add({ gh("folke/which-key.nvim") })
require("which-key").setup({
	delay = 250,
	icons = { mappings = vim.g.have_nerd_font },
})

vim.pack.add({ gh("stevearc/oil.nvim") })
require("oil").setup()
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "JS:open parent directory" })

vim.pack.add({ gh("stevearc/conform.nvim") })
require("conform").setup({
	notify_on_error = true,
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_organize_imports", "ruff_format" },
		ocaml = { "ocamlformat" },
		tex = { "latexindent" },
		html = { "prettier" },
		json = { "prettier" },
		javascript = { "prettier" },
		php = { "php_cs_fixer" }, -- builin identifier for php_cs_fixer
	},
	formatters = {
		latexindent = {
			prepend_args = { "-l" },
		},
	},
})
vim.keymap.set("n", "<leader>F", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "JS:format current buffer" })

local telescope_plugins = {
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
}

if vim.fn.executable("make") == 1 then
	table.insert(telescope_plugins, gh("nvim-telescope/telescope-fzf-native.nvim"))
end

vim.pack.add(telescope_plugins)
require("telescope").setup()
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "JS:find marks" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "JS:find help" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "JS:find keymaps" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "JS:find files" })
vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "JS:find select telescope" })
vim.keymap.set({ "n", "v" }, "<leader>fw", builtin.grep_string, { desc = "JS:find current word" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "JS:find by grep" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "JS:find diagnostics" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "JS:find resume" })
vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'JS:find recent files ("." for repeat)' })
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "JS:find commands" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "JS:find existing buffers" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf

		vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "JS:goto references" })
		vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "JS:goto implementation" })
		vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "JS:goto definition" }) -- <C-t> to go back
		vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { buffer = buf, desc = "JS:open document symbols" })
		vim.keymap.set(
			"n",
			"gW",
			builtin.lsp_dynamic_workspace_symbols,
			{ buffer = buf, desc = "JS:open workspace symbols" }
		)
		vim.keymap.set("n", "grt", builtin.lsp_type_definitions, { buffer = buf, desc = "JS:goto type Definition" })
	end,
})

vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "JS:fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>f/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "JS:grep find in open files" })

vim.pack.add({ gh("j-hui/fidget.nvim") })
require("fidget").setup()

local debugging_plugins = {
	gh("mason-org/mason.nvim"),
	gh("jay-babu/mason-nvim-dap.nvim"),
	gh("rcarriga/nvim-dap-ui"),
	gh("theHamsta/nvim-dap-virtual-text"),
	gh("nvim-neotest/nvim-nio"),
	gh("mfussenegger/nvim-dap"),
}
vim.pack.add(debugging_plugins)

require("mason").setup()

local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local dapui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

mason_dap.setup({
	ensure_installed = { "codelldb" },
	automatic_installation = true,
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})

dap_virtual_text.setup()
dapui.setup()

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build-dbg", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
	},
	{
		name = "Attach to gdbserver :1234",
		type = "codelldb",
		request = "launch",
		MIMode = "gdb",
		miDebuggerServerAddress = "localhost:1234",
		miDebuggerPath = "/usr/bin/gdb",
		cwd = "${workspaceFolder}",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build-dbg", "file")
		end,
	},
}

dap.configurations.c = dap.configurations.cpp

vim.keymap.set("n", "<leader>du", function()
	ui.toggle({})
end, { desc = "JS:toggle dap ui" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "JS:toggle breakpoint" })
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "JS:run to cursor" })
vim.keymap.set("n", "<leader>?", function()
	ui.eval(nil, { enter = true })
end, { desc = "JS:variable info" })

vim.keymap.set("n", "<F1>", dap.continue, { desc = "JS:continue" })
vim.keymap.set("n", "<F2>", dap.step_into, { desc = "JS:step into" })
vim.keymap.set("n", "<F3>", dap.step_over, { desc = "JS:step over" })
vim.keymap.set("n", "<F4>", dap.step_out, { desc = "JS:step out" })
vim.keymap.set("n", "<F5>", dap.step_back, { desc = "JS:step back" })
vim.keymap.set("n", "<F11>", dap.restart, { desc = "JS:restart" })
vim.keymap.set("n", "<F12>", dap.terminate, { desc = "JS:terminate" })

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

vim.pack.add({ { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") } })
require("luasnip").setup({})

vim.pack.add({ gh("rafamadriz/friendly-snippets") })
require("luasnip.loaders.from_vscode").lazy_load()

vim.pack.add({ { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") } })
require("blink.cmp").setup({
	keymap = {
		-- `:help blink-cmp-config-keymap`
		preset = "default",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = false, auto_show_delay_ms = 500 },
	},
	sources = {
		default = { "lsp", "path", "snippets" },
	},
	snippets = { preset = "luasnip" },

	-- see `:help blink-cmp-config-fuzzy` for more information
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("juan-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "JS:LSP: " .. desc })
		end

		-- WARN: this is not goto definition, this is goto declaration (e.g. c header file in the case of c).
		map("grD", vim.lsp.buf.declaration, "goto declaration")
		map("grn", vim.lsp.buf.rename, "rename")
		map("gra", vim.lsp.buf.code_action, "goto code action", { "n", "x" })

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("juan-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("juan-lsp-detach", { clear = true }),

				callback = function(event_)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "juan-lsp-highlight", buffer = event_.buf })
				end,
			})
		end

		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "toggle inlay hints")
		end
	end,
})

local servers = {
	pyright = {
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
	},

	clangd = {
		cmd = { "clangd", "--experimental-modules-support", "--background-index" },
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
	},

	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = { ".luarc.json", ".luarc.jsonc" },
		on_init = function(client)
			client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				workspace = {
					checkThirdParty = false,
					-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
					--  See https://github.com/neovim/nvim-lspconfig/issues/3189
					library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
						"${3rd}/luv/library",
						"${3rd}/busted/library",
					}),
				},
			})
		end,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
			},
		},
	},

	gopls = {
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
	},

	ruby_lsp = {
		cmd = { "ruby-lsp" }, -- or { "bundle", "exec", "ruby-lsp" },
		filetypes = { "ruby" },
		root_markers = { "Gemfile", ".git" },
		init_options = {
			formatter = "standard",
			linters = { "standard" },
			addonSettings = {
				["Ruby LSP Rails"] = {
					enablePendingMigrationsPrompt = false,
				},
			},
		},
	},

	ocamllsp = {
		cmd = { "ocamllsp", "--fallback-read-dot-merlin" },
		filetypes = { "ocaml", "menhir", "ocamlinterface", "ocamllex", "reason", "dune" },
		root_markers = { "*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace" },
		settings = {
			single_file_support = true,
		},
	},

	zls = {
		cmd = { "zls" },
		filetypes = { "zig", "zir" },
		root_markers = { "zls.json", "build.zig", "build.zig.zon", ".git" },
	},

	svelte = {
		cmd = { "svelteserver", "--stdio" },
		filetypes = {
			"svelte",
		},
		root_markers = { "package-lock.json" },
	},

	phpactor = {
		cmd = { "phpactor", "language-server" },
		filetypes = { "php" },
		root_markers = { ".git", "composer.json", ".phpactor.json", ".phpactor.yml" },
		workspace_required = true,
		init_options = {
			["language_server_phpstan.enabled"] = false,
			["language_server_psalm.enabled"] = false,
		},
	},

	ltex_ls_plus = {
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
	},
}

-- config and enable lsp servers
for name, server in pairs(servers) do
	vim.lsp.config(name, server)

	vim.lsp.enable(name)
end

-- TODO: figure out how to do lazy loading

-- vimtex setup (TODO: double check if this needs to be done before loading vimtex)
vim.g.vimtex_syntax_conceal_disable = 1

vim.g.vimtex_compiler_latexmk = {
	["aux_dir"] = ".tex-aux",
}

vim.g.vimtex_compiler_latexmk_engines = {
	["_"] = "-lualatex -shell-escape",
}

if vim.uv.os_uname().sysname == "Darwin" then
	vim.g.vimtex_view_method = "skim"
elseif vim.uv.os_uname().sysname == "Linux" then
	vim.g.vimtex_view_method = "zathura"
end

--
--
-- 	{ "mason-org/mason.nvim", opts = {} },
--
--
-- 	{
-- 		"mfussenegger/nvim-dap",
-- 		event = "VeryLazy",
-- 		dependencies = {
-- 			"rcarriga/nvim-dap-ui",
-- 			"nvim-neotest/nvim-nio",
-- 			"jay-babu/mason-nvim-dap.nvim",
-- 			"theHamsta/nvim-dap-virtual-text",
-- 		},
-- 		config = function()
-- 			local mason_dap = require("mason-nvim-dap")
-- 			local dap = require("dap")
-- 			local ui = require("dapui")
-- 			local dap_virtual_text = require("nvim-dap-virtual-text")
--
-- 			mason_dap.setup({
-- 				ensure_installed = { "codelldb", "cppdbg" },
-- 				automatic_installation = true,
-- 				handlers = {
-- 					function(config)
-- 						require("mason-nvim-dap").default_setup(config)
-- 					end,
-- 				},
-- 			})
--
-- 			-- dap.set_log_level("TRACE")
--
-- 			dap_virtual_text.setup()
-- 			ui.setup()
--
-- 			local builtin = require("telescope.builtin")
--
-- 			dap.configurations.cpp = {
-- 				{
-- 					name = "Launch file",
-- 					type = "codelldb",
-- 					request = "launch",
-- 					program = function()
-- 						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build-dbg", "file")
-- 					end,
-- 					cwd = "${workspaceFolder}",
-- 					stopAtEntry = true,
-- 				},
-- 				{
-- 					name = "Attach to gdbserver :1234",
-- 					type = "codelldb",
-- 					request = "launch",
-- 					MIMode = "gdb",
-- 					miDebuggerServerAddress = "localhost:1234",
-- 					miDebuggerPath = "/usr/bin/gdb",
-- 					cwd = "${workspaceFolder}",
-- 					program = function()
-- 						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build-dbg", "file")
-- 					end,
-- 				},
-- 			}
--
-- 			dap.configurations.c = dap.configurations.cpp
--
-- 			vim.keymap.set("n", "<leader>du", function()
-- 				ui.toggle({})
-- 			end, { desc = "Toggle DAP UI" })
-- 			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
-- 			vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Run to Cursor" })
--
-- 			vim.keymap.set("n", "<leader>?", function()
-- 				ui.eval(nil, { enter = true })
-- 			end)
--
-- 			vim.keymap.set("n", "<F1>", dap.continue, { desc = "Continue" })
-- 			vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Step Into" })
-- 			vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Step Over" })
-- 			vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Step Out" })
-- 			vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Step Back" })
-- 			vim.keymap.set("n", "<F11>", dap.restart, { desc = "Restart" })
-- 			vim.keymap.set("n", "<F12>", dap.terminate, { desc = "Terminate" })
--
-- 			dap.listeners.before.attach.dapui_config = function()
-- 				ui.open()
-- 			end
-- 			dap.listeners.before.launch.dapui_config = function()
-- 				ui.open()
-- 			end
-- 			dap.listeners.before.event_terminated.dapui_config = function()
-- 				ui.close()
-- 			end
-- 			dap.listeners.before.event_exited.dapui_config = function()
-- 				ui.close()
-- 			end
-- 		end,
-- 	},
--
-- 	-- {
-- 	-- 	"nvim-treesitter/nvim-treesitter",
-- 	-- 	lazy = false,
-- 	-- 	build = ":TSUpdate",
-- 	-- 	config = function()
-- 	-- 		require("nvim-treesitter").install({ "svelte", "javascript", "typescript", "html", "cpp", "c", "go" })
-- 	-- 	end,
-- 	-- },
--
-- 	{
-- 		"hrsh7th/nvim-cmp",
-- 		dependencies = {
-- 			"hrsh7th/cmp-nvim-lsp",
-- 			"hrsh7th/cmp-buffer",
-- 			"hrsh7th/cmp-path",
-- 			"hrsh7th/cmp-cmdline",
-- 			"hrsh7th/cmp-vsnip",
-- 			"hrsh7th/vim-vsnip",
-- 		},
-- 		config = function()
-- 			-- Set up nvim-cmp.
-- 			local cmp = require("cmp")
--
-- 			cmp.setup({
-- 				snippet = {
-- 					-- REQUIRED - you must specify a snippet engine
-- 					expand = function(args)
-- 						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
-- 						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
-- 						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
-- 						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
-- 						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
--
-- 						-- For `mini.snippets` users:
-- 						-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
-- 						-- insert({ body = args.body }) -- Insert at cursor
-- 						-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
-- 						-- require("cmp.config").set_onetime({ sources = {} })
-- 					end,
-- 				},
-- 				window = {
-- 					-- completion = cmp.config.window.bordered(),
-- 					-- documentation = cmp.config.window.bordered(),
-- 				},
-- 				mapping = cmp.mapping.preset.insert({
-- 					["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 					["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 					["<C-Space>"] = cmp.mapping.complete(),
-- 					["<C-e>"] = cmp.mapping.abort(),
-- 					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
-- 				}),
-- 				sources = cmp.config.sources({
-- 					{ name = "nvim_lsp" },
-- 					{ name = "vsnip" }, -- For vsnip users.
-- 					-- { name = 'luasnip' }, -- For luasnip users.
-- 					-- { name = 'ultisnips' }, -- For ultisnips users.
-- 					-- { name = 'snippy' }, -- For snippy users.
-- 				}, {
-- 					{ name = "buffer" },
-- 				}),
-- 			})
--
-- 			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- 			cmp.setup.cmdline({ "/", "?" }, {
-- 				mapping = cmp.mapping.preset.cmdline(),
-- 				sources = {
-- 					{ name = "buffer" },
-- 				},
-- 			})
--
-- 			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- 			cmp.setup.cmdline(":", {
-- 				mapping = cmp.mapping.preset.cmdline(),
-- 				sources = cmp.config.sources({
-- 					{ name = "path" },
-- 				}, {
-- 					{ name = "cmdline" },
-- 				}),
-- 				matching = { disallow_symbol_nonprefix_matching = false },
-- 			})
--
-- 			-- Set up lspconfig.
-- 			local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- 			vim.lsp.config["pyright"] = {
-- 				cmd = { "pyright-langserver", "--stdio" },
-- 				filetypes = { "python" },
-- 				root_markers = {
-- 					"pyrightconfig.json",
-- 					"pyproject.toml",
-- 					"setup.py",
-- 					"setup.cfg",
-- 					"requirements.txt",
-- 					"Pipfile",
-- 					".git",
-- 				},
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["slangd"] = {
-- 				cmd = { "slangd" },
-- 				filetypes = { "hlsl", "shaderslang" },
-- 				root_markers = {
-- 					".git",
-- 					"compile_commands.json",
-- 					".clangd",
-- 					".clang-format",
-- 					".clangd-tidy",
-- 					"compile_flags.txt",
-- 				},
--
-- 				settings = {
-- 					slang = {
-- 						inlayHints = {
-- 							deducedTypes = true,
-- 							parameterNames = true,
-- 						},
-- 					},
-- 				},
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["ccls"] = {
-- 				cmd = { "ccls" },
-- 				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
-- 				root_markers = {
-- 					".git",
-- 					".ccls",
-- 				},
-- 				settings = {
-- 					init_options = {
-- 						compilationDatabaseDirectory = "build-dbg",
-- 						index = {
-- 							threads = 6,
-- 						},
-- 					},
-- 				},
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["clangd"] = {
-- 				cmd = { "clangd", "--experimental-modules-support", "--background-index" },
-- 				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
-- 				root_markers = {
-- 					"compile_commands.json",
-- 					".clangd",
-- 					".clang-format",
-- 					".clangd-tidy",
-- 					"compile_flags.txt",
-- 				},
-- 				settings = {
-- 					single_file_support = true,
-- 				},
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["luals"] = {
-- 				cmd = { "lua-language-server" },
-- 				filetypes = { "lua" },
-- 				root_markers = { ".luarc.json", ".luarc.jsonc" },
-- 				settings = {
-- 					Lua = {
-- 						runtime = {
-- 							version = "LuaJIT",
-- 						},
-- 					},
-- 				},
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["gopls"] = {
-- 				cmd = { "gopls" },
-- 				filetypes = { "go", "gomod", "gowork", "gotmpl" },
-- 				settings = {
-- 					gopls = {
-- 						analyses = {
-- 							unusedparams = true,
-- 						},
-- 						staticcheck = true,
-- 						gofumpt = true,
-- 					},
-- 				},
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["rust_analyzer"] = {
-- 				cmd = { "rust-analyzer" },
-- 				filetypes = { "rust" },
-- 				root_markers = { "Cargo.toml" },
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["ruby_lsp"] = {
-- 				cmd = { "ruby-lsp" }, -- or { "bundle", "exec", "ruby-lsp" },
-- 				filetypes = { "ruby" },
-- 				root_markers = { "Gemfile", ".git" },
-- 				init_options = {
-- 					formatter = "standard",
-- 					linters = { "standard" },
-- 					addonSettings = {
-- 						["Ruby LSP Rails"] = {
-- 							enablePendingMigrationsPrompt = false,
-- 						},
-- 					},
-- 				},
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["ocamllsp"] = {
-- 				cmd = { "ocamllsp", "--fallback-read-dot-merlin" },
-- 				filetypes = { "ocaml", "menhir", "ocamlinterface", "ocamllex", "reason", "dune" },
-- 				root_markers = { "*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace" },
-- 				settings = {
-- 					single_file_support = true,
-- 				},
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["zls"] = {
-- 				cmd = { "zls" },
-- 				filetypes = { "zig", "zir" },
-- 				root_markers = { "zls.json", "build.zig", "build.zig.zon", ".git" },
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["svelte"] = {
-- 				cmd = { "svelteserver", "--stdio" },
-- 				filetypes = {
-- 					"svelte",
-- 				},
-- 				root_markers = { "package-lock.json" },
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["phpactor"] = {
-- 				cmd = { "phpactor", "language-server" },
-- 				filetypes = { "php" },
-- 				root_markers = { ".git", "composer.json", ".phpactor.json", ".phpactor.yml" },
-- 				workspace_required = true,
-- 				init_options = {
-- 					["language_server_phpstan.enabled"] = false,
-- 					["language_server_psalm.enabled"] = false,
-- 				},
-- 				capabilities = capabilities,
-- 			}
--
-- 			vim.lsp.config["ltex-ls-plus"] = {
-- 				cmd = { "ltex-ls-plus" },
-- 				filetypes = {
-- 					"bib",
-- 					"context",
-- 					"gitcommit",
-- 					"html",
-- 					"markdown",
-- 					"org",
-- 					"pandoc",
-- 					"plaintex",
-- 					"quarto",
-- 					"mail",
-- 					"mdx",
-- 					"rmd",
-- 					"rnoweb",
-- 					"rst",
-- 					"tex",
-- 					"text",
-- 					"typst",
-- 					"xhtml",
-- 				},
-- 				root_markers = { ".git" },
-- 				settings = {
-- 					ltex = {
-- 						enabled = {
-- 							"bib",
-- 							"context",
-- 							"gitcommit",
-- 							"html",
-- 							"markdown",
-- 							"org",
-- 							"pandoc",
-- 							"plaintex",
-- 							"quarto",
-- 							"mail",
-- 							"mdx",
-- 							"rmd",
-- 							"rnoweb",
-- 							"rst",
-- 							"tex",
-- 							"latex",
-- 							"text",
-- 							"typst",
-- 							"xhtml",
-- 						},
-- 					},
-- 				},
-- 				capabilities = capabilities,
-- 			}
--
-- 			local info = vim.uv.os_uname()
-- 			if info.sysname == "Linux" then
-- 				vim.lsp.enable({
-- 					"zls",
-- 					"svelte",
-- 					"gopls",
-- 					"phpactor",
-- 					"clangd",
-- 					-- "ccls",
-- 					"cmake",
-- 					"slangd",
-- 					"luals",
-- 					"ruby_lsp",
-- 					"rust_analyzer",
-- 					"ocamllsp",
-- 					"ltex-ls-plus",
-- 					"pyright",
-- 				})
-- 			elseif info.sysname == "Darwin" then
-- 				vim.lsp.enable({
-- 					"zls",
-- 					"svelte",
-- 					"gopls",
-- 					"phpactor",
-- 					"clangd",
-- 					-- "ccls",
-- 					"cmake",
-- 					"slangd",
-- 					"luals",
-- 					"ruby_lsp",
-- 					"rust_analyzer",
-- 					"ocamllsp",
-- 					"ltex-ls-plus",
-- 					"pyright",
-- 				})
-- 			end
-- 		end,
-- 	},
--
-- 	{ -- write nicely typeset math in neovim (tex/latex integration)
-- 		"lervag/vimtex",
-- 		-- ft = "tex", -- HACK: always load to enable inverse search
-- 		init = function()
-- 			vim.g.vimtex_syntax_conceal_disable = 1
--
-- 			vim.g.vimtex_compiler_latexmk = {
-- 				["aux_dir"] = ".tex-aux",
-- 			}
-- 			vim.g.vimtex_compiler_latexmk_engines = {
-- 				["_"] = "-lualatex -shell-escape",
-- 			}
-- 		end,
-- 		config = function()
-- 			vim.opt.cole = 0
--
-- 			if vim.uv.os_uname().sysname == "Darwin" then
-- 				vim.g.vimtex_view_method = "skim"
-- 			elseif vim.uv.os_uname().sysname == "Linux" then
-- 				vim.g.vimtex_view_method = "zathura"
-- 				-- vim.g.vimtex_view_general_viewer = "okular"
-- 				-- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
-- 			end
-- 		end,
-- 	},
-- }, {
-- 	ui = {
-- 		icons = {},
-- 	},
-- })
--
vim.cmd.colorscheme("unokai")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
