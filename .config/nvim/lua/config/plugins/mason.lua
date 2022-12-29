local M = {
  "williamboman/mason.nvim",
  lazy = true,
}

function M.config()
  local mason = require("mason")
  mason.setup({})
end

return M
