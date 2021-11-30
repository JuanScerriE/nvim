-- general bindings --

-- set leader
vim.g.mapleader = ";"

-- toggle spell check
vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>set spell!<cr>", { noremap = true, silent = true })

-- move between buffers
vim.api.nvim_set_keymap("n", "<leader>,", "<cmd>bprev<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>.", "<cmd>bnext<cr>", { noremap = true, silent = true })

-- terminal bindings
vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>term<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>split term://$SHELL<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>vsplit term://$SHELL<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<esc>", "<C-\\><C-n>", { noremap = true, silent = true })
