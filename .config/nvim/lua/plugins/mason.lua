local M = {
  "williamboman/mason.nvim",
  lazy = true,
}

function M.config()
  local mason = require("mason")
  mason.setup({
    log_level = vim.log.levels.DEBUG,
    providers = {
      "mason.providers.registry-api",
      "mason.providers.client"
    }
  })

end

return M
