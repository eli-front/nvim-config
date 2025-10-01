return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "vimdoc", "markdown", "markdown_inline", "rust", "c", "lua", "vim", "typescript", "javascript", "html", "jsdoc", "hcl", "terraform", "json5", "svelte", "php", "css", "tsx" },
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
    })

    vim.cmd [[
        autocmd BufRead,BufNewFile *.mdx set filetype=markdown
    ]]
  end
}
