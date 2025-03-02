local core_augroup = vim.api.nvim_create_augroup('elifront_core', { clear = true })

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Open file at the last position it was edited earlier',
  group = core_augroup,
  pattern = '*',
  command = 'silent! normal! g`"zv'
})
