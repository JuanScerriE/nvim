local api = vim.api

-- goyo autocmds

local focus_gp = api.nvim_create_augroup("Focus", {
	clear = true,
})

api.nvim_create_autocmd("User", {
	pattern = "GoyoEnter",
	command = [[Limelight]],
	group = focus_gp,
})

api.nvim_create_autocmd("User", {
	pattern = "GoyoLeave",
	command = [[Limelight!]],
	group = focus_gp,
})

local statusline = require("statusline")

local set_status_active = function()
	vim.opt_local.statusline = statusline:set_active()
end

local set_status_inactive = function()
	vim.opt_local.statusline = statusline:set_inactive()
end

local set_status_explorer = function()
	vim.opt_local.statusline = statusline:set_explorer()
end

-- statusline autocmds

-- local statusline_gp = api.nvim_create_augroup("Statusline", {
-- 	clear = true,
-- })
--
-- api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
-- 	callback = set_status_active,
-- 	group = statusline_gp,
-- })
--
-- api.nvim_create_autocmd({ "BufWinLeave", "WinLeave" }, {
-- 	callback = set_status_inactive,
-- 	group = statusline_gp,
-- })
--
-- local dbg_nvim_tree_yes = function()
-- 	print("Tree")
-- end
--
-- local dbg_nvim_tree_no = function()
-- 	print("Not Tree")
-- end

-- api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
-- 	pattern = "NvimTree",
-- 	callback = set_status_explorer,
-- 	group = statusline_gp,
-- })

-- api.nvim_create_autocmd({ "BufWinLeave", "FileType" }, {
-- 	pattern = "NvimTree",
-- 	callback = dbg_nvim_tree_no,
-- 	group = statusline_gp,
-- })
