local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
}

function M.config()
  local nls = require("null-ls")
  nls.setup({
    sources = {
      nls.builtins.code_actions.gitsigns,
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.prettier.with({
        disabled_filetypes = { "json" },
      }),
      nls.builtins.formatting.stylua.with({
        filetypes = { "lua" },
      }),
      nls.builtins.diagnostics.luacheck.with({
        extra_args = { "--globals", "vim" },
      }),
      nls.builtins.formatting.shfmt,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.yamllint.with({
        extra_args = {
          "-d",
          "{extends: relaxed, rules: {line-length: {max: 120}}}",
        },
      }),
    },
  })

  require("mason-null-ls").setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = false,
  })
end

return M
