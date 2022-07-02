statusline = {}

require("statusline.theme").setup("gruvbox")

status = require("statusline.status")

statusline.setup = function()
	local statusline_gp = vim.api.nvim_create_augroup("Statusline", {
		clear = true,
	})

	vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
		callback = status.active,
		group = statusline_gp,
	})

	vim.api.nvim_create_autocmd({ "BufWinLeave", "WinLeave" }, {
		callback = status.inactive,
		group = statusline_gp,
	})
end

return statusline
