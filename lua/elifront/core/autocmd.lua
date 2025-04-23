local core_augroup = vim.api.nvim_create_augroup("elifront_core", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at the last position it was edited earlier",
  group = core_augroup,
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

-- Prevent creating a file named ":w"
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = 'Prevent creating a file named ":w"',
  group = core_augroup,
  pattern = ":w",
  callback = function()
    vim.api.nvim_err_writeln('Error: Attempt to write a file named ":w" is prevented.')
    vim.cmd("abort") -- Abort the write operation
  end,
})
