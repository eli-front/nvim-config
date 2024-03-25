return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      "echasnovski/mini.bufremove",
    },
    keys = {
      {
        "<leader>fe",
        function()
          -- get root dir
          local root = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")

          require("neo-tree.command").execute({ toggle = true, dir = root })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer explorer",
      },
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      -- stylua: ignore
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
      -- close all but current buffer
      {
        "<leader>ba",
        function()
          local current = vim.fn.bufnr()
          for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
            if buf.bufnr ~= current then
              vim.cmd(("bdelete %d"):format(buf.bufnr))
            end
          end
        end,
        desc = "Delete all other buffers",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
        },
      })
    end,
  },
}
