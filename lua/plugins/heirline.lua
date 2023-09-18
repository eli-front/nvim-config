return {
  "rebelot/heirline.nvim",
  event = "BufEnter",
  opts = function()
    local status = require("elifront.utils.status")
    return {
      opts = {
        disable_winbar_cb = function(args)
          return not require("elifront.utils.buffer").is_valid(args.buf)
              or status.condition.buffer_matches({
                buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
                filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
              }, args.buf)
        end,
      },
      statusline = { -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch(),
        status.component.file_info({ filetype = {}, filename = false, file_modified = false }),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.nav(),
        status.component.mode({ surround = { separator = "right" } }),
      },
      winbar = { -- winbar
        init = function(self)
          self.bufnr = vim.api.nvim_get_current_buf()
        end,
        fallthrough = false,
        {
          condition = function()
            return not status.condition.is_active()
          end,
          status.component.separated_path(),
          status.component.file_info({
            file_icon = { hl = status.hl.file_icon("winbar"), padding = { left = 0 } },
            file_modified = false,
            file_read_only = false,
            hl = status.hl.get_attributes("winbarnc", true),
            surround = false,
            update = "BufEnter",
          }),
        },
        status.component.breadcrumbs({ hl = status.hl.get_attributes("winbar", true) }),
      },
      tabline = { -- bufferline
        {      -- file tree padding
          condition = function(self)
            self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
            return status.condition.buffer_matches(
              { filetype = { "aerial", "dapui_.", "dap-repl", "neo%-tree", "NvimTree", "edgy" } },
              vim.api.nvim_win_get_buf(self.winid)
            )
          end,
          provider = function(self)
            return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1)
          end,
          hl = { bg = "tabline_bg" },
        },
        status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
        status.component.fill({ hl = { bg = "tabline_bg" } }),          -- fill the rest of the tabline with background color
        {                                                               -- tab list
          condition = function()
            return #vim.api.nvim_list_tabpages() >= 2
          end,                      -- only show tabs if there are more than one
          status.heirline.make_tablist({ -- component for each tab
            provider = status.provider.tabnr(),
            hl = function(self)
              return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true)
            end,
          }),
          { -- close button for current tab
            provider = status.provider.close_button({
              kind = "TabClose",
              padding = { left = 1, right = 1 },
            }),
            hl = status.hl.get_attributes("tab_close", true),
            on_click = {
              callback = function()
                require("elifront.utils.buffer").close_tab()
              end,
              name = "heirline_tabline_close_tab_callback",
            },
          },
        },
      },
      statuscolumn = vim.fn.has("nvim-0.9") == 1 and {
        status.component.foldcolumn(),
        status.component.fill(),
        status.component.numbercolumn(),
        status.component.signcolumn(),
      } or nil,
    }
  end,
  config = function(_, opts)
    local heirline = require("heirline")
    local C = require("elifront.utils.status.env").fallback_colors
    local get_hlgroup = require("elifront.utils").get_hlgroup
    local lualine_mode = require("elifront.utils.status.hl").lualine_mode
    local function resolve_lualine(orig, ...)
      return (not orig or orig == "NONE") and lualine_mode(...) or orig
    end

    local function setup_colors()
      local Normal = get_hlgroup("Normal", { fg = C.fg, bg = C.bg })
      local Comment = get_hlgroup("Comment", { fg = C.bright_grey, bg = C.bg })
      local Error = get_hlgroup("Error", { fg = C.red, bg = C.bg })
      local StatusLine = get_hlgroup("StatusLine", { fg = C.fg, bg = C.dark_bg })
      local TabLine = get_hlgroup("TabLine", { fg = C.grey, bg = C.none })
      local TabLineFill = get_hlgroup("TabLineFill", { fg = C.fg, bg = C.dark_bg })
      local TabLineSel = get_hlgroup("TabLineSel", { fg = C.fg, bg = C.none })
      local WinBar = get_hlgroup("WinBar", { fg = C.bright_grey, bg = C.bg })
      local WinBarNC = get_hlgroup("WinBarNC", { fg = C.grey, bg = C.bg })
      local Conditional = get_hlgroup("Conditional", { fg = C.bright_purple, bg = C.dark_bg })
      local String = get_hlgroup("String", { fg = C.green, bg = C.dark_bg })
      local TypeDef = get_hlgroup("TypeDef", { fg = C.yellow, bg = C.dark_bg })
      local GitSignsAdd = get_hlgroup("GitSignsAdd", { fg = C.green, bg = C.dark_bg })
      local GitSignsChange = get_hlgroup("GitSignsChange", { fg = C.orange, bg = C.dark_bg })
      local GitSignsDelete = get_hlgroup("GitSignsDelete", { fg = C.bright_red, bg = C.dark_bg })
      local DiagnosticError = get_hlgroup("DiagnosticError", { fg = C.bright_red, bg = C.dark_bg })
      local DiagnosticWarn = get_hlgroup("DiagnosticWarn", { fg = C.orange, bg = C.dark_bg })
      local DiagnosticInfo = get_hlgroup("DiagnosticInfo", { fg = C.white, bg = C.dark_bg })
      local DiagnosticHint = get_hlgroup("DiagnosticHint", { fg = C.bright_yellow, bg = C.dark_bg })
      local HeirlineInactive =
          resolve_lualine(get_hlgroup("HeirlineInactive", { bg = nil }).bg, "inactive", C.dark_grey)
      local HeirlineNormal = resolve_lualine(get_hlgroup("HeirlineNormal", { bg = nil }).bg, "normal", C.blue)
      local HeirlineInsert = resolve_lualine(get_hlgroup("HeirlineInsert", { bg = nil }).bg, "insert", C.green)
      local HeirlineVisual = resolve_lualine(get_hlgroup("HeirlineVisual", { bg = nil }).bg, "visual", C.purple)
      local HeirlineReplace =
          resolve_lualine(get_hlgroup("HeirlineReplace", { bg = nil }).bg, "replace", C.bright_red)
      local HeirlineCommand =
          resolve_lualine(get_hlgroup("HeirlineCommand", { bg = nil }).bg, "command", C.bright_yellow)
      local HeirlineTerminal =
          resolve_lualine(get_hlgroup("HeirlineTerminal", { bg = nil }).bg, "insert", HeirlineInsert)

      local colors = {
        close_fg = Error.fg,
        fg = StatusLine.fg,
        bg = StatusLine.bg,
        section_fg = StatusLine.fg,
        section_bg = StatusLine.bg,
        git_branch_fg = Conditional.fg,
        mode_fg = StatusLine.bg,
        treesitter_fg = String.fg,
        scrollbar = TypeDef.fg,
        git_added = GitSignsAdd.fg,
        git_changed = GitSignsChange.fg,
        git_removed = GitSignsDelete.fg,
        diag_ERROR = DiagnosticError.fg,
        diag_WARN = DiagnosticWarn.fg,
        diag_INFO = DiagnosticInfo.fg,
        diag_HINT = DiagnosticHint.fg,
        winbar_fg = WinBar.fg,
        winbar_bg = WinBar.bg,
        winbarnc_fg = WinBarNC.fg,
        winbarnc_bg = WinBarNC.bg,
        tabline_bg = TabLineFill.bg,
        tabline_fg = TabLineFill.bg,
        buffer_fg = Comment.fg,
        buffer_path_fg = WinBarNC.fg,
        buffer_close_fg = Comment.fg,
        buffer_bg = TabLineFill.bg,
        buffer_active_fg = Normal.fg,
        buffer_active_path_fg = WinBarNC.fg,
        buffer_active_close_fg = Error.fg,
        buffer_active_bg = Normal.bg,
        buffer_visible_fg = Normal.fg,
        buffer_visible_path_fg = WinBarNC.fg,
        buffer_visible_close_fg = Error.fg,
        buffer_visible_bg = Normal.bg,
        buffer_overflow_fg = Comment.fg,
        buffer_overflow_bg = TabLineFill.bg,
        buffer_picker_fg = Error.fg,
        tab_close_fg = Error.fg,
        tab_close_bg = TabLineFill.bg,
        tab_fg = TabLine.fg,
        tab_bg = TabLine.bg,
        tab_active_fg = TabLineSel.fg,
        tab_active_bg = TabLineSel.bg,
        inactive = HeirlineInactive,
        normal = HeirlineNormal,
        insert = HeirlineInsert,
        visual = HeirlineVisual,
        replace = HeirlineReplace,
        command = HeirlineCommand,
        terminal = HeirlineTerminal,
      }

      for _, section in ipairs({
        "git_branch",
        "file_info",
        "git_diff",
        "diagnostics",
        "lsp",
        "macro_recording",
        "mode",
        "cmd_info",
        "treesitter",
        "nav",
      }) do
        if not colors[section .. "_bg"] then
          colors[section .. "_bg"] = colors["section_bg"]
        end
        if not colors[section .. "_fg"] then
          colors[section .. "_fg"] = colors["section_fg"]
        end
      end
      return colors
    end

    heirline.load_colors(setup_colors())
    heirline.setup(opts)

    local augroup = vim.api.nvim_create_augroup("Heirline", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "AstroColorScheme",
      group = augroup,
      desc = "Refresh heirline colors",
      callback = function()
        require("heirline.utils").on_colorscheme(setup_colors())
      end,
    })
  end,
  buffer_active = { bold = false, italic = false },
}
