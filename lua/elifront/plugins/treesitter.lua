return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- indent = { enable = true },
      -- autotag = { enable = true },
      ensure_installed = {
        "json",
        "java",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "c",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "vimdoc",
        "dockerfile",
        "gitignore",
        "query",
        "glsl",
        "go",
        "norg",
        "python",
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end

      require("nvim-treesitter.configs").setup(opts)
      require("nvim-treesitter.install").compilers = { "gcc-12" }

      require("nvim-treesitter.parsers").filetype_to_parsername.mojo = "python"
    end,
  },
}
