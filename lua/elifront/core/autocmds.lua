-- setup glsl
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.vert", "*.frag" }, command = "set filetype=glsl" }
)
