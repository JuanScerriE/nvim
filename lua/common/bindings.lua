local diagnostic = vim.diagnostic
local keymap = vim.keymap
local api = vim.api

-- default bindings --

-- diagnostics
keymap.set(
	"n",
	"<space>e",
	diagnostic.open_float,
	{ desc = "See diagnostic message" }
)
keymap.set(
	"n",
	"[d",
	diagnostic.goto_prev,
	{ desc = "Goto previous diagnostic" }
)
keymap.set("n", "]d", diagnostic.goto_next, { desc = "Goto next diagnostic" })
keymap.set(
	"n",
	"<space>q",
	diagnostic.setloclist,
	{ desc = "View diagnostics" }
)

-- toggle spell check
api.nvim_set_keymap(
	"n",
	"<leader>s",
	"<cmd>set spell!<cr>",
	{ noremap = true, silent = true, desc = "Toggle spell check" }
)

-- move between buffers
api.nvim_set_keymap(
	"n",
	"<leader>,",
	"<cmd>bprev<cr>",
	{ noremap = true, silent = true, desc = "Previous buffer" }
)
api.nvim_set_keymap(
	"n",
	"<leader>.",
	"<cmd>bnext<cr>",
	{ noremap = true, silent = true, desc = "Next buffer" }
)

-- terminal bindings
api.nvim_set_keymap(
	"n",
	"<leader>tb",
	"<cmd>term<cr>",
	{ noremap = true, silent = true, desc = "Open terminal buffer" }
)
api.nvim_set_keymap(
	"n",
	"<leader>th",
	"<cmd>split term://$SHELL<cr>",
	{ noremap = true, silent = true, desc = "Open terminal (horizontal)" }
)
api.nvim_set_keymap(
	"n",
	"<leader>tv",
	"<cmd>vsplit term://$SHELL<cr>",
	{ noremap = true, silent = true, desc = "Open terminal (vertical)" }
)
api.nvim_set_keymap(
	"t",
	"<esc>",
	"<C-\\><C-n>",
	{ noremap = true, silent = true }
)
