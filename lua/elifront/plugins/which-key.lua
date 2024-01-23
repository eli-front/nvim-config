return {
	{
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function(wk)
    vim.o.timeout = true
    vim.o.timeoutlen = 300 
  end,
  opts = {}
  }
}
