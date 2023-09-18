-- if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
--   vim.loader.enable()
-- end
--
for _, source in ipairs({
  "elifront.bootstrap",
  "elifront.options",
  "elifront.lazy",
  "elifront.autocmds",
  "elifront.mappings",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end

-- if elifront.default_colorscheme then
--   if not pcall(vim.cmd.colorscheme, elifront.default_colorscheme) then
--     require("elifront.utils").notify(
--       ("Error setting up colorscheme: `%s`"):format(elifront.default_colorscheme),
--       vim.log.levels.ERROR
--     )
--   end
-- end

vim.cmd.colorscheme("catppuccin")

-- require("elifront.utils").conditional_func(elifront.user_opts("polish", nil, false), true)
