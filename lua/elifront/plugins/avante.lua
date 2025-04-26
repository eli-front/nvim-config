return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    provider = "copilot",
    -- copilot = {
    --   endpoint = "https://api.githubcopilot.com",
    --   model = "claude-3.5-sonnet",
    --   proxy = nil, -- [protocol://]host[:port] Use this proxy
    --   allow_insecure = false, -- Allow insecure server connections
    --   timeout = 30000, -- Timeout in milliseconds
    --   temperature = 0,
    --   max_tokens = 20480,
    -- },
    vendors = {
      ["claude-3.7"] = {
        __inherited_from = "copilot",
        display_name = "copilot/claude-3.7",
        model = "claude-3.7-sonnet",
      },
      ["claude-3.5"] = {
        __inherited_from = "copilot",
        display_name = "copilot/claude-3.5",
        model = "claude-3.5-sonnet",
      },
      ["gpt-o3-mini"] = {
        __inherited_from = "copilot",
        display_name = "copilot/gpt-o3-mini",
        model = "gpt-o3-mini",
      },
    },
    auto_suggestions_provider = "claude",
    suggestion = {
      debounce = 5000,
      throttle = 600,
      file_types = {
        markdown = true,
        help = true,
        toml = true,
        oil = false,
        env = false,
      },
    },
  },
  keys = {
    { "<leader>a", "", desc = "+avante", mode = { "n", "v" } },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    -- {
    --   -- support for image pasting
    --   "HakonHarnes/img-clip.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     -- recommended settings
    --     default = {
    --       embed_image_as_base64 = false,
    --       prompt_for_file_name = false,
    --       drag_and_drop = {
    --         insert_mode = true,
    --       },
    --       -- required for Windows users
    --       use_absolute_path = true,
    --     },
    --   },
    -- },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
