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
