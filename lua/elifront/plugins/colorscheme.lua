return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, _)
    require('tokyonight').setup({
      style = 'storm',
      on_highlights = function(highlights, _)
        highlights.Normal = { bg = "none" }
        highlights.NormalFloat = { bg = "none" }
        highlights.NormalNC = { bg = "none" }

        -- telescope bg
        highlights.TelescopeNormal = { bg = "none" }
      end,
    })

    vim.cmd.colorscheme('tokyonight')
  end

}
