local M = {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "InsertLeave", "BufNewFile", "LspAttach" },
  config = function()
    require("lint").linters_by_ft = {
      lua = { "selene" },
      sh = { "shellcheck" },
      python = { "ruff", "mypy" },
    }
  end,
}

return M
