return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  --
  { import = "astrocommunity.colorscheme.catppuccin" },
  { -- further customize the options set by the community
    "catppuccin",
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      integrations = {
        cmp = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
  },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.completion.copilot-lua" },
  { -- further customize the options set by the community
    "copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-j>",
          accept_word = false,
          accept_line = false,
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<C/>",
        },
      },
    },
  },
}
