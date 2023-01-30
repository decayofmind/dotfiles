local M = {
  "ggandor/leap.nvim",
  event = "VeryLazy",

  dependencies = {
    { "ggandor/flit.nvim", config = { labeled_modes = "nv" } },
  },

  config = function()
    -- TODO: Resolve conflicts with nvim-surround keybinds
    require("leap").add_default_mappings()
  end,
}

return M
