local icons = require("elifront.core.icons")

function _G.custom_fold_text()
  -- Get the start and end lines of the fold
  local start_line = vim.v.foldstart
  local end_line = vim.v.foldend
  local fold_size = end_line - start_line + 1

  -- Get the text of the first line of the fold
  local first_line_text = vim.fn.getline(start_line)

  -- Create and return the custom foldtext
  -- Customize this string to your liking
  return string.format("➤ %s " .. icons.misc.dots .. " %d lines", first_line_text, fold_size)
end
