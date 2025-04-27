return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = {
      provider = "copilot",
      copilot = {
        __inherited_from = "copilot",
        endpoint = "https://api.githubcopilot.com",
        model = "claude-3.5-sonnet",
        display_name = "copilot/claude-3.5",
        proxy = nil,
        allow_insecure = false,
        timeout = 30000,
        temperature = 0,
        max_tokens = 20480,
      },
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
      }, -- <<< *** this closing brace and comma were missing ***
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
    version = false,
    keys = {
      { "<leader>a", desc = "+avante", mode = { "n", "v" } }, -- <-- fixed
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
      -- Uncomment carefully if you want to use:
      -- {
      --   "HakonHarnes/img-clip.nvim",
      --   event = "VeryLazy",
      --   opts = {
      --     default = {
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name = false,
      --       drag_and_drop = { insert_mode = true },
      --       use_absolute_path = true,
      --     },
      --   },
      -- },
    },
  },
}
