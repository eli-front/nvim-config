local core_augroup = vim.api.nvim_create_augroup("elifront_core", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at the last position it was edited earlier",
  group = core_augroup,
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

-- Prevent writing to a file literally named ':w' with ':w :w'
vim.keymap.set("c", "<CR>", function()
  local cmd = vim.fn.getcmdline()
  if cmd == "w :w" or cmd == "w:w" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
    vim.notify("Blocked accidental ':w :w'", vim.log.levels.ERROR)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
  end
end, { noremap = true, silent = true })
