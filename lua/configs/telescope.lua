local keymap = vim.keymap

local telescope = require("telescope")

telescope.setup({
	defaults = {
		-- border = false,
		borderchars = {
			prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
			results = { " ", " ", " ", " ", " ", " ", " ", " " },
			preview = { " ", " ", " ", " ", " ", " ", " ", " " },
		},
		layout_config = {
			height = 10,
		},
		layout_strategy = "bottom_pane",
		sorting_strategy = "ascending",
		theme = "ivy",
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case",
		},
		file_browser = {
			dir_icon = "D",
			hijack_netrw = true,
			files = false,
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")

local builtin = require("telescope.builtin")

local file_browser = telescope.extensions.file_browser.file_browser

keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep in files" })
keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
keymap.set("n", "<leader>fd", function()
	file_browser({
		path = vim.fn.expand("%:p:h"),
		select_buffer = true,
	})
end, { desc = "File browser" })
