return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/nvim-cmp" },
      { "zbirenbaum/copilot.lua" },
      { "zbirenbaum/copilot-cmp" },
      { "L3MON4D3/LuaSnip" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "b0o/schemastore.nvim" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")

      lsp_zero.on_attach(function(_client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })

        local opts = { buffer = bufnr }

        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      end)

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "lua_ls", "ts_ls", "clangd", "jsonls", "html", "cssls", "tailwindcss", "eslint", "emmet_ls", "rust_analyzer", "tflint", "terraformls", "svelte", "zls" },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          jsonls = function()
            -- jsonls = {
            --       -- lazy-load schemastore when needed
            --       on_new_config = function(new_config)
            --         new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            --         vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            --       end,
            --       settings = {
            --         json = {
            --           format = {
            --             enable = true,
            --           },
            --           validate = { enable = true },
            --         },
            --       },
            --     },
            require("lspconfig").jsonls.setup({
              settings = {
                json = {
                  format = {
                    enable = true,
                  },
                  schemas = require('schemastore').json.schemas(),
                  validate = { enable = true },
                },
              },
            })
          end,
          cssls = function()
            require("lspconfig").cssls.setup({
              settings = {
                css = {
                  validate = false,
                  lint = {
                    uknownAtRules = "ignore",
                  },
                },
                scss = {
                  validate = false,
                  lint = {
                    uknownAtRules = "ignore",
                  },
                },
                less = {
                  validate = false,
                  lint = {
                    uknownAtRules = "ignore",
                  },
                },
              },
            })
          end
        },
      })
    end,
  },
}
