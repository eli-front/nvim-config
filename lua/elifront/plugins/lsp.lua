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
          end,
          eslint = function()
            require("lspconfig").eslint.setup({
              cmd = { "eslint", "--stdin" },
            })
          end,
          zls = function()
            require("lspconfig").zls.setup({
              settings = {
                zls = {
                  enable_build_on_save = true,
                  build_on_save_step = "check",
                  enable_snippets = true,
                  enable_ast_check_diagnostics = true,
                  enable_autofix = false,
                  enable_import_embedfile_argument_completions = true,
                  warn_style = true,
                  enable_semantic_tokens = true,
                  enable_inlay_hints = true,
                  inlay_hints_hide_redundant_param_names = true,
                  inlay_hints_hide_redundant_param_names_last_token = true,
                  operator_completions = true,
                  include_at_in_builtins = true,
                  max_detail_length = 1048576,
                },
              },
            })
          end,
        },
      })
    end,
  },
}
