local diagnostic = vim.diagnostic
local keymap = vim.keymap

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
keymap.set(
	"n",
	"<leader>s",
	"<cmd>set spell!<cr>",
	{ noremap = true, silent = true, desc = "Toggle spell check" }
)

-- move between buffers
keymap.set(
	"n",
	"<leader>,",
	"<cmd>bprev<cr>",
	{ noremap = true, silent = true, desc = "Previous buffer" }
)
keymap.set(
	"n",
	"<leader>.",
	"<cmd>bnext<cr>",
	{ noremap = true, silent = true, desc = "Next buffer" }
)

-- split and vsplit
keymap.set(
    "n",
    "<leader>wx",
    "<cmd>split<cr>",
    { noremap = true, silent = true, desc = "Horizontal split" }
)
keymap.set(
    "n",
    "<leader>wv",
    "<cmd>vsplit<cr>",
    { noremap = true, silent = true, desc = "Vertical split" }
)
