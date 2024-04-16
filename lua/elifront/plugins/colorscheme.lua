return {
  {
    "rebelot/kanagawa.nvim", -- neorg needs a colorscheme with treesitter support
    config = function()
      -- vim.cmd.colorscheme("kanagawa-dragon")
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function(_, _)
      vim.cmd.colorscheme("tokyonight-storm")
    end,
  },
}
