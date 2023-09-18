return {
  "jose-elias-alvarez/null-ls.nvim",
  autostart = true,
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require("null-ls")

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.diagnostics.eslint_d,
      -- null_ls.builtins.diagnostics.tsc,
      -- python formatting
      null_ls.builtins.diagnostics.pylint.with({
        diagnostics_postprocess = function(diagnostic)
          diagnostic.code = diagnostic.message_id
        end,
      }),
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.black,
      -- setup c
      null_ls.builtins.formatting.clang_format,
    }

    config.on_attach = require("elifront.utils.lsp").on_attach

    return config -- return final config table
  end,
}
