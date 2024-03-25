-- loaded in init.lua

vim.g.mapleader = " "
vim.g.autoformat = true

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true -- enable line wrapping
opt.linebreak = true -- wrap at word boundaries

-- don't wrap after hyphens
opt.breakat = [[\ \	;,!?]]

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- fold method
opt.foldlevel = 99 -- start with all folds open
opt.foldmethod = "indent" -- fold based on indent level
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldtext = "v:lua.custom_fold_text()"
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

local handle = io.popen("which python3")
local python3_path = handle:read("*a")
handle:close()
python3_path = python3_path:gsub("\n$", "")
vim.g.python3_host_prog = python3_path
