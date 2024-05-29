-- setup glsl
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.vert", "*.frag" }, command = "set filetype=glsl" }
)

-- setup mojo
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.mojo", "*.🔥" }, command = "set filetype=mojo" }
)

-- set conceallevel only for .md or .norg files
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.md", "*.norg" }, command = "setlocal conceallevel=2" }
)

-- change wrap breakat for .md or .norg files
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "markdown", "norg" },
  callback = function()
    -- only break at spaces / new lines
    vim.opt_local.breakat = [[ \t]]
  end,
  group = vim.api.nvim_create_augroup("FileTypeSettings", { clear = true }),
})
