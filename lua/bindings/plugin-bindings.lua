local api = vim.api

-- plugin bindings --

-- telescope bindings
api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope fd<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>fgf", "<cmd>Telescope git_files<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>fgc", "<cmd>Telescope git_bcommits<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>fq", "<cmd>Telescope builtin<cr>", { noremap = true, silent = true })

-- nvim-tree bindings
api.nvim_set_keymap("n", "<leader>nt", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>nr", "<cmd>NvimTreeRefresh<cr>", { noremap = true, silent = true })

-- gitsigns bindings
api.nvim_set_keymap("n", "<leader>hs", "<cmd>lua require'gitsigns'.stage_hunk()<cr>", { noremap = true, silent = true })
api.nvim_set_keymap(
	"v",
	"<leader>hs",
	"<cmd>lua require'gitsigns'.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<cr>",
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<leader>hu",
	"<cmd>lua require'gitsigns'.undo_stage_hunk()<cr>",
	{ noremap = true, silent = true }
)
api.nvim_set_keymap("n", "<leader>hr", "<cmd>lua require'gitsigns'.reset_hunk()<cr>", { noremap = true, silent = true })
api.nvim_set_keymap(
	"v",
	"<leader>hr",
	"<cmd>lua require'gitsigns'.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<cr>",
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<leader>hR",
	"<cmd>lua require'gitsigns'.reset_buffer()<cr>",
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<leader>hp",
	"<cmd>lua require'gitsigns'.preview_hunk()<cr>",
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<leader>hb",
	"<cmd>lua require'gitsigns'.blame_line(true)<cr>",
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<leader>hS",
	"<cmd>lua require'gitsigns'.stage_buffer()<cr>",
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<leader>hU",
	"<cmd>lua require'gitsigns'.reset_buffer_index()<cr>",
	{ noremap = true, silent = true }
)
