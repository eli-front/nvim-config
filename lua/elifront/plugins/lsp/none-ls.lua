return {
  "nvimtools/none-ls.nvim", -- configure formatters & linters
  event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
  dependencies = {
    "jose-elias-alvarez/null-ls.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local mason_null_ls = require("mason-null-ls")

    local null_ls = require("null-ls")

    local null_ls_utils = require("null-ls.utils")

    mason_null_ls.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
        "rustfmt", -- rust formatter
      },
    })

    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters
    local code_actions = null_ls.builtins.code_actions

    local eslint_config_exists = function()
      local eslint_files = { ".eslintrc.js", ".eslintrc.json", ".eslintrc.yml", ".eslintrc.yaml" }
      for _, file in ipairs(eslint_files) do
        if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. file) == 1 then
          return true
        end
      end
      return false
    end

    local sources = {
      formatting.prettier.with({
        extra_filetypes = { "svelte" },
        timeout = 10000,
      }),
      formatting.stylua,
      formatting.isort,
      formatting.black,
      -- rust
      formatting.rustfmt,
    }

    if eslint_config_exists() then
      table.insert(
        sources,
        diagnostics.eslint_d.with({
          timeout = 10000,
        })
      )
      table.insert(sources, code_actions.eslint_d.with({}))
    end

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- configure null_ls
    null_ls.setup({
      debug = true,
      -- add package.json as identifier for root (for typescript monorepos)
      root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
      -- setup formatters & linters
      sources = sources,
      -- configure format on save
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  --  only use null-ls for formatting instead of lsp server
                  return client.name == "null-ls"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })

    -- keynmaps for :LspStart and :LspStop
    local keymap = vim.keymap

    keymap.set("n", "<leader>ll", ":LspStart<CR>", { desc = "LspStart" })
    keymap.set("n", "<leader>lq", ":LspStop<CR>", { desc = "LspStop" })
  end,
}
