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
