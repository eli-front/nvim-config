local directories = {
  notes = "~/notes",
  daily = "~/notes/daily",
  crm = "~/notes/crm",
  projects = "~/notes/projects",
  kicker = "~/notes/kicker",
}

return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    version = "*",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.export"] = {
            config = {
              export_dir = "~/exported_notes", -- Define directory for exported files
              extensions = "md", -- Default export extension
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = (function()
                return directories
              end)(),
              default_workspace = "notes",
            },
          },
          ["core.journal"] = {
            config = {
              workspace = "daily",
              strategy = "nested",
            },
          },
        },
      })

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
    keys = (function()
      local keys = {}

      -- export
      table.insert(keys, {
        "<leader>ne",
        "<cmd>Neorg export<CR>",
        desc = "Neorg export",
      })

      -- goto daily today journal
      table.insert(keys, {
        "<leader>njt",
        "<cmd>Neorg journal today<CR>",
        desc = "Neorg journal today",
      })

      -- goto daily yesterday journal
      table.insert(keys, {
        "<leader>njy",
        "<cmd>Neorg journal yesterday<CR>",
        desc = "Neorg journal yesterday",
      })

      -- goto daily tomorrow journal
      table.insert(keys, {
        "<leader>njm",
        "<cmd>Neorg journal tomorrow<CR>",
        desc = "Neorg journal tomorrow",
      })

      -- table of contents
      table.insert(keys, {
        "<leader>nco",
        "<cmd>Neorg journal toc open<CR>",
        desc = "Neorg open table of contents",
      })

      table.insert(keys, {
        "<leader>ncm",
        "<cmd>Neorg journal toc update<CR>",
        desc = "Neorg update table of contents",
      })

      for key, _ in pairs(directories) do
        table.insert(keys, {
          "<leader>nw" .. key:sub(1, 1),
          "<cmd>Neorg workspace " .. key .. "<CR>",
          desc = "Neorg workspace " .. key,
        })
      end
      return keys
    end)(),
  },
}
