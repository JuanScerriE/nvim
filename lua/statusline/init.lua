M = {}

require("statusline.theme").setup("gruvbox")

status = require("statusline.status")
build = require("statusline.build")

M.setup = function(_, opts)
	vim.wo.statusline = build.statusline(opts)

	-- local statusline_gp = vim.api.nvim_create_augroup("Statusline", {
	-- 	clear = true,
	-- })
	--
	-- vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
	-- 	callback = status.active,
	-- 	group = statusline_gp,
	-- })
	--
	-- vim.api.nvim_create_autocmd({ "BufWinLeave", "WinLeave" }, {
	-- 	callback = status.inactive,
	-- 	group = statusline_gp,
	-- })
end

return M
