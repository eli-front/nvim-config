return {
{
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree", -- Lazy-load on command
    event = "VimEnter",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    config = function()
	    require('neo-tree').setup {
  		  filesystem = {
    			filtered_items = {
      			hide_dotfiles = false,
    			},
  		  },
	    }
    end
  },
}

