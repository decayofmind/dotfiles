local M = {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      dockerfile = { "hadolint" },
      go = { "golangcilint" },
      lua = { "selene", "luacheck" },
      python = { "ruff", "mypy" },
      sh = { "shellcheck" },
    },
    linters = {
      selene = {
        args = {
          "--display-style",
          "json",
          "--config",
          vim.fn.stdpath("config") .. "/selene.toml",
          "-",
        },
      },
      yamllint = {
        args = {
          "-d",
          "{extends: relaxed, rules: {line-length: {max: 160}}",
          "--format",
          "parsable",
          "-",
        },
      },
    },
  },
  config = function(_, opts)
    local lint = require("lint")

    lint.linters_by_ft = opts.linters_by_ft
    lint.linters.yamllint.args = opts.linters.yamllint.args
    lint.linters.selene.args = opts.linters.selene.args

    vim.api.nvim_create_autocmd(opts.events, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}

return M
