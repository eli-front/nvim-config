-- setup glsl
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.vert", "*.frag" }, command = "set filetype=glsl" }
)

-- set conceallevel only for .md or .norg files
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.md", "*.norg" }, command = "setlocal conceallevel=2" }
)
