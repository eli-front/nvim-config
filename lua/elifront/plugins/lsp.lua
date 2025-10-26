return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
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
      -- Setup diagnostics
      vim.diagnostic.config({
        virtual_text = false,
        float = { border = "rounded" },
        update_in_insert = false,
        severity_sort = true,
      })


      local opts = {}

      vim.keymap.set("n", "<leader>ld", function()
        vim.diagnostic.open_float(nil, {
          focus = false,
          source = true,
          header = "Diagnostics",
        })
      end, opts)

      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)

      vim.keymap.set("n", "<leader>yd", function()
        local diagnostic = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })[1]
        if diagnostic then
          vim.fn.setreg("", diagnostic.message)
          vim.notify("Copied diagnostic message to unnamed register", vim.log.levels.INFO)
        else
          vim.notify("No diagnostic message under cursor", vim.log.levels.WARN)
        end
      end, opts)

      vim.keymap.set("n", "<leader>cd", function()
        local diagnostic = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
        -- if diagnostic then
        if diagnostic[1] then
          -- all of the diagnostics messages under the cursor joined
          local joined_messages = table.concat(vim.tbl_map(function(d)
            return d.message
          end, diagnostic), "\n")

          -- vim.fn.setreg("+", diagnostic.message)
          vim.fn.setreg("+", joined_messages)
          vim.notify("Copied diagnostic message to clipboard", vim.log.levels.INFO)
        else
          vim.notify("No diagnostic message under cursor", vim.log.levels.WARN)
        end
      end, opts)
      -- end


      -- Setup Mason
      require("mason").setup({})
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = {
          "pyright",
          "lua_ls",
          "ts_ls",
          "clangd",
          "jsonls",
          "html",
          "cssls",
          "tailwindcss",
          "eslint",
          "emmet_ls",
          "rust_analyzer",
          "tflint",
          "terraformls",
          "svelte",
          "intelephense",
          "gopls",
        },
        handlers = {
          function(server_name)
            vim.lsp.config(server_name, {
              -- on_attach = on_attach,
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
          end,

          html = function()
            vim.lsp.config("html", {
              filetypes = { "html", "php" },
              settings = {
                html = {
                  format = { enable = false },
                  suggest = { completion = { enabled = true, emmet = true } },
                },
              },
            })
          end,

          jsonls = function()
            vim.lsp.config("jsonls", {
              settings = {
                json = {
                  format = { enable = true },
                  schemas = require("schemastore").json.schemas(),
                  validate = { enable = true },
                },
              },
            })
          end,

          cssls = function()
            vim.lsp.config("cssls", {
              settings = {
                css = { validate = true, lint = { unknownAtRules = "ignore" } },
                scss = { validate = true, lint = { unknownAtRules = "ignore" } },
                less = { validate = true, lint = { unknownAtRules = "ignore" } },
              },
            })
          end,

          intelephense = function()
            vim.lsp.config("intelephense", {
              settings = {
                intelephense = {
                  stubs = {
                    "wordpress",
                    "bcmath",
                    "bz2",
                    "calendar",
                    "Core",
                    "curl",
                    "date",
                    "dom",
                    "standard",
                  },
                },
              },
            })
          end,

          ts_ls = function()
            vim.lsp.config("ts_ls", {
              -- on_attach = on_attach,
              init_options = {
                preferences = {
                  importModuleSpecifier = "non-relative",
                  importModuleSpecifierPreference = "non-relative",
                },
              },
            })
          end,
        },
      })

      -- Optional ZLS setup
      if vim.fn.executable("zls") == 1 then
        vim.lsp.config("zls", {
          cmd = { "zls" },
          filetypes = { "zig", "zir" },
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

        vim.lsp.enable("zls")
      else
        vim.notify("No locally installed zls", vim.log.levels.WARN)
      end
    end,
  },
}
