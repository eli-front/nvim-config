vim.filetype.add({
  extension = {
    mdx = 'mdx'
  }
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.frag",
  callback = function()
    vim.bo.filetype = "glsl"
  end
})
