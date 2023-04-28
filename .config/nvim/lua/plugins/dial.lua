local M = {
  "monaqa/dial.nvim",
  keys = {
    {
      "<C-a>",
      function()
        return require("dial.map").inc_normal()
      end,
      expr = true,
    },
    {
      "<C-x>",
      function()
        return require("dial.map").dec_normal()
      end,
      expr = true,
    },
  },
}

function M.config()
  local augend = require("dial.augend")
  require("dial.config").augends:register_group({
    default = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
      augend.constant.alias.bool,
      augend.constant.new({
        elements = { "!=", "==" },
        word = false,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "Yes", "No" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "disable", "enable" },
        word = true,
        cyclic = true,
      }),
      augend.semver.alias.semver,
    },
  })
end

return M
