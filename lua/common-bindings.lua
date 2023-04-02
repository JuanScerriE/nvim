local diagnostic = vim.diagnostic
local keymap = vim.keymap
local api = vim.api

-- default bindings --

-- diagnostics
keymap.set("n", "<space>e", diagnostic.open_float)
keymap.set("n", "[d", diagnostic.goto_prev)
keymap.set("n", "]d", diagnostic.goto_next)
keymap.set("n", "<space>q", diagnostic.setloclist)

-- toggle spell check
api.nvim_set_keymap("n", "<leader>s", "<cmd>set spell!<cr>", { noremap = true, silent = true })

-- move between buffers
api.nvim_set_keymap("n", "<leader>,", "<cmd>bprev<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>.", "<cmd>bnext<cr>", { noremap = true, silent = true })

-- terminal bindings
api.nvim_set_keymap("n", "<leader>tb", "<cmd>term<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>th", "<cmd>split term://$SHELL<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>tv", "<cmd>vsplit term://$SHELL<cr>", { noremap = true, silent = true })
api.nvim_set_keymap("t", "<esc>", "<C-\\><C-n>", { noremap = true, silent = true })
