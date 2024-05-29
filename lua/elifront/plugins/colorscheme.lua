return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function(_, _)
      require("tokyonight").setup({
        style = "storm",
        on_highlights = function(highlights, colors)
          highlights["@markup.italic"] = { style = "italic" }
          -- NOTE:
          -- To get strikethrough working had to run this and add two settings to myterm.info
          -- infocmp $TERM > myterm.info
          -- vim myterm.info # add smxx=\E[9m, rmxx=\E[29m,
          -- tic -x myterm.info
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
