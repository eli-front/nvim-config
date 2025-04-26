local core_augroup = vim.api.nvim_create_augroup("elifront_core", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at the last position it was edited earlier",
  group = core_augroup,
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

-- Prevent writing to a file literally named ':w'
vim.api.nvim_create_autocmd("BufWriteCmd", {
  desc = 'Prevent creating a file named ":w"',
  group = core_augroup,
  callback = function()
    local filename = vim.fn.expand("<afile>")
    if filename == ":w" then
      vim.notify('Error: Attempt to write a file named ":w" is prevented.', vim.log.levels.ERROR)
      return -- Cancel the write operation
    end
    vim.cmd("write") -- Proceed with the write operation for other files
  end,
})

-- Create a command to handle the common mistype of ":w :w"
vim.api.nvim_create_user_command("W", function(opts)
  if opts.args:match("^:w$") then
    vim.notify('Command ":w :w" corrected to ":w"', vim.log.levels.INFO)
    vim.cmd("write")
  else
    vim.cmd("write " .. opts.args)
  end
end, { nargs = "?" })
