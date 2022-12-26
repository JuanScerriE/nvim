local g = vim.g

-- plugin options --

----------------------------------------------------------

-- cmake opts

local Path = require("plenary.path")

require("cmake").setup({
	cmake_executable = "cmake", -- CMake executable to run.
	parameters_file = "neovim.json", -- JSON file to store information about selected target, run arguments and build type.
	build_dir = tostring(Path:new("{cwd}", "build", "{os}-{build_type}")), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
	default_projects_path = tostring(Path:new(vim.loop.os_homedir(), "Projects")), -- Default folder for creating project.
	configure_args = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1", "-G", "Ninja" }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
	build_args = {}, -- Default arguments that will be always passed at cmake build step.
	on_build_output = nil, -- Callback which will be called on every line that is printed during build process. Accepts printed line as argument.
	quickfix_height = 5, -- Height of the opened quickfix.
	quickfix_only_on_error = false, -- Open quickfix window only if target build failed.
	copy_compile_commands = true, -- Copy compile_commands.json to current working directory.
})

----------------------------------------------------------

-- zen-mode

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
