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

        -- unused import
        highlights.DiagnosticUnnecessary = { fg = "#4e95a8" }

        -- git blame
        -- highlights.GitBlame = { fg = "#4e95a8" }
        highlights.GitBlame = { fg = "#4b506d", bg = "none" }
      end,
    })

    vim.cmd.colorscheme('tokyonight')
  end

}
