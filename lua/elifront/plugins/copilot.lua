return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
          toml = true,
          oil = false,
          env = false,
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   branch = "main",
  --   cmd = "CopilotChat",
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua" },
  --     { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  --     {
  --       "folke/edgy.nvim",
  --       optional = true,
  --       opts = function(_, opts)
  --         opts.right = opts.right or {}
  --         table.insert(opts.right, {
  --           ft = "copilot-chat",
  --           title = "Copilot Chat",
  --           size = { width = 50 },
  --         })
  --       end,
  --     },
  --     "stevearc/dressing.nvim", -- should checkout snacks.nvim
  --   },
  --   build = "make tiktoken", -- Only on MacOS or Linux
  --   keys = {
  --     { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
  --     { "<leader>c", "", desc = "+copilot-chat", mode = { "n", "v" } },
  --     {
  --       "<leader>cc",
  --       function()
  --         return require("CopilotChat").toggle()
  --       end,
  --       desc = "Toggle (CopilotChat)",
  --       mode = { "n", "v" },
  --     },
  --     {
  --       "<leader>cx",
  --       function()
  --         return require("CopilotChat").reset()
  --       end,
  --       desc = "Clear (CopilotChat)",
  --       mode = { "n", "v" },
  --     },
  --     {
  --       "<leader>cq",
  --       function()
  --         vim.ui.input({
  --           prompt = "Quick Chat: ",
  --         }, function(input)
  --           if input ~= "" then
  --             require("CopilotChat").ask(input)
  --           end
  --         end)
  --       end,
  --       desc = "Quick Chat (CopilotChat)",
  --       mode = { "n", "v" },
  --     },
  --     {
  --       "<leader>cp",
  --       function()
  --         require("CopilotChat").select_prompt()
  --       end,
  --       desc = "Prompt Actions (CopilotChat)",
  --       mode = { "n", "v" },
  --     },
  --     {
  --       "<leader>cm",
  --       function()
  --         require("CopilotChat").select_model()
  --       end,
  --       desc = "Select Model (CopilotChat)",
  --       mode = { "n", "v" },
  --     },
  --     {
  --       "<leader>ca",
  --       function()
  --         require("CopilotChat").select_agent()
  --       end,
  --       desc = "Select Agent (CopilotChat)",
  --       mode = { "n", "v" },
  --     },
  --   },
  --   opts = function()
  --     local user = vim.env.USER or "User"
  --     user = user:sub(1, 1):upper() .. user:sub(2)
  --     return {
  --       auto_insert_mode = true,
  --       question_header = "  " .. user .. " ",
  --       answer_header = "  Copilot ",
  --       window = {
  --         width = 0.4,
  --       },
  --       mappings = {
  --         close = {
  --           insert = "<Esc>",
  --         },
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     local chat = require("CopilotChat")
  --
  --     vim.api.nvim_create_autocmd("BufEnter", {
  --       pattern = "copilot-chat",
  --       callback = function()
  --         vim.opt_local.relativenumber = false
  --         vim.opt_local.number = false
  --       end,
  --     })
  --
  --     chat.setup(opts)
  --   end,
  -- },
}
