-- goyo autocmds

local focus_gp = vim.api.nvim_create_augroup("Focus", {
  clear = true
})

vim.api.nvim_create_autocmd("User", {
  pattern = [[GoyoEnter]],
  command = [[Limelight]],
  group = focus_gp
})

vim.api.nvim_create_autocmd("User", {
  pattern = [[GoyoLeave]],
  command = [[Limelight!]],
  group = focus_gp
})
