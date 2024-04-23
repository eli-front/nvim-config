-- loaded in init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = ","
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
-- opt.conceallevel = 2 -- conceals text (like markdown links)
-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- fold method
opt.foldlevel = 99 -- start with all folds open
-- opt.foldmethod = "indent" -- fold based on indent level
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldtext = "v:lua.custom_fold_text()"
-- opt.fillchars = {
--   foldopen = "",
--   foldclose = "",
--   -- fold = "⸱",
--   fold = " ",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

local handle = io.popen("which python3")
local python3_path = handle:read("*a")
handle:close()
python3_path = python3_path:gsub("\n$", "")
vim.g.python3_host_prog = python3_path

local function print_tree_nodes()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row = cursor_pos[1] - 1

  local lang = vim.bo.filetype
  local parser = vim.treesitter.get_parser(bufnr, lang)
  local tree = parser:parse()[1]

  if not tree then
    print("Failed to get syntax tree.")
    return
  end

  local root = tree:root()

  -- Recursive function to traverse and print each node in the syntax tree
  local function recursive_print(node, level)
    local node_type = node:type()
    local start_row, _, end_row, _ = node:range()
    -- Print only nodes that are on the same line as the cursor
    if start_row <= row and end_row >= row then
      local indent = string.rep("  ", level)
      print(indent .. node_type)
      for child in node:iter_children() do
        recursive_print(child, level + 1)
      end
    end
  end

  recursive_print(root, 0)
end

-- Command to use within Neovim
vim.api.nvim_create_user_command("PrintTreeNodes", print_tree_nodes, {})

function ShowSyntaxGroup()
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local synID = vim.fn.synID(line, col, true)
  local synGroup = vim.fn.synIDattr(synID, "name")
  local transGroup = vim.fn.synIDattr(vim.fn.synIDtrans(synID), "name")

  if synGroup == "" then
    print("No syntax group found at the cursor.")
  else
    print("Syntax: " .. synGroup .. " -> Translated: " .. transGroup)
  end
end

function ShowVisualSyntaxGroup()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local line_start, col_start = start_pos[2], start_pos[3]
  local line_end, col_end = end_pos[2], end_pos[3]

  for line = line_start, line_end do
    local start_col = (line == line_start) and col_start or 1
    local end_col = (line == line_end) and col_end or vim.fn.col("$", line)
    for col = start_col, end_col do
      local synID = vim.fn.synID(line, col, true)
      local synGroup = vim.fn.synIDattr(synID, "name")
      local transGroup = vim.fn.synIDattr(vim.fn.synIDtrans(synID), "name")
      if synGroup ~= "" then
        print("Line " .. line .. " Col " .. col .. ": Syntax: " .. synGroup .. " -> Translated: " .. transGroup)
      end
    end
  end
end

vim.api.nvim_create_user_command("ShowSyntaxGroup", ShowSyntaxGroup, {})
vim.api.nvim_create_user_command("ShowVisualSyntaxGroup", ShowVisualSyntaxGroup, {})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLineSelect", { bg = "none" })
  end,
})
