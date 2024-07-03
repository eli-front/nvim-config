return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
    	config = function () 
      		local configs = require("nvim-treesitter.configs")

      		configs.setup({
			ensure_installed = { "vimdoc", "rust", "c", "lua", "vim", "typescript", "javascript", "html" },
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
		})
    	end
 }
