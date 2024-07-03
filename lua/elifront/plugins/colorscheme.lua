return {
	"folke/tokyonight.nvim",
  	lazy = false,
  	priority = 1000,
	opts = {},
	config = function(_,_)
		require('tokyonight').setup({
			style = 'storm',
		})


		vim.opt.termguicolors = true
		vim.cmd.colorscheme('tokyonight')

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
}
