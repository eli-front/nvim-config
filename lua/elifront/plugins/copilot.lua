return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
          norg = false,
          toml = true,
        },
      })
    end,
  },
  {
    "nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        -- opts = {},
        -- config = function(_, opts)
        --   local copilot_cmp = require("copilot_cmp")
        --   vim.api.nvim_create_autocmd("LspAttach", {
        --     callback = function(args)
        --       local client = vim.lsp.get_client_by_id(args.data.client_id)
        --       if client.name == "copilot" then
        --         copilot_cmp._on_insert_enter({})
        --       end
        --     end,
        --   })
        --
        --   copilot_cmp.setup(opts)
        -- end,
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
  },
}
