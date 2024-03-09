local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
}

function M.config()
  local nls = require("null-ls")
  nls.setup({
    debug = true,
    sources = {
      nls.builtins.diagnostics.hadolint,
      nls.builtins.code_actions.gitsigns,
      nls.builtins.formatting.goimports,
      nls.builtins.diagnostics.golangci_lint,
      nls.builtins.formatting.prettier.with({
        disabled_filetypes = { "json" },
      }),
      nls.builtins.formatting.stylua.with({
        filetypes = { "lua" },
      }),
      -- TODO: Find replacement
      --[[ nls.builtins.diagnostics.luacheck.with({ ]]
      --[[   extra_args = { "--globals", "vim" }, ]]
      --[[ }), ]]
      nls.builtins.formatting.shfmt,
      -- TODO: Find replacement
      --[[ nls.builtins.diagnostics.shellcheck, ]]
      nls.builtins.diagnostics.yamllint.with({
        extra_args = {
          "-d",
          "{extends: relaxed, rules: {line-length: {max: 120}}}",
        },
      }),
    },
  })

  require("mason-null-ls").setup({
    ensure_installed = {
      "hadolint@v2.12.1-beta",
    },
    automatic_installation = false,
    automatic_setup = false,
  })
end

return M
