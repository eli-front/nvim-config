return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      defaults = {
        mode = { "n", "v" },
        ["<leader>"] = { name = "+which-key" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>l"] = { name = "+lsp" },
        ["<leader>c"] = { name = "+clipboard" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gd"] = { name = "+git-diff" },
        ["<leader>gh"] = { name = "+git-hunk" },
        ["<leader>p"] = { name = "+python" },
        ["<leader>d"] = { name = "+docker" },
        ["<leader>n"] = { name = "+notes" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
