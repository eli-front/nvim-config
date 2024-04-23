local directories = {
  notes = "~/notes",
  househunt = "~/notes/househunt",
  carhunt = "~/notes/carhunt",
  twistl = "~/notes/twistl",
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
          ["core.dirman"] = {
            config = {
              workspaces = (function()
                return directories
              end)(),
              default_workspace = "notes",
            },
          },
        },
      })

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
    keys = (function()
      local keys = {}
      for key, _ in pairs(directories) do
        table.insert(keys, {
          "<leader>n" .. key:sub(1, 1),
          "<cmd>Neorg workspace " .. key .. "<CR>",
          desc = "Neorg workspace " .. key,
        })
      end
      return keys
    end)(),
  },
}
