return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      " ",
      "    ███    ██ ██    ██ ██ ███    ███",
      "    ████   ██ ██    ██ ██ ████  ████",
      "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
      "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
      "    ██   ████   ████   ██ ██      ██",
      " ",
    }
    dashboard.section.header.opts.hl = "DashboardHeader"

    local button = require("elifront.utils").alpha_button
    local get_icon = require("elifront.utils").get_icon
    dashboard.section.buttons.val = {
      button("LDR n  ", get_icon("FileNew", 2) .. "New File  "),
      button("LDR f f", get_icon("Search", 2) .. "Find File  "),
      button("LDR f o", get_icon("DefaultFile", 2) .. "Recents  "),
      button("LDR f w", get_icon("WordFile", 2) .. "Find Word  "),
      button("LDR f '", get_icon("Bookmarks", 2) .. "Bookmarks  "),
      button("LDR S l", get_icon("Refresh", 2) .. "Last Session  "),
    }

    dashboard.config.layout[1].val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })
    dashboard.config.layout[3].val = 5
    dashboard.config.opts.noautocmd = true
    return dashboard
  end,

  config = function(_, opts)
    require("alpha").setup(opts.config)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      desc = "Add Alpha dashboard footer",
      once = true,
      callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
        opts.section.footer.val =
        { " ", " ", " ", "lazy.nvim loaded " .. stats.count .. " plugins  in " .. ms .. "ms" }
        opts.section.footer.opts.hl = "DashboardFooter"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
