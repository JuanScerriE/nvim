local g = vim.g

-- plugin options --

----------------------------------------------------------

-- dap opts

----------------------------------------------------------

-- cmake opts

local Path = require("plenary.path")

require("cmake").setup({
	cmake_executable = "cmake",
	save_before_build = true,
	parameters_file = "neovim.json",
	default_parameters = { args = {}, build_type = "Debug" },
	build_dir = tostring(Path:new("{cwd}", "build", "{os}-{build_type}")),
	configure_args = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1", "-G", "Ninja" },
	build_args = {},
	on_build_output = nil,
	quickfix = {
		pos = "botright",
		height = 10,
		only_on_error = true,
	},
	copy_compile_commands = true,
	dap_configurations = {
		lldb_vscode = { type = "lldb", request = "launch" },
	},
	dap_configuration = "lldb_vscode",
	dap_open_command = function(...)
		require("dap").repl.open(...)
	end,
	-- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
})

----------------------------------------------------------

-- zen-mode opts

require("zen-mode").setup({
	window = {
		backdrop = 1,
		width = 120,
		height = 1,
		options = {
			-- signcolumn = "no", -- disable signcolumn
			-- number = false, -- disable number column
			-- relativenumber = false, -- disable relative numbers
			-- cursorline = false, -- disable cursorline
			-- cursorcolumn = false, -- disable cursor column
			-- foldcolumn = "0", -- disable fold column
			-- list = false, -- disable whitespace characters
		},
	},
	plugins = {
		-- disable some global vim options (vim.o...)
		-- comment the lines to not apply the options
		options = {
			enabled = true,
			ruler = false, -- disables the ruler text in the cmd line area
			showcmd = false, -- disables the command in the last line of the screen
		},
		twilight = { enabled = true }, -- enable twilight
		gitsigns = { enabled = true }, -- disable gitsigns
		tmux = { enabled = true }, -- disable tmux statusline
	},
	-- callback where you can add custom code when the Zen window opens
	on_open = function(win) end,
	-- callback where you can add custom code when the Zen window closes
	on_close = function() end,
})

----------------------------------------------------------

-- comments opts
require("Comment").setup({
	-- @type boolean | function() : boolean
	padding = true, -- add space b/w comment
	-- @type string | function() : string
	ignore = nil, -- regex to ignore matchin
	toggler = {
		line = "gcc", -- line comment
		block = "gbc", -- block comment
	},
	opleader = {
		line = "gc", -- line comment
		block = "gb", -- block comment
	},
	extra = {
		above = "gcO", -- comment line above
		below = "gco", -- comment line below
		eol = "gcA", -- comment end of line
	},
	mappings = {
		basic = true,
		extra = true,
		extended = false,
	},
	-- @type function(ctx: CommentCtx) : string
	pre_hook = nil, -- call before commenting
	-- @type function(ctx: CommentCtx)
	post_hook = nil, -- call after commenting
})

-- treesitter opts
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"cpp",
		"rust",
		"lua",
		"bash",
		"cmake",
		"css",
		"bibtex",
		"zig",
		"go",
		"html",
		"javascript",
		"java",
		"latex",
		"llvm",
		"ninja",
		"python",
		"yaml",
		"svelte",
		"typescript",
		"vim",
	},
	sync_install = false,
	ignore_install = { "javascript", "typescript", "svelte" },
	highlight = {
		disable = { "latex", "tex" },
		enable = true,
		additional_vim_regex_highlighting = true,
	},
})

----------------------------------------------------------

-- gitsigns setup
require("gitsigns").setup()

-- vimtex/tex opts
g.tex_flavor = "latex"
-- vim.g.tex_conceal = "abdmg"
g.vimtex_quickfix_mode = 0
-- vim.opt.conceallevel = 1

----------------------------------------------------------

-- nvim-autopairs

require("nvim-autopairs").setup()

----------------------------------------------------------

-- fuzzy finder

local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
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
