vim.filetype.add({
  extension = {
    mdx = "mdx",
    env = "env",
    vars = "env",
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.frag",
  callback = function()
    vim.bo.filetype = "glsl"
  end,
})


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env.*", "*.env.*" },
  callback = function()
    vim.bo.filetype = "env"
  end,
})
