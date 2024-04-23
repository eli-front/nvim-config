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
      require("tokyonight").setup({
        style = "storm",
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { italic = false },
          variables = { italic = false },
          -- Assuming Neorg uses these groups, customize as needed:
          text = { italic = true },
          links = { italic = true },
        },
        on_highlights = function(highlights, colors)
          highlights["@markup.italic"] = { style = "italic" }
          -- NOTE:
          -- To get strikethrough working had to run this and add two settings to myterm.info
          -- infocmp $TERM > myterm.info
          -- vim myterm.info # add smxx=\E[9m, rmxx=\E[29m,
          -- tic -x myterm.info
          highlights["@markup.strikethrough"] = { strikethrough = true }
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
