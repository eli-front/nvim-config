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

        -- vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>ld", function()
          vim.diagnostic.open_float(nil, {
            focus = false,
            source = true, -- <--- ensures the source is shown
            header = "Diagnostics",
          })
        end, opts)
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- <leader>yd to copy the diagnostic message of the item under the cursor
        vim.keymap.set("n", "<leader>yd", function()
          local diagnostic = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })[1]

          if diagnostic then
            vim.fn.setreg("", diagnostic.message)
            vim.notify("Copied diagnostic message to clipboard", vim.log.levels.INFO)
          else
            vim.notify("No diagnostic message found under cursor", vim.log.levels.WARN)
          end
        end, opts)
        vim.keymap.set("n", "<leader>cd", function()
          local diagnostic = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })[1]

          if diagnostic then
            vim.fn.setreg("+", diagnostic.message)
            vim.notify("Copied diagnostic message to clipboard", vim.log.levels.INFO)
          else
            vim.notify("No diagnostic message found under cursor", vim.log.levels.WARN)
          end
        end, opts)
      end)

      require("mason").setup({})
      require("mason-lspconfig").setup({
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
          -- "zls",
          "intelephense",
          "gopls"
        },
        handlers = {
          function(server_name)
            vim.lsp.config(server_name, {})
          end,
          html = function()
            vim.lsp.config("html", {
              filetypes = { "html", "php" },
              settings = {
                html = {
                  format = {
                    enable = false,
                  },
                  suggest = {
                    completion = {
                      enabled = true,
                      emmet = true,
                    },
                  },
                },
              },
            })
          end,
          jsonls = function()
            vim.lsp.config("jsonls", {
              settings = {
                json = {
                  format = {
                    enable = true,
                  },
                  schemas = require("schemastore").json.schemas(),
                  validate = { enable = true },
                },
              },
            })
          end,
          cssls = function()
            vim.lsp.config("cssls", {
              settings = {
                css = {
                  validate = true,
                  lint = {
                    unknownAtRules = "ignore",
                  }
                },
                scss = {
                  validate = true,
                  lint = {
                    unknownAtRules = "ignore",
                  }
                },
                less = {
                  validate = true,
                  lint = {
                    unknownAtRules = "ignore",
                  }
                },
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

      -- manual setup for local zls
      do
        if vim.fn.executable("zls") == 0 then
          vim.notify("No locally installed zls")
        else
          vim.lsp.config("zls", {
            cmd = { "zls" },
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
        end
      end
    end,
  },
}
