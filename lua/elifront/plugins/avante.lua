return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = {
      provider = "copilot",
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
